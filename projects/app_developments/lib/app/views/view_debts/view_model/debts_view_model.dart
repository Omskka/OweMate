import 'dart:async';

import 'package:app_developments/app/views/view_debts/view_model/debts_event.dart';
import 'package:app_developments/app/views/view_debts/view_model/debts_state.dart';
import 'package:app_developments/core/auth/fetch_user_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DebtsViewModel extends Bloc<DebtsEvent, DebtsState> {
  DebtsViewModel() : super(DebtsInitialState()) {
    on<DebtsInitialEvent>(_initial);
    on<DebtsDrawerOpenedEvent>(_onDrawerOpened);
    on<DebtsDrawerClosedEvent>(_onDrawerClosed);
  }

  // Define key for drawer
  GlobalKey drawerKey = GlobalKey();

  final FetchUserData fetchUserDataService = FetchUserData();
  final formKey = GlobalKey<FormState>();

  String name = '';
  String gender = '';
  String email = '';
  String profileImageUrl = '';
  List friendsList = [];
  List requestList = [];

  bool isDrawerOpen = false; // Property to track drawer state

  // Initial event
  FutureOr<void> _initial(
      DebtsInitialEvent event, Emitter<DebtsState> emit) async {
    try {
      // Fetch user data
      final userData = await fetchUserDataService.fetchUserData();
      name = userData['firstName']!;
      gender = userData['gender']!;
      email = userData['email']!;
      profileImageUrl = userData['profileImageUrl']!;
      friendsList = userData['friendsList']!;
      requestList = userData['requestList']!;

      // Emit the loaded state with the fetched data
      emit(DebtsDataLoadedState(requestNumber: requestList, state: state));
    } catch (e) {
      // Throw exception
      throw Exception('$e');
    }
  }

  void _onDrawerOpened(DebtsDrawerOpenedEvent event, Emitter<DebtsState> emit) {
    isDrawerOpen = true; // Update drawer state
    emit(DebtsDrawerOpenedState(
        state: state, requestNumber: state.requestNumber));
  }

  void _onDrawerClosed(DebtsDrawerClosedEvent event, Emitter<DebtsState> emit) {
    isDrawerOpen = false; // Update drawer state
    emit(DebtsDrawerClosedState(
        state: state, requestNumber: state.requestNumber));
  }
}
