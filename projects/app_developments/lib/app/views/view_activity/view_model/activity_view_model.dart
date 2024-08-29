import 'dart:async';

import 'package:app_developments/app/views/view_activity/view_model/activity_event.dart';
import 'package:app_developments/app/views/view_activity/view_model/activity_state.dart';
import 'package:app_developments/core/auth/fetch_user_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActivityViewModel extends Bloc<ActivityEvent, ActivityState> {
  final FetchUserData fetchUserDataService = FetchUserData();

  String name = '';
  String gender = '';
  String email = '';
  String phoneNumber = '';
  String profileImageUrl = '';
  List friendsList = [];
  List requestList = [];

  bool isDrawerOpen = false; // Property to track drawer state
  ActivityViewModel() : super(ActivityInitialState()) {
    on<ActivityInitialEvent>(_initial);
    on<ActivityDrawerOpenedEvent>(_onDrawerOpened);
    on<ActivityDrawerClosedEvent>(_onDrawerClosed);
  }

  FutureOr<void> _initial(
      ActivityInitialEvent event, Emitter<ActivityState> emit) async {
    try {
      // Fetch user data
      final userData = await fetchUserDataService.fetchUserData();
      name = userData['firstName']!;
      gender = userData['gender']!;
      phoneNumber = userData['phoneNumber']!;
      email = userData['email']!;
      profileImageUrl = userData['profileImageUrl']!;
      friendsList = userData['friendsList']!;
      requestList = userData['requestList']!;

      // Emit the loaded state with the fetched data
      emit(ActivityDataLoadedState(requestNumber: requestList, state: state));
    } catch (e) {
      // Throw exception
      throw Exception('$e');
    }
  }

  void _onDrawerOpened(ActivityDrawerOpenedEvent event, Emitter<ActivityState> emit) {
    isDrawerOpen = true; // Update drawer state
    emit(ActivityDrawerOpenedState(
        state: state, requestNumber: state.requestNumber));
  }

  void _onDrawerClosed(ActivityDrawerClosedEvent event, Emitter<ActivityState> emit) {
    isDrawerOpen = false; // Update drawer state
    emit(ActivityDrawerClosedState(
        state: state, requestNumber: state.requestNumber));
  }
}
