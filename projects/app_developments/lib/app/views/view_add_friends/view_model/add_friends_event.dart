import 'package:flutter/material.dart';

abstract class AddFriendsEvent {
  AddFriendsEvent();
}

class AddFriendsInitialEvent extends AddFriendsEvent {
  AddFriendsInitialEvent();
}

class AddFriendsFetchAllUsersEvent extends AddFriendsEvent {
  AddFriendsFetchAllUsersEvent();
}

class AddFriendsToListEvent extends AddFriendsEvent {
  BuildContext context;
  String userId;
  final int index;
  AddFriendsToListEvent({
    required this.index,
    required this.context,
    required this.userId,
  });
}

class AddFriendsInviteEvent extends AddFriendsEvent {
  AddFriendsInviteEvent();
}
