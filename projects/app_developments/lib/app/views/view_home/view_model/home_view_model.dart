import 'dart:async';
import 'package:app_developments/app/views/view_home/view_model/home_event.dart';
import 'package:app_developments/app/views/view_home/view_model/home_state.dart';
import 'package:app_developments/core/auth/fetch_user_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeViewModel extends Bloc<HomeEvent, HomeState> {
  HomeViewModel() : super(HomeInitialState()) {
    // Handling the HomeInitialEvent and mapping it to _initial method
    on<HomeInitialEvent>(_initial);
    on<HomeDrawerOpenedEvent>(_onDrawerOpened);
    on<HomeDrawerClosedEvent>(_onDrawerClosed);
    on<HomefetchRequestDataEvent>(_fetchFriendsData);
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

      // Log fetched data for debugging
      //  print('Fetched friends user data: $friendsUserData\n');

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

      // Log updated state for debugging
      // print('Updated friends user data: $updatedFriendsUserData\n');
    } catch (e) {
      // Log the error
      print('Error fetching friends data: $e');
      // Optionally emit an error state if needed
    }
  }
}
