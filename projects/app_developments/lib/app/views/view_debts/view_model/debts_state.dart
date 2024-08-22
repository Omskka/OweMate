abstract class DebtsState{
  DebtsState();
}

class DebtsInitialState extends DebtsState{
  DebtsInitialState();
}

// State to represent loaded data
class DebtsDataLoadedState extends DebtsState {
  DebtsDataLoadedState();
}

// State to represent drawer open
class DebtsDrawerOpenedState extends DebtsState {
  DebtsDrawerOpenedState();
}

// State to represent drawer closed
class DebtsDrawerClosedState extends DebtsState {
  DebtsDrawerClosedState();
}