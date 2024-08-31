// Abstract base class for home events
abstract class HomeEvent {
  HomeEvent();
}

// Event to represent the initial state of the home
class HomeInitialEvent extends HomeEvent {
  HomeInitialEvent();
}

class HomefetchRequestDataEvent extends HomeEvent {
  final String friendsUserId;
  HomefetchRequestDataEvent({required this.friendsUserId});
}

class HomefetchDebtDataEvent extends HomeEvent {
  final String friendsUserId;
  HomefetchDebtDataEvent({required this.friendsUserId});
}

class HomeDrawerOpenedEvent extends HomeEvent {}

class HomeDrawerClosedEvent extends HomeEvent {}
