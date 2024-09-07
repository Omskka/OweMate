abstract class ActivityEvent{
  ActivityEvent();
}

class ActivityInitialEvent extends ActivityEvent{
  ActivityInitialEvent();
}

class ActivityRequestCurrencyEvent extends ActivityEvent{
  ActivityRequestCurrencyEvent();
}

class ActivityDebtCurrencyEvent extends ActivityEvent{
  ActivityDebtCurrencyEvent();
}

class ActivityDrawerOpenedEvent extends ActivityEvent {}

class ActivityDrawerClosedEvent extends ActivityEvent {}