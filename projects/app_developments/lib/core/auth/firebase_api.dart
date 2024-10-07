import 'dart:convert';
import 'dart:core';
import 'package:app_developments/core/auth/authentication_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  // Initialise notifications
  Future<void> initNotifications() async {
    // Check if the user is logged in
    String? userId = AuthenticationRepository().getCurrentUserId();
    if (userId == null) {
      return; // Exit the function if the user is not logged in
    }

    // Request permission from user
    NotificationSettings settings =
        await _firebaseMessaging.requestPermission();

    // Fetch the token
    final fCMToken = await FirebaseMessaging.instance.getToken();

    // Save token
    if (fCMToken != null) {
      await FirebaseFirestore.instance.collection("users").doc(userId).update(
        {
          'token': fCMToken,
        },
      );
    }
  }

  // Initialise notifications
  Future<String> getAccessToken() async {
    // Request permission from user
    await _firebaseMessaging.requestPermission();

    // Fetch the token
    final Map<String, dynamic> serviceAccountJson = {
      "type": "service_account",
      "project_id": dotenv.env['FIREBASE_PROJECT_ID'],
      "private_key_id": dotenv.env['FIREBASE_PRIVATE_KEY_ID'],
      "private_key": dotenv.env['FIREBASE_PRIVATE_KEY'],
      "client_email": dotenv.env['FIREBASE_CLIENT_EMAIL'],
      "client_id": dotenv.env['FIREBASE_CLIENT_ID'],
      "auth_uri": dotenv.env['FIREBASE_AUTH_URI'],
      "token_uri": dotenv.env['FIREBASE_TOKEN_URI'],
      "auth_provider_x509_cert_url":
          dotenv.env['FIREBASE_AUTH_PROVIDER_CERT_URL'],
      "client_x509_cert_url": dotenv.env['FIREBASE_CLIENT_CERT_URL'],
      "universe_domain": "googleapis.com",
    };

    List<String> scopes = [
      dotenv.env['FCM_API_SCOPE']!,
      dotenv.env['FCM_DB_SCOPE']!,
    ];

    http.Client client = await auth.clientViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
      scopes,
    );

    // Get the acess token
    auth.AccessCredentials credentials =
        await auth.obtainAccessCredentialsViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
      scopes,
      client,
    );

    client.close();
    return credentials.accessToken.data;
  }

  // Send push notification using FCM
  Future<void> sendPushMessage(String token, String body, String title) async {
    try {
      final String serverKey = await getAccessToken();
      String endPointFirebaseCloudMessaging =
          'https://fcm.googleapis.com/v1/projects/owemate-41f03/messages:send';

      final Map<String, dynamic> message = {
        'message': {
          'token': token,
          'notification': {
            'title': title,
            'body': body,
          },
        }
      };

      final http.Response response = await http.post(
        Uri.parse(endPointFirebaseCloudMessaging),
        headers: <String, String>{
          'content-Type': 'application/json',
          'Authorization': 'Bearer $serverKey',
        },
        body: jsonEncode(message),
      );

      if (response.statusCode == 200) {
        print('Notification Sent Succesfully');
      } else {
        print('Notification Failed');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
