// Abstract base class for home states
abstract class HomeState {
  final Map<String, dynamic> userData;
  final Map<String, dynamic> friendsUserData;
  final bool? isConnectedToInternet;
  final bool? isOrderReversed;
  HomeState({
    required this.friendsUserData,
    required this.userData,
    this.isConnectedToInternet,
    this.isOrderReversed,
  });
}

// State to represent the initial state of the home
class HomeInitialState extends HomeState {
  HomeInitialState()
      : super(
          userData: {},
          friendsUserData: {},
        );
}

class HomeLoadingState extends HomeState {
  HomeLoadingState()
      : super(
          friendsUserData: {},
          userData: {},
        );
}

// State to represent loaded data
class HomeDataLoadedState extends HomeState {
  HomeDataLoadedState({
    required Map<String, dynamic> userData,
    required Map<String, dynamic> friendsUserData,
    required HomeState state,
    required bool? isOrderReversed,
  }) : super(
          userData: userData,
          friendsUserData: {},
          isOrderReversed: isOrderReversed,
        );
}

// State to represent loaded data
class HomefriendsDataLoadedState extends HomeState {
  HomefriendsDataLoadedState({
    required Map<String, dynamic> userData,
    required Map<String, dynamic> friendsUserData,
    required HomeState state,
  }) : super(
          userData: state.userData,
          friendsUserData: friendsUserData,
        );
}

// State to represent drawer open
class HomeDrawerOpenedState extends HomeState {
  HomeDrawerOpenedState({
    required HomeState state,
    required Map<String, dynamic> userData,
    required Map<String, dynamic> friendsUserData,
  }) : super(
          userData: state.userData,
          friendsUserData: state.friendsUserData,
        );
}

// State to represent drawer closed
class HomeDrawerClosedState extends HomeState {
  HomeDrawerClosedState({
    required HomeState state,
    required Map<String, dynamic> userData,
    required Map<String, dynamic> friendsUserData,
  }) : super(
          userData: state.userData,
          friendsUserData: state.friendsUserData,
        );
}

class HomeRequestDeletedState extends HomeState {
  HomeRequestDeletedState({
    required HomeState state,
    required Map<String, dynamic> userData,
    required Map<String, dynamic> friendsUserData,
  }) : super(
          userData: state.userData,
          friendsUserData: state.friendsUserData,
        );
}

class HomeInternetState extends HomeState {
  HomeInternetState({
    required HomeState state,
    required Map<String, dynamic> userData,
    required Map<String, dynamic> friendsUserData,
    required bool? isConnectedToInternet,
  }) : super(
          userData: state.userData,
          friendsUserData: state.friendsUserData,
          isConnectedToInternet: isConnectedToInternet,
        );
}
