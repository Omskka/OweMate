// Abstract base class for home events
abstract class HomeEvent {
  HomeEvent();
}

// Event to represent the initial state of the home
class HomeInitialEvent extends HomeEvent {
  HomeInitialEvent();
}

class HomeDrawerOpenedEvent extends HomeEvent {}

class HomeDrawerClosedEvent extends HomeEvent {}
