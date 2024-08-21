import 'dart:async';
import 'package:app_developments/app/views/view_home/view_model/home_event.dart';
import 'package:app_developments/app/views/view_home/view_model/home_state.dart';
import 'package:app_developments/core/auth/fetch_user_data.dart';
import 'package:flutter/material.dart';
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

  bool isDrawerOpen = false; // Property to track drawer state

  FutureOr<void> _initial(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    try {
      // Fetch user data
      final userData = await fetchUserDataService.fetchUserData();
      name = userData['firstName']!;
      gender = userData['gender']!;
      phoneNumber = userData['phoneNumber']!;
      email = userData['email']!;
      profileImageUrl = userData['profileImageUrl']!;

      // Emit the loaded state with the fetched data
      emit(HomeDataLoadedState());
    } catch (e) {
      // Throw exception
      throw Exception('$e');
    }
  }

  void _onDrawerOpened(HomeDrawerOpenedEvent event, Emitter<HomeState> emit) {
    isDrawerOpen = true; // Update drawer state
    emit(HomeDrawerOpenedState());
  }

  void _onDrawerClosed(HomeDrawerClosedEvent event, Emitter<HomeState> emit) {
    isDrawerOpen = false; // Update drawer state
    emit(HomeDrawerClosedState());
  }
}
