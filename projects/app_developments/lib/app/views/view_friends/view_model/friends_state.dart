abstract class FriendsState {
  final List<Map<String, String>> friends;
  final List requestNumber;
  final bool? isConnectedToInternet;
  FriendsState({
    required this.friends,
    required this.requestNumber,
    this.isConnectedToInternet,
  });
}

class FriendsInitialState extends FriendsState {
  FriendsInitialState()
      : super(
          friends: [],
          requestNumber: [],
        );
}

class FriendsLoadingState extends FriendsState {
  FriendsLoadingState()
      : super(
          friends: [],
          requestNumber: [],
        );
}

class FriendsDataLoadedState extends FriendsState {
  FriendsDataLoadedState({
    required List<Map<String, String>> friends,
    required List requestNumber,
    required FriendsState state,
  }) : super(
          friends: friends,
          requestNumber: requestNumber,
        );
}

class FriendsSearchedState extends FriendsState {
  FriendsSearchedState({
    required List<Map<String, String>> friends,
    required List requestNumber,
    required FriendsState state,
  }) : super(
          friends: friends,
          requestNumber: requestNumber,
        );
}

class FriendsInternetState extends FriendsState {
  FriendsInternetState({
    required List<Map<String, String>> friends,
    required List requestNumber,
    required FriendsState state,
    required bool? isConnectedToInternet,
  }) : super(
          friends: state.friends,
          requestNumber: state.requestNumber,
          isConnectedToInternet: isConnectedToInternet,
        );
}
