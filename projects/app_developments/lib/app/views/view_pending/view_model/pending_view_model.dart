// ignore_for_file: invalid_use_of_visible_for_testing_member, use_build_context_synchronously

import 'dart:async';
import 'package:app_developments/core/auth/authentication_repository.dart';
import 'package:app_developments/core/auth/fetch_user_data.dart';
import 'package:app_developments/core/auth/shared_preferences/preferencesService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'pending_event.dart';
import 'pending_state.dart';

class PendingViewModel extends Bloc<PendingEvent, PendingState> {
  // Define global keys for the tutorial
  final GlobalKey debtsKey = GlobalKey();
  final GlobalKey requestsKey = GlobalKey();
  final GlobalKey navbarDebtsKey = GlobalKey();

  final FetchUserData fetchUserDataService = FetchUserData();
  final PreferencesService preferencesService = PreferencesService();

  PendingViewModel() : super(PendingInitialState()) {
    on<PendingInitialEvent>(_initial);
    on<PendingfetchRequestDataEvent>(_fetchFriendsData);
    on<PendingfetchDeleteRequestEvent>(_deleteRequest);
  }

  // Define key for drawer
  GlobalKey drawerKey = GlobalKey();

  final formKey = GlobalKey<FormState>();
  String name = '';
  String gender = '';
  String email = '';
  String profileImageUrl = '';
  List friendsList = [];
  List requestList = [];
  List requestedMoney = [];
  List owedMoney = [];

  bool isDrawerOpen = false;

  FutureOr<void> _initial(
      PendingInitialEvent event, Emitter<PendingState> emit) async {
    try {
      emit(PendingLoadingState());
      final isOrderReversed = await preferencesService.loadOrderPreference();

      // Fetch user data
      final userData = await fetchUserDataService.fetchUserData();
      name = userData['firstName'];
      gender = userData['gender'];
      email = userData['email'];
      profileImageUrl = userData['profileImageUrl'];
      friendsList = userData['friendsList'];
      requestList = userData['requestList'];
      requestedMoney = List.from(userData['requestedMoney'].reversed);
      owedMoney = List.from(userData['owedMoney'].reversed);

      emit(PendingDataLoadedState(
        userData: userData,
        state: state,
        isOrderReversed: isOrderReversed,
        friendsUserData: {},
      ));
    } catch (e) {
      throw Exception(e);
    }
  }

  int fetchRequestNumber(List requestList) {
    return requestList.isEmpty ? 0 : requestList.length;
  }

  FutureOr<void> _fetchFriendsData(
      PendingfetchRequestDataEvent event, Emitter<PendingState> emit) async {
    try {
      final friendsUserData =
          await fetchUserDataService.fetchUserData(userId: event.friendsUserId);

      // Update the state with fetched friends data
      final updatedFriendsUserData =
          Map<String, dynamic>.from(state.friendsUserData)
            ..[event.friendsUserId] = friendsUserData;

      // Emit the updated state
      emit(
        PendingfriendsDataLoadedState(
          userData: state.userData,
          friendsUserData: updatedFriendsUserData,
          state: state,
        ),
      );
    } catch (e) {
      // Log the error
      // Optionally emit an error state if needed
    }
  }

  FutureOr<void> _deleteRequest(
      PendingfetchDeleteRequestEvent event, Emitter<PendingState> emit) async {
    try {
      // Get the current user's ID
      String? currentUserId = AuthenticationRepository().getCurrentUserId();

      // Fetch current user's data
      var currentUserData =
          await fetchUserDataService.fetchUserData(userId: currentUserId);

      // Check if friend's user data exists
      var friendUserDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(event.friendUserId)
          .get();

      // Remove the request from the current user's `requestedMoney` list
      currentUserData['requestedMoney']
          .removeWhere((item) => item['requestId'] == event.requestId);

      // Update the current user's data in Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserId)
          .update({'requestedMoney': currentUserData['requestedMoney']});

      // Proceed to remove the request from friend's `owedMoney` list only if the friend's document exists
      if (friendUserDoc.exists) {
        var friendUserData = friendUserDoc.data();

        // Ensure `owedMoney` exists in friend's data before trying to remove
        if (friendUserData != null && friendUserData['owedMoney'] != null) {
          friendUserData['owedMoney']
              .removeWhere((item) => item['requestId'] == event.requestId);

          // Update the friend's data in Firestore
          await FirebaseFirestore.instance
              .collection('users')
              .doc(event.friendUserId)
              .update({'owedMoney': friendUserData['owedMoney']});
        }
      } else {
        print('Friend user does not exist, skipping deletion from owedMoney.');
      }

      // Add PendingInitialEvent to refresh requests on the page
      add(
        PendingInitialEvent(
          context: event.context,
          selectedPage: state.selectedPage!,
        ),
      );
    } catch (e) {
      // Handle any errors
      print('Error in _deleteRequest: ${e.toString()}');
      throw Exception(e);
    }
  }
}
