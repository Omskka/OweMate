import 'dart:async';
import 'dart:convert';
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
      emit(HomeDataLoadedState(requestNumber: requestList, state: state));
    } catch (e) {
      throw Exception('$e');
    }
  }

  int fetchRequestNumber(List requestList) {
    return requestList.isEmpty ? 0 : requestList.length;
  }

  void _onDrawerOpened(HomeDrawerOpenedEvent event, Emitter<HomeState> emit) {
    isDrawerOpen = true; // Update drawer state
    emit(HomeDrawerOpenedState(requestNumber: [], state: state));
  }

  void _onDrawerClosed(HomeDrawerClosedEvent event, Emitter<HomeState> emit) {
    isDrawerOpen = false; // Update drawer state
    emit(HomeDrawerClosedState(requestNumber: [], state: state));
  }
}
