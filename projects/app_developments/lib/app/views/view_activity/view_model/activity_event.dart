abstract class ActivityEvent {
  ActivityEvent();
}

class ActivityInitialEvent extends ActivityEvent {
  final String activityType;
  ActivityInitialEvent({
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
  final String friendUserId;
  final String requestId;

  ActivityDeleteEvent({
    required this.friendUserId,
    required this.requestId,
  });
}

class ActivityDrawerOpenedEvent extends ActivityEvent {}

class ActivityDrawerClosedEvent extends ActivityEvent {}
