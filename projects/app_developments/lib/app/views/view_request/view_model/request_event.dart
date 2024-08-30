import 'package:flutter/material.dart';

/// Abstract base class for all request events.
/// This class serves as the parent class for different types of request events.
abstract class RequestEvent {
  RequestEvent();
}

/// Event to indicate the initial state of a request.
/// This event is used to trigger the initial actions required for a request.
class RequestInitialEvent extends RequestEvent {
  RequestInitialEvent();
}

// Event to navigate to the next page, holds the context for navigation
class RequestNavigateToNextPageEvent extends RequestEvent {
  final int selectedPage;
  final BuildContext context;
  final List<Map<String, String>>? selectedUser;

  // Constructor to initialize the context
  RequestNavigateToNextPageEvent({
    required this.context,
    required this.selectedPage,
    this.selectedUser,
  });
}

// Update currency event
class RequestUpdateCurrencyEvent extends RequestEvent {
  final TextEditingController currency;
  RequestUpdateCurrencyEvent({required this.currency});
}

// Send money request
class RequestSendEvent extends RequestEvent {
  BuildContext context;
  String prefix;
  final List<Map<String, String>>? selectedUser;
  RequestSendEvent({
    required this.context,
    required this.prefix,
    required this.selectedUser,
  });
}
