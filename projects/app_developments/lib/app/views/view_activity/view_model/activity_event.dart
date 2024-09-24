import 'package:flutter/material.dart';

abstract class ActivityEvent {
  ActivityEvent();
}

class ActivityInitialEvent extends ActivityEvent {
  final BuildContext context;
  final String activityType;
  ActivityInitialEvent({
    required this.context,
    required this.activityType,
  });
}

class ActivityRequestCurrencyEvent extends ActivityEvent {
  ActivityRequestCurrencyEvent();
}

class ActivityDebtCurrencyEvent extends ActivityEvent {
  ActivityDebtCurrencyEvent();
}

class ActivitySelectEvent extends ActivityEvent {
  ActivitySelectEvent();
}

class ActivityFetchUserDataEvent extends ActivityEvent {
  final String friendUserId;
  ActivityFetchUserDataEvent({
    required this.friendUserId,
  });
}

class ActivityDeleteEvent extends ActivityEvent {
  final BuildContext context;
  final String friendUserId;
  final String requestId;

  ActivityDeleteEvent({
    required this.context,
    required this.friendUserId,
    required this.requestId,
  });
}

class ActivityDrawerOpenedEvent extends ActivityEvent {}

class ActivityDrawerClosedEvent extends ActivityEvent {}
