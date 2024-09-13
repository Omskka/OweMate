// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_developments/app/views/view_friends/view_model/friends_event.dart';
import 'package:app_developments/app/views/view_friends/view_model/friends_state.dart';
import 'package:app_developments/core/auth/authentication_repository.dart';
import 'package:app_developments/core/auth/fetch_user_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FriendsViewModel extends Bloc<FriendsEvent, FriendsState> {
  final TextEditingController friendsSearchController = TextEditingController();

  String name = '';
  String gender = '';
  String email = '';
  String phoneNumber = '';
  String profileImageUrl = '';
  List friendsList = [];
  List requestList = [];
  List<Map<String, String>> allFriends = [];

  final FetchUserData fetchUserDataService = FetchUserData();
  final formKey = GlobalKey<FormState>();

  FriendsViewModel() : super(FriendsInitialState()) {
    on<FriendsInitialEvent>(_initial);
    on<FriendsSearchEvent>(_searchFriend);
    on<FriendsRemoveFriendEvent>(_removeFriend);
  }
  FutureOr<void> _initial(
      FriendsInitialEvent event, Emitter<FriendsState> emit) async {
    try {
      emit(FriendsLoadingState());

      // Fetch user data
      final userData = await fetchUserDataService.fetchUserData();
      name = userData['firstName']!;
      gender = userData['gender']!;
      phoneNumber = userData['phoneNumber']!;
      email = userData['email']!;
      profileImageUrl = userData['profileImageUrl']!;
      friendsList = userData['friendsList']!;
      requestList = userData['requestList']!;

      // Fetch friends' data
      List<Map<String, String>> friends =
          await fetchUserDataService.fetchFriends();

      // Emit the state with the fetched friends data
      emit(FriendsDataLoadedState(
        friends: friends,
        state: state,
        requestNumber: requestList,
      ));
    } catch (e) {
      // Handle the exception
      throw Exception('Failed to fetch data: $e');
    }
  }

  FutureOr<void> _searchFriend(
      FriendsSearchEvent event, Emitter<FriendsState> emit) async {
    try {
      // Get the search query from the TextEditingController
      String query = friendsSearchController.text.trim().toLowerCase();

      // Clear the list before fetching new data
      allFriends.clear();

      // Fetch friends' data
      allFriends = await fetchUserDataService.fetchFriends();
      // Filter friends based on the search query
      List<Map<String, String>> matchedFriends;
      if (query.isEmpty) {
        // If the search query is empty, return an empty list
        matchedFriends = allFriends;
      } else {
        matchedFriends = allFriends.where((user) {
          String firstName = user['Name']?.toLowerCase() ?? '';
          return firstName.contains(query);
        }).toList();
      }

      // Emit the state with the matched friends data
      emit(FriendsSearchedState(
        friends: matchedFriends,
        state: state,
        requestNumber: requestList,
      ));
    } catch (e) {
      // Handle the exception
      throw Exception('Failed to search friends: $e');
    }
  }

  FutureOr<void> _removeFriend(
      FriendsRemoveFriendEvent event, Emitter<FriendsState> emit) async {
    try {
      // Get current user ID
      String? userId = AuthenticationRepository().getCurrentUserId();
      // Get friend's ID
      String friendId = event.friendId;

      if (userId == null) {
        throw Exception("User ID is not available");
      }

      // Fetch current user data
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      // Fetch friend data
      DocumentSnapshot friendDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(friendId)
          .get();

      if (!friendDoc.exists) {
        throw Exception("Friend data not found");
      }

      // Update Firestore: Remove friendId from the current user's friendsList
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'friendsList': FieldValue.arrayRemove([friendId]),
      });

      // Update Firestore: Remove current user ID from the friend's friendsList
      await FirebaseFirestore.instance
          .collection('users')
          .doc(friendId)
          .update({
        'friendsList': FieldValue.arrayRemove([userId]),
      });

      // Fetch and emit updated friends list
      add(FriendsInitialEvent(context: event.context));
    } catch (e) {
      throw Exception('Failed to remove friend: $e');
    }
  }
}
