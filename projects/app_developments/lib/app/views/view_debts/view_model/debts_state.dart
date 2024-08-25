abstract class DebtsState {
  final List requestNumber;
  DebtsState({
    required this.requestNumber,
  });
}

class DebtsInitialState extends DebtsState {
  DebtsInitialState() : super(requestNumber: []);
}

// State to represent loaded data
class DebtsDataLoadedState extends DebtsState {
  DebtsDataLoadedState({
    required List requestNumber,
    required DebtsState state,
  }) : super(requestNumber: requestNumber);
}

// State to represent drawer open
class DebtsDrawerOpenedState extends DebtsState {
  DebtsDrawerOpenedState({
    required DebtsState state,
    required List requestNumber,
  }) : super(requestNumber: state.requestNumber);
}

// State to represent drawer closed
class DebtsDrawerClosedState extends DebtsState {
  DebtsDrawerClosedState({
    required DebtsState state,
    required List requestNumber,
  }):super(requestNumber: state.requestNumber);
}
