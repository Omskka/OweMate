import 'package:flutter/material.dart';

/// Abstract base class
abstract class SettleEvent {
  SettleEvent();
}

/// Event to indicate the initial state
class SettleInitialEvent extends SettleEvent {
  SettleInitialEvent();
}

class SettlefetchRequestDataEvent extends SettleEvent {
  final String friendsUserId;
  SettlefetchRequestDataEvent({required this.friendsUserId});
}

class SettleDeclineRequestEvent extends SettleEvent {
  final BuildContext context;
  final String requestId;
  SettleDeclineRequestEvent({
    required this.context,
    required this.requestId,
  });
}

class SettlePayRequestEvent extends SettleEvent {
  final BuildContext context;
  final String requestId;
  SettlePayRequestEvent({
    required this.requestId,
    required this.context,
  });
}

// Event to navigate to the next page, holds the context for navigation
class SettleNavigateToNextPageEvent extends SettleEvent {
  final int selectedPage;
  final int? index;
  final BuildContext context;

  // Constructor to initialize the context
  SettleNavigateToNextPageEvent({
    required this.context,
    required this.selectedPage,
    this.index,
  });
}
