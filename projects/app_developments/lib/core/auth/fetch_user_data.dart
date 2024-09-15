import 'package:app_developments/core/auth/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FetchUserData {
  Future<Map<String, dynamic>> fetchUserData({String? userId}) async {
    // If no userId is provided, use the current logged-in user's ID
    userId ??= FirebaseAuth.instance.currentUser?.uid;

    if (userId == null) {
      throw Exception("No user ID provided or no user logged in");
    }

    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    if (!userDoc.exists) {
      throw Exception("User data not found");
    }

    String name = userDoc['name'];
    String profileImageUrl = userDoc['profile_image_url'];
    String gender = userDoc['gender'];
    List friendsList = userDoc['friendsList'];
    List requestList = userDoc['requestList'];
    List requestedMoney = userDoc['requestedMoney'];
    List owedMoney = userDoc['owedMoney'];
    String email = FirebaseAuth.instance.currentUser?.email ?? '';

    Map<String, dynamic> userData = {
      'firstName': name,
      'profileImageUrl': profileImageUrl,
      'gender': gender,
      'email': email,
      'friendsList': friendsList,
      'requestList': requestList,
      'requestedMoney': requestedMoney,
      'owedMoney': owedMoney,
    };

    return userData;
  }

  Future<List<Map<String, String>>> fetchAllUsersData() async {
    // Get the current user ID
    String currentUserId = AuthenticationRepository().getCurrentUserId()!;

    // Fetch all users' data
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('users').get();

    List<Map<String, String>> allUsersData = [];

    for (var doc in querySnapshot.docs) {
      String userId = doc.id; // Get the user ID

      // Skip the current user
      if (userId == currentUserId) {
        continue;
      }

      // Retrieve user data
      String name = doc['name'];
      String profileImageUrl = doc['profile_image_url'];
      String gender = doc['gender'];

      // Include the user ID in the data map
      Map<String, String> userData = {
        'userId': userId,
        'Name': name,
        'profileImageUrl': profileImageUrl,
        'gender': gender,
      };

      allUsersData.add(userData);
    }

    return allUsersData;
  }

  Future<List<Map<String, String>>> fetchFriends() async {
    // Get the current user ID
    String currentUserId = AuthenticationRepository().getCurrentUserId()!;

    // Fetch the current user's document
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserId)
        .get();

    if (!userDoc.exists) {
      throw Exception("User data not found");
    }

    // Get the friends list from the user's document
    List<dynamic> friendsList = userDoc['friendsList'] ?? [];

    List<Map<String, String>> friendsData = [];

    for (String friendId in friendsList) {
      // Fetch each friend's data
      DocumentSnapshot friendDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(friendId)
          .get();

      if (friendDoc.exists) {
        String name = friendDoc['name'];
        String profileImageUrl = friendDoc['profile_image_url'];
        String gender = friendDoc['gender'];

        // Include the friend ID in the data map
        Map<String, String> friendData = {
          'userId': friendId,
          'Name': name,
          'profileImageUrl': profileImageUrl,
          'gender': gender,
        };

        friendsData.add(friendData);
      }
    }

    return friendsData;
  }
}
