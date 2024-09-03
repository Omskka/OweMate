import 'dart:async';

import 'package:app_developments/app/views/view_settle/view_model/settle_event.dart';
import 'package:app_developments/app/views/view_settle/view_model/settle_state.dart';
import 'package:app_developments/core/auth/fetch_user_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettleViewModel extends Bloc<SettleEvent, SettleState> {
  String name = '';
  String gender = '';
  String email = '';
  String phoneNumber = '';
  String profileImageUrl = '';
  List friendsList = [];
  List requestList = [];
  List requestedMoney = [];
  List owedMoney = [];

  final FetchUserData fetchUserDataService = FetchUserData();
  SettleViewModel() : super(SettleInitialState()) {
    on<SettleInitialEvent>(_initial);
    on<SettlefetchRequestDataEvent>(_fetchFriendsData);
    on<SettleNavigateToNextPageEvent>(_navigateToNextPage);
  }

  FutureOr<void> _initial(
      SettleInitialEvent event, Emitter<SettleState> emit) async {
    try {
      emit(SettleLoadingState());
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
        SettleDataLoadedState(
          userData: userData,
          state: state,
        ),
      );
    } catch (e) {
      throw Exception('$e');
    }
  }

  FutureOr<void> _fetchFriendsData(
      SettlefetchRequestDataEvent event, Emitter<SettleState> emit) async {
    try {
      final friendsUserData =
          await fetchUserDataService.fetchUserData(userId: event.friendsUserId);

      // Update the state with fetched friends data
      final updatedFriendsUserData =
          Map<String, dynamic>.from(state.friendsUserData)
            ..[event.friendsUserId] = friendsUserData;

      // Emit the updated state
      emit(
        SettlefriendsDataLoadedState(
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

  FutureOr<void> _navigateToNextPage(
      SettleNavigateToNextPageEvent event, Emitter<SettleState> emit) {
    emit(SettlePageIncrementState(
      state: state,
      selectedPage: event.selectedPage,
    ));
  }
}
