import 'dart:async';

import 'package:app_developments/app/views/view_friends/view_model/friends_event.dart';
import 'package:app_developments/app/views/view_friends/view_model/friends_state.dart';
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

  final FetchUserData fetchUserDataService = FetchUserData();
  final formKey = GlobalKey<FormState>();

  FriendsViewModel() : super(FriendsInitialState()) {
    on<FriendsInitialEvent>(_initial);
  }
  FutureOr<void> _initial(
      FriendsInitialEvent event, Emitter<FriendsState> emit) async {
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
}
