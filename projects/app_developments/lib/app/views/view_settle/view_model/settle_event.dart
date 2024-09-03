import 'package:flutter/material.dart';

/// Abstract base class 
abstract class SettleEvent{
  SettleEvent();
}

/// Event to indicate the initial state 
class SettleInitialEvent extends SettleEvent{
  SettleInitialEvent();
}

class SettlefetchRequestDataEvent extends SettleEvent {
  final String friendsUserId;
  SettlefetchRequestDataEvent({required this.friendsUserId});
}

// Event to navigate to the next page, holds the context for navigation
class SettleNavigateToNextPageEvent extends SettleEvent {
  final int selectedPage;
  final BuildContext context;

  // Constructor to initialize the context
  SettleNavigateToNextPageEvent({
    required this.context,
    required this.selectedPage,
  });
}