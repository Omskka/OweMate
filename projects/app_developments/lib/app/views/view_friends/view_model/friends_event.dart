import 'package:flutter/material.dart';

abstract class FriendsEvent{
  FriendsEvent();
}

class FriendsInitialEvent extends FriendsEvent{
  BuildContext context;
  FriendsInitialEvent({required this.context});
}

class FriendsSearchEvent extends FriendsEvent{
  BuildContext context;
  FriendsSearchEvent({required this.context});
}