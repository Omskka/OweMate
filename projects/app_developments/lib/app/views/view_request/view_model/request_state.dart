/// Abstract base class for all request states.
abstract class RequestState {
  final int? selectedPage;
  final String? prefix;
  final List<Map<String, String>>? selectedUser;
  final List<Map<String, String>> friends;
  RequestState({
    required this.friends,
    this.selectedPage,
    this.selectedUser,
    this.prefix,
  });
}

/// State to indicate the initial state of a request.
class RequestInitialState extends RequestState {
  RequestInitialState()
      : super(
          selectedPage: 0,
          friends: [],
        );
}

class RequestLoadingState extends RequestState {
  RequestLoadingState()
      : super(
          friends: [],
        );
}

class RequestLoadFriendsState extends RequestState {
  RequestLoadFriendsState({
    required List<Map<String, String>> friends,
    required RequestState state,
  }) : super(
          selectedPage: state.selectedPage,
          friends: friends,
        );
}

class RequestPageIncrementState extends RequestState {
  final int? selectedPage;
  final RequestState state;
  final List<Map<String, String>>? selectedUser;
  RequestPageIncrementState({
    required this.state,
    required this.selectedPage,
    this.selectedUser,
  }) : super(
          friends: state.friends,
          selectedPage: selectedPage,
          selectedUser: selectedUser,
        );
}

class RequestUpdateCurrencyState extends RequestState {
  final RequestState state;
  final String prefix;
  RequestUpdateCurrencyState(
      {required List<Map<String, String>> friends,
      required this.state,
      required this.prefix})
      : super(
          selectedPage: 2,
          prefix: prefix,
          friends: state.friends,
          selectedUser: state.selectedUser,
        );
}

class RequestSuccessState extends RequestState {
  final RequestState state;
  RequestSuccessState({
    required this.state,
  }) : super(
          selectedPage: 3,
          prefix: state.prefix,
          friends: state.friends,
          selectedUser: state.selectedUser,
        );
}
