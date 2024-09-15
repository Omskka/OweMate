import 'dart:async';

import 'package:app_developments/app/views/view_statistics/view_model/statistics_event.dart';
import 'package:app_developments/app/views/view_statistics/view_model/statistics_state.dart';
import 'package:app_developments/core/auth/fetch_user_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatisticsViewModel extends Bloc<StatisticsEvent, StatisticsState> {
  final FetchUserData fetchUserDataService = FetchUserData();

  List requestedMoney = [];
  List owedMoney = [];
  List friendsList = [];
  List<Map<String, String>> allFriends = [];

  StatisticsViewModel() : super(StatisticsInitialState()) {
    on<StatisticsInitialEvent>(_initial);
  }

  FutureOr<void> _initial(
      StatisticsInitialEvent event, Emitter<StatisticsState> emit) async {
    try {
      emit(StatisticsLoadingState());

      // Fetch user data
      final userData = await fetchUserDataService.fetchUserData();
      requestedMoney = userData['requestedMoney'];
      owedMoney = userData['owedMoney'];
      friendsList = userData['friendsList']!;

      // Filter pending requests and debts
      final List filteredRequestedMoney = requestedMoney
          .where((request) => request['status'] == 'pending')
          .toList()
          .reversed
          .toList();

      final List filteredOwedMoney = owedMoney
          .where((debt) => debt['status'] == 'pending')
          .toList()
          .reversed
          .toList();

      // Fetch friends' data
      List<Map<String, String>> friends =
          await fetchUserDataService.fetchFriends();

      // Initialize counts
      Map<String, Map<String, int>> friendsRequestDebtCount = {};
      for (var friend in friends) {
        final userId = friend['userId'];
        friendsRequestDebtCount[userId!] = {'requests': 0, 'debts': 0};
      }

      // Update request counts
      for (var request in filteredRequestedMoney) {
        final friendUserId = request['friendUserId'];
        if (friendsRequestDebtCount.containsKey(friendUserId)) {
          friendsRequestDebtCount[friendUserId]!['requests'] =
              friendsRequestDebtCount[friendUserId]!['requests']! + 1;
        }
      }

      // Update debt counts
      for (var debt in filteredOwedMoney) {
        final friendUserId = debt['friendUserId'];
        if (friendsRequestDebtCount.containsKey(friendUserId)) {
          friendsRequestDebtCount[friendUserId]!['debts'] =
              friendsRequestDebtCount[friendUserId]!['debts']! + 1;
        }
      }

      // Add the counts to each friend
      final List<Map<String, dynamic>> updatedFriends = friends.map((friend) {
        final userId = friend['userId'];
        final requestCount = friendsRequestDebtCount[userId]?['requests'] ?? 0;
        final debtCount = friendsRequestDebtCount[userId]?['debts'] ?? 0;

        return {
          ...friend,
          'requests': requestCount,
          'debts': debtCount,
        };
      }).toList();

      // Emit the updated state with the counts
      emit(
        StatisticsDataLoadedState(
          state: state,
          filteredOwedMoney: filteredOwedMoney,
          filteredRequestedMoney: filteredRequestedMoney,
          friends: updatedFriends,
        ),
      );
    } catch (e) {
      throw Exception(e);
    }
  }
}
