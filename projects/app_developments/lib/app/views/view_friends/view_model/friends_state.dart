abstract class FriendsState {
  final List<Map<String, String>> friends;
  final List requestNumber;
  FriendsState({
    required this.friends,
    required this.requestNumber,
  });
}

class FriendsInitialState extends FriendsState {
  FriendsInitialState()
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
