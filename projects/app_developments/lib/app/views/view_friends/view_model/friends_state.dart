abstract class FriendsState {
  final List<Map<String, String>> friends;
  FriendsState({required this.friends});
}

class FriendsInitialState extends FriendsState {
  FriendsInitialState() : super(friends: []);
}

class FriendsDataLoadedState extends FriendsState {
  FriendsDataLoadedState({
    required List<Map<String, String>> friends,
    required FriendsState state,
  }) : super(
          friends: friends,
        );
}
