import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FetchUserData {
  Future<Map<String, String>> fetchUserData() async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      throw Exception("No user logged in");
    }

    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    if (!userDoc.exists) {
      throw Exception("User data not found");
    }

    String name = userDoc['name'];
    String profileImageUrl = userDoc['profile_image_url'];
    String phoneNumber = userDoc['phoneNumber'];
    String gender = userDoc['gender'];
    String email = FirebaseAuth.instance.currentUser?.email ??
        ''; // Fetch email from FirebaseAuth

    // Create the map of user data
    Map<String, String> userData = {
      'firstName': name,
      'profileImageUrl': profileImageUrl,
      'phoneNumber': phoneNumber,
      'gender': gender,
      'email': email,
    };

    // Return the user data
    return userData;
  }
}
