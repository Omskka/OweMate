abstract class ActivityEvent{
  ActivityEvent();
}

class ActivityInitialEvent extends ActivityEvent{
  ActivityInitialEvent();
}

class ActivityDrawerOpenedEvent extends ActivityEvent {}

class ActivityDrawerClosedEvent extends ActivityEvent {}