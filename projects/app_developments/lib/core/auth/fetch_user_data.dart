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

    String firstName = userDoc['firstName'];
    String lastName = userDoc['lastName'];
    String profileImageUrl = userDoc['profile_image_url'];
    String phoneNumber = userDoc['phoneNumber'];
    String schoolName = userDoc['schoolName'];
    String email = FirebaseAuth.instance.currentUser?.email ??
        ''; // Fetch email from FirebaseAuth

    return {
      'firstName': firstName,
      'lastName': lastName,
      'profileImageUrl': profileImageUrl,
      'phoneNumber': phoneNumber,
      'schoolName': schoolName,
      'email': email,
    };
  }
}
