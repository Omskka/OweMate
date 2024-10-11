// Abstract base class for Pending events
import 'package:flutter/material.dart';

abstract class PendingEvent {
  PendingEvent();
}

// Event to represent the initial state of the Pending
class PendingInitialEvent extends PendingEvent {
  final BuildContext context;
  final int selectedPage; // The index of the page to navigate to

  PendingInitialEvent({
    required this.context,
    required this.selectedPage,
  });
}

class PendingfetchRequestDataEvent extends PendingEvent {
  final String friendsUserId;
  PendingfetchRequestDataEvent({required this.friendsUserId});
}

class PendingfetchDebtDataEvent extends PendingEvent {
  final String friendsUserId;
  PendingfetchDebtDataEvent({required this.friendsUserId});
}

class PendingfetchDeleteRequestEvent extends PendingEvent {
  final String requestId;
  final String friendUserId;
  final BuildContext context;
  PendingfetchDeleteRequestEvent({
    required this.requestId,
    required this.friendUserId,
    required this.context,
  });
}

// Event to navigate to the next page, holds the context for navigation and the selected page index
class PendingNavigateToNextPageEvent extends PendingEvent {
  final int selectedPage; // The index of the page to navigate to
  final BuildContext context; // The context used for navigation

  // Constructor to initialize the context and selected page index
  PendingNavigateToNextPageEvent({
    required this.context,
    required this.selectedPage,
  });
}

class PendingDrawerOpenedEvent extends PendingEvent {}

class PendingDrawerClosedEvent extends PendingEvent {}
