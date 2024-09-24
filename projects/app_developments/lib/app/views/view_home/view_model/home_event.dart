// Abstract base class for home events
import 'package:flutter/material.dart';

abstract class HomeEvent {
  HomeEvent();
}

// Event to represent the initial state of the home
class HomeInitialEvent extends HomeEvent {
  final BuildContext context;
  HomeInitialEvent({
    required this.context,
  });
}

class HomefetchRequestDataEvent extends HomeEvent {
  final String friendsUserId;
  HomefetchRequestDataEvent({required this.friendsUserId});
}

class HomefetchDebtDataEvent extends HomeEvent {
  final String friendsUserId;
  HomefetchDebtDataEvent({required this.friendsUserId});
}

class HomefetchDeleteRequestEvent extends HomeEvent {
  final String requestId;
  final String friendUserId;
  final BuildContext context;
  HomefetchDeleteRequestEvent({
    required this.requestId,
    required this.friendUserId,
    required this.context,
  });
}

class HomeDrawerOpenedEvent extends HomeEvent {}

class HomeDrawerClosedEvent extends HomeEvent {}
