import 'package:flutter/material.dart';

abstract class NotificationsEvent {
  NotificationsEvent();
}

class NotificationsInitialEvent extends NotificationsEvent {
  NotificationsInitialEvent();
}

class NotificationsAcceptEvent extends NotificationsEvent {
  String friendId;
  final BuildContext context;
  NotificationsAcceptEvent({required this.friendId, required this.context});
}

class NotificationsDeclineEvent extends NotificationsEvent {
  String friendId;
  final BuildContext context;
  NotificationsDeclineEvent({required this.friendId, required this.context});
}
