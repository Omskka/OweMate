// Abstract base class for home states
abstract class HomeState {
  final List requestNumber;
  HomeState({
    required this.requestNumber,
  });
}

// State to represent the initial state of the home
class HomeInitialState extends HomeState {
  HomeInitialState() : super(requestNumber: []);
}

// State to represent loaded data
class HomeDataLoadedState extends HomeState {
  HomeDataLoadedState({
    required List requestNumber,
    required HomeState state,
  }) : super(requestNumber: requestNumber);
}

// State to represent drawer open
class HomeDrawerOpenedState extends HomeState {
  HomeDrawerOpenedState({
    required HomeState state,
    required List requestNumber,
  }) : super(requestNumber: state.requestNumber);
}

// State to represent drawer closed
class HomeDrawerClosedState extends HomeState {
  HomeDrawerClosedState({required HomeState state, required List requestNumber})
      : super(requestNumber: state.requestNumber);
}
