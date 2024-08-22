abstract class DebtsEvent{
  DebtsEvent();
}

class DebtsInitialEvent extends DebtsEvent{
  DebtsInitialEvent();
}


class DebtsDrawerOpenedEvent extends DebtsEvent {}

class DebtsDrawerClosedEvent extends DebtsEvent {}
