import 'package:flutter/material.dart';

abstract class MessagesEvent {
  MessagesEvent();
}

class MessagesInitialEvent extends MessagesEvent {
  MessagesInitialEvent();
}

/// Event for selecting a page
class MessagesSelectedPageEvent extends MessagesEvent {
  final int selectedPage;
  final BuildContext context;
  final List<Map<String, String>>? selectedUser;

  // Constructor to initialize the context
  MessagesSelectedPageEvent({
    required this.context,
    required this.selectedPage,
    this.selectedUser,
  });
}

class MessagesViewActionsEvent extends MessagesEvent {
  final BuildContext context;
  final List<Map<String, String>>? selectedUser;

  MessagesViewActionsEvent({
    required this.context,
    required this.selectedUser,
  });
}
