import 'dart:convert';
import 'dart:core';
import 'package:app_developments/core/auth/authentication_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  bool isRequestingPermission = false; // Track if a request is in progress

// Initialise notifications
  Future<void> initNotifications() async {
    // Check if the user is logged in
    String? userId = AuthenticationRepository().getCurrentUserId();
    if (userId == null) {
      return; // Exit the function if the user is not logged in
    }

    // If a permission request is already running, return early
    if (isRequestingPermission) {
      return;
    }

    // Set the flag to true to indicate a request is in progress
    isRequestingPermission = true;

    try {
      // Request permission from the user
      NotificationSettings settings =
          await _firebaseMessaging.requestPermission();

      // Check the permission status
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        // Fetch the token
        final fCMToken = await FirebaseMessaging.instance.getToken();

        // Save the token to Firestore if it's not null
        if (fCMToken != null) {
          // Fetch existing tokens from Firestore
          DocumentSnapshot userDoc = await FirebaseFirestore.instance
              .collection("users")
              .doc(userId)
              .get();

          // Get the existing tokens array or create a new one if it's not present
          List<dynamic> tokens = userDoc['tokens'] ?? [];

          // Check if the token already exists in the array
          if (!tokens.contains(fCMToken)) {
            // Add the new token to the tokens array
            tokens.add(fCMToken);

            // Update the user's document in Firestore with the new tokens array
            await FirebaseFirestore.instance
                .collection("users")
                .doc(userId)
                .update({
              'tokens': tokens,
            });
          }
        }
      } else if (settings.authorizationStatus == AuthorizationStatus.denied) {
        // Handle denied permission (e.g., show a message)
      } else {
        if (!kReleaseMode) {
          print('Permission status is not determined or restricted');
        }
        // Handle other cases (e.g., not determined)
      }
    } catch (e) {
      throw Exception(e);
    } finally {
      // Set the flag back to false after the request is complete
      isRequestingPermission = false;
    }
  }

  // Function to remove the current device's token
  Future<void> removeCurrentDeviceToken() async {
    // Check if the user is logged in
    String? userId = AuthenticationRepository().getCurrentUserId();
    if (userId == null) {
      return; // Exit the function if the user is not logged in
    }

    try {
      // Fetch the current FCM token for this device
      final fCMToken = await FirebaseMessaging.instance.getToken();

      // Proceed only if the token is not null
      if (fCMToken != null) {
        // Fetch the existing tokens from Firestore
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection("users")
            .doc(userId)
            .get();

        // Get the existing tokens array or create an empty one if it's not present
        List<dynamic> tokens = userDoc['tokens'] ?? [];

        // Check if the token exists in the array
        if (tokens.contains(fCMToken)) {
          // Remove the token from the array
          tokens.remove(fCMToken);

          // Update the user's document in Firestore with the new tokens array
          await FirebaseFirestore.instance
              .collection("users")
              .doc(userId)
              .update({
            'tokens': tokens,
          });
        }
      }
    } catch (e) {
      throw Exception(e);
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

  // Send push notifications
  Future<void> sendPushMessage(
      String userId, List<String> tokens, String body, String title) async {
    try {
      // Step 1: Get the user's document from Firestore
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userDoc.exists) {
        // Fetch the access token (server key)
        final String serverKey = await getAccessToken();
        String endPointFirebaseCloudMessaging =
            'https://fcm.googleapis.com/v1/projects/owemate-41f03/messages:send';

        // Step 2: Iterate through the list of tokens and send a notification to each
        for (String token in tokens) {
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
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $serverKey',
            },
            body: jsonEncode(message),
          );

          if (response.statusCode == 200) {
            if (!kReleaseMode) {
              print('Notification sent successfully to token: $token');
            }
          } else {
            if (!kReleaseMode) {
              print('Notification failed for token $token: ${response.body}');
            }

            // Handle specific error codes like UNREGISTERED
            final responseBody = jsonDecode(response.body);
            if (responseBody['error']?['details'] != null &&
                responseBody['error']['details']
                    .any((detail) => detail['errorCode'] == 'UNREGISTERED')) {
              // Token is invalid, remove it from Firestore
              await FirebaseFirestore.instance
                  .collection('users')
                  .doc(userId)
                  .update({
                'tokens': FieldValue.arrayRemove([token]),
              });
              if (!kReleaseMode) {
                print('Token $token was invalid and removed from Firestore.');
              }
            }
          }
        }
      } else {
        if (!kReleaseMode) {
          print('User document does not exist.');
        }
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
