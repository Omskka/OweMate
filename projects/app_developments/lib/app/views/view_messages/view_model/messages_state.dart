abstract class MessagesState {
  final int? selectedPage;
  final List<Map<String, String>>? selectedUser;
  final List<Map<String, String>> friends;
  final List combinedFilteredList;
  MessagesState({
    required this.friends,
    required this.combinedFilteredList,
    this.selectedUser,
    this.selectedPage,
  });
}

class MessagesInitialState extends MessagesState {
  MessagesInitialState() : super(friends: [], combinedFilteredList: []);
}

class MessagesLoadingState extends MessagesState {
  MessagesLoadingState() : super(friends: [], combinedFilteredList: []);
}

class MessagesLoadFriendsState extends MessagesState {
  MessagesLoadFriendsState({
    required List<Map<String, String>> friends,
    required MessagesState state,
    required List combinedFilteredList,
  }) : super(
          selectedPage: state.selectedPage,
          friends: friends,
          combinedFilteredList: state.combinedFilteredList,
        );
}

/// State representing the selected page in the money transfer process
class MessagesSelectedPageState extends MessagesState {
  final int selectedPage;
  final MessagesState state;
  final List<Map<String, String>>? selectedUser;
  final List combinedFilteredList;

  MessagesSelectedPageState({
    required this.selectedPage,
    required this.state,
    required this.selectedUser,
    required this.combinedFilteredList,
  }) : super(
          selectedPage: state.selectedPage,
          friends: state.friends,
          selectedUser: selectedUser,
          combinedFilteredList: state.combinedFilteredList,
        );
}

/// State representing the selected page in the money transfer process
class MessagesLoadMessagesState extends MessagesState {
  final MessagesState state;
  final int selectedPage;
  final List<Map<String, String>>? selectedUser;
  final List combinedFilteredList;

  MessagesLoadMessagesState({
    required this.state,
    required this.selectedUser,
    required this.selectedPage,
    required this.combinedFilteredList,
  }) : super(
          friends: state.friends,
          selectedUser: selectedUser,
          combinedFilteredList: state.combinedFilteredList,
          selectedPage: selectedPage,
        );
}
