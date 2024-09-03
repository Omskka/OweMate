import 'dart:async';
import 'package:app_developments/app/views/view_home/view_model/home_event.dart';
import 'package:app_developments/app/views/view_home/view_model/home_state.dart';
import 'package:app_developments/core/auth/authentication_repository.dart';
import 'package:app_developments/core/auth/fetch_user_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeViewModel extends Bloc<HomeEvent, HomeState> {
  HomeViewModel() : super(HomeInitialState()) {
    // Handling the HomeInitialEvent and mapping it to _initial method
    on<HomeInitialEvent>(_initial);
    on<HomeDrawerOpenedEvent>(_onDrawerOpened);
    on<HomeDrawerClosedEvent>(_onDrawerClosed);
    on<HomefetchRequestDataEvent>(_fetchFriendsData);
    on<HomefetchDeleteRequestEvent>(_deleteRequest);
  }

  // Define key for drawer
  GlobalKey drawerKey = GlobalKey();

  final FetchUserData fetchUserDataService = FetchUserData();
  final formKey = GlobalKey<FormState>();

  String name = '';
  String gender = '';
  String email = '';
  String phoneNumber = '';
  String profileImageUrl = '';
  List friendsList = [];
  List requestList = [];
  List requestedMoney = [];
  List owedMoney = [];

  bool isDrawerOpen = false; // Property to track drawer state

  // Initial function
  FutureOr<void> _initial(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    try {
      emit(HomeLoadingState());
      final userData = await fetchUserDataService.fetchUserData();
      name = userData['firstName']!;
      gender = userData['gender']!;
      phoneNumber = userData['phoneNumber']!;
      email = userData['email']!;
      profileImageUrl = userData['profileImageUrl']!;
      friendsList = userData['friendsList']!;
      requestList = userData['requestList']!;
      requestedMoney = userData['requestedMoney'];
      owedMoney = userData['owedMoney'];
      emit(
        HomeDataLoadedState(
          userData: userData,
          state: state,
          friendsUserData: {},
        ),
      );
    } catch (e) {
      throw Exception('$e');
    }
  }

  int fetchRequestNumber(List requestList) {
    return requestList.isEmpty ? 0 : requestList.length;
  }

  void _onDrawerOpened(HomeDrawerOpenedEvent event, Emitter<HomeState> emit) {
    isDrawerOpen = true; // Update drawer state
    emit(
      HomeDrawerOpenedState(
          userData: state.userData,
          state: state,
          friendsUserData: state.friendsUserData),
    );
  }

  void _onDrawerClosed(HomeDrawerClosedEvent event, Emitter<HomeState> emit) {
    isDrawerOpen = false; // Update drawer state
    emit(
      HomeDrawerClosedState(
          userData: state.userData,
          state: state,
          friendsUserData: state.friendsUserData),
    );
  }

  FutureOr<void> _fetchFriendsData(
      HomefetchRequestDataEvent event, Emitter<HomeState> emit) async {
    try {
      final friendsUserData =
          await fetchUserDataService.fetchUserData(userId: event.friendsUserId);

      // Update the state with fetched friends data
      final updatedFriendsUserData =
          Map<String, dynamic>.from(state.friendsUserData)
            ..[event.friendsUserId] = friendsUserData;

      // Emit the updated state
      emit(
        HomefriendsDataLoadedState(
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
      HomefetchDeleteRequestEvent event, Emitter<HomeState> emit) async {
    try {
      // Assume `currentUserId` is the ID of the currently logged-in user
      String? currentUserId = AuthenticationRepository().getCurrentUserId();

      // Fetch current user's data
      var currentUserData =
          await fetchUserDataService.fetchUserData(userId: currentUserId);

      // Fetch friend's user data
      var friendUserData =
          await fetchUserDataService.fetchUserData(userId: event.friendUserId);

      // Remove the request from the current user's `requestedMoney` list
      currentUserData['requestedMoney']
          .removeWhere((item) => item['requestId'] == event.requestId);

      // Remove the request from the friend's `owedMoney` list
      friendUserData['owedMoney']
          .removeWhere((item) => item['requestId'] == event.requestId);

      // Update both the current user and friend's data in Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserId)
          .update({'requestedMoney': currentUserData['requestedMoney']});

      await FirebaseFirestore.instance
          .collection('users')
          .doc(event.friendUserId)
          .update({'owedMoney': friendUserData['owedMoney']});

      //  add HomeInitialEvent to refresh requests on page
      add(HomeInitialEvent());
    } catch (e) {
      // Handle any errors
      throw Exception(e);
    }
  }
}
