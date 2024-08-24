abstract class AddFriendsState {
  final List<Map<String, String>> users;
  AddFriendsState({required this.users});
}

class AddFriendsInitialState extends AddFriendsState {
  AddFriendsInitialState() : super(users: []);
}

class AddFriendsDataLoadedState extends AddFriendsState {
  AddFriendsDataLoadedState({
    required List<Map<String, String>> users,
    required AddFriendsState state,
  }) : super(users: users);
}

class AddFriendListUpdatedState extends AddFriendsState {
  AddFriendListUpdatedState({
    required List<Map<String, String>> users,
    required AddFriendsState state,
  }) : super(users: users);
}
