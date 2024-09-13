import 'dart:async';

import 'package:app_developments/app/views/view_messages/view_model/messages_event.dart';
import 'package:app_developments/app/views/view_messages/view_model/messages_state.dart';
import 'package:app_developments/core/auth/fetch_user_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessagesViewModel extends Bloc<MessagesEvent, MessagesState> {
  List friendsList = [];
  List messagesList = [];
  List requestedMoney = [];
  List owedMoney = [];

  final FetchUserData fetchUserDataService = FetchUserData();

  MessagesViewModel() : super(MessagesInitialState()) {
    on<MessagesInitialEvent>(_initial);
    on<MessagesSelectedPageEvent>(_selectPage);
    on<MessagesViewActionsEvent>(_viewMessages);
  }

  FutureOr<void> _initial(
      MessagesInitialEvent event, Emitter<MessagesState> emit) async {
    try {
      emit(MessagesLoadingState());

      // Fetch friends' data
      List<Map<String, String>> friends =
          await fetchUserDataService.fetchFriends();

      // Emit the state with the fetched friends data
      emit(
        MessagesLoadFriendsState(
          friends: friends,
          state: state,
          combinedFilteredList: [],
        ),
      );
    } catch (e) {
      // Handle the exception
      throw Exception(e);
    }
  }

  FutureOr<void> _selectPage(
      MessagesSelectedPageEvent event, Emitter<MessagesState> emit) {
    emit(
      MessagesSelectedPageState(
        selectedPage: event.selectedPage,
        selectedUser: event.selectedUser,
        state: state,
        combinedFilteredList: state.combinedFilteredList,
      ),
    );
  }

  FutureOr<void> _viewMessages(
      MessagesViewActionsEvent event, Emitter<MessagesState> emit) async {
    try {
      // Emit loading state
      emit(MessagesLoadingState());
      add(
        MessagesSelectedPageEvent(
            context: event.context,
            selectedPage: 2,
            selectedUser: event.selectedUser),
      );
      final friendsUserId = event.selectedUser?[0]['userId'];
      final userData = await fetchUserDataService.fetchUserData();
      friendsList = userData['friendsList']!;
      requestedMoney = userData['requestedMoney'];
      owedMoney = userData['owedMoney'];
      // Filter requestedMoney where status is not 'pending'
      List filteredRequestedMoney = requestedMoney
          .where((request) => request['status'] != 'pending')
          .where((request) => request['friendUserId'] == friendsUserId)
          .toList()
          .reversed
          .toList();

      emit(
        MessagesLoadMessagesState(
          state: state,
          selectedUser: state.selectedUser,
          combinedFilteredList: filteredRequestedMoney,
          selectedPage: 2,
        ),
      );
    } catch (e) {
      throw Exception(e);
    }
  }
}
