// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:app_developments/app/views/view_add_friends/view_model/add_friends_event.dart';
import 'package:app_developments/app/views/view_add_friends/view_model/add_friends_state.dart';
import 'package:app_developments/core/auth/authentication_repository.dart';
import 'package:app_developments/core/auth/fetch_user_data.dart';
import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:app_developments/core/widgets/custom_flutter_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore package
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

class AddFriendsViewModel extends Bloc<AddFriendsEvent, AddFriendsState> {
  final TextEditingController searchFriendsController = TextEditingController();
  final FetchUserData fetchUserDataService = FetchUserData();
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance; // Firestore instance
  List<Map<String, String>> allUsers = [];
  bool requetsSent = false;

  AddFriendsViewModel() : super(AddFriendsInitialState()) {
    on<AddFriendsInitialEvent>(_initial);
    on<AddFriendsFetchAllUsersEvent>(_fetchAllUsers);
    on<AddFriendsToListEvent>(_sendRequest);
    on<AddFriendsInviteEvent>(_inviteFriends);
  }

  FutureOr<void> _initial(
      AddFriendsInitialEvent event, Emitter<AddFriendsState> emit) {}

  FutureOr<void> _fetchAllUsers(
      AddFriendsFetchAllUsersEvent event, Emitter<AddFriendsState> emit) async {
    try {
      // Clear the list before fetching new data
      allUsers.clear();

      // Fetch all users' data
      allUsers = await fetchUserDataService.fetchAllUsersData();

      // Fetch the current user's friends list
      List<Map<String, String>> friendsList =
          await fetchUserDataService.fetchFriends();

      // Filter users by name based on the search query and exclude friends
      String query = searchFriendsController.text.trim().toLowerCase();

      List<Map<String, String>> matchedUsers;
      if (query.isEmpty) {
        // If the search query is empty, return an empty list
        matchedUsers = [];
      } else {
        matchedUsers = allUsers.where((user) {
          String name = user['Name']?.toLowerCase() ?? '';
          String userId = user['userId'] ?? '';

          // Check if the user is not in the friends list and matches the search query
          bool isFriend =
              friendsList.any((friend) => friend['userId'] == userId);
          return name.contains(query) && !isFriend;
        }).toList();
      }
      // Emit the state with matched users
      emit(AddFriendsDataLoadedState(users: matchedUsers, state: state));
    } catch (e) {
      throw Exception(e);
    }
  }

  FutureOr<void> _sendRequest(
      AddFriendsToListEvent event, Emitter<AddFriendsState> emit) async {
    try {
      // Fetch the current user ID
      String? currentUserId = AuthenticationRepository().getCurrentUserId();
      if (currentUserId == null) return;

      // Fetch the friend's user ID from the event
      String? friendUserId = event.userId;
      if (friendUserId == null) return;

      // Reference to the friend's document
      DocumentReference friendDocRef =
          _firestore.collection('users').doc(friendUserId);

      // Add the current user's ID to the request list in the friend's document
      await friendDocRef.update({
        'requestList': FieldValue.arrayUnion(
            [currentUserId]) // Add currentUserId to friend's request list
      });

      // Emit the updated state
      CustomFlutterToast(
        backgroundColor: AppLightColorConstants.successColor,
        context: event.context,
        msg: 'Friend Request Sent',
      ).flutterToast();
      emit(AddFriendListUpdatedState(users: state.users, state: state));
    } catch (e) {
      throw Exception('Failed to send request: $e');
    }
  }

  Future<bool> isRequestSent(String friendUserId) async {
    try {
      String? currentUserId = AuthenticationRepository().getCurrentUserId();
      if (currentUserId == null) return false;

      DocumentSnapshot friendDoc =
          await _firestore.collection('users').doc(friendUserId).get();
      List<dynamic> requestList = friendDoc.get('requestList') ?? [];

      return requestList.contains(currentUserId);
    } catch (e) {
      throw Exception('Failed to check request status: $e');
    }
  }

  FutureOr<void> _inviteFriends(
      AddFriendsInviteEvent event, Emitter<AddFriendsState> emit) async {
    const url =
        "https://github.com/Omskka/OweMate/releases/download/v1.0.1/OweMate.apk";

    // Show the share dialog
    try {
      print('object');
      await Share.share(
          'Hey! Check out OweMate – the app that makes tracking debts with friends super easy!\n\nDownload it now and start managing your finances together.\n$url');
      // If sharing is successful (though the share_plus package does not provide a status)
    } catch (e) {
      // Handle the error if the share fails
      throw Exception('Error while sharing: $e');
    }
  }
}
