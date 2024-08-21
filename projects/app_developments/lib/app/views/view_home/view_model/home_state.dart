// Abstract base class for home states
abstract class HomeState {
  const HomeState();
}

// State to represent the initial state of the home
class HomeInitialState extends HomeState {
  HomeInitialState();
}

// State to represent loaded data
class HomeDataLoadedState extends HomeState {
  HomeDataLoadedState();
}

// State to represent drawer open
class HomeDrawerOpenedState extends HomeState {
  HomeDrawerOpenedState();
}

// State to represent drawer closed
class HomeDrawerClosedState extends HomeState {
  HomeDrawerClosedState();
}
