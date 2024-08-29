abstract class ActivityState{
  final List requestNumber;
  ActivityState({
    required this.requestNumber,
  });
}

class ActivityInitialState extends ActivityState{
  ActivityInitialState(): super(requestNumber: []);
}

// State to represent loaded data
class ActivityDataLoadedState extends ActivityState {
  ActivityDataLoadedState({
    required List requestNumber,
    required ActivityState state,
  }) : super(requestNumber: requestNumber);
}

// State to represent drawer open
class ActivityDrawerOpenedState extends ActivityState {
  ActivityDrawerOpenedState({
    required ActivityState state,
    required List requestNumber,
  }) : super(requestNumber: state.requestNumber);
}

// State to represent drawer closed
class ActivityDrawerClosedState extends ActivityState {
  ActivityDrawerClosedState({
    required ActivityState state,
    required List requestNumber,
  }):super(requestNumber: state.requestNumber);
}