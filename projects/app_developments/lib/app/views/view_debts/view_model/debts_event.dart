import 'package:flutter/material.dart';

abstract class DebtsEvent {
  DebtsEvent();
}

class DebtsInitialEvent extends DebtsEvent {
  final BuildContext context;
  DebtsInitialEvent({
    required this.context,
  });
}

class DebtsDrawerOpenedEvent extends DebtsEvent {}

class DebtsDrawerClosedEvent extends DebtsEvent {}
