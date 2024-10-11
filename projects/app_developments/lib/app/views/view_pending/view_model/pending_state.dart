// Abstract base class for Pending states
abstract class PendingState {
  final Map<String, dynamic> userData;
  final Map<String, dynamic> friendsUserData;
  final bool? isConnectedToInternet;
  final bool? isOrderReversed;
  final int? selectedPage;
  PendingState({
    required this.friendsUserData,
    required this.userData,
    this.isConnectedToInternet,
    this.isOrderReversed,
    this.selectedPage,
  });
}

// State to represent the initial state of the Pending
class PendingInitialState extends PendingState {
  PendingInitialState()
      : super(
          userData: {},
          friendsUserData: {},
          selectedPage: 0,
        );
}

class PendingLoadingState extends PendingState {
  PendingLoadingState()
      : super(
          friendsUserData: {},
          userData: {},
        );
}

// State to represent loaded data
class PendingDataLoadedState extends PendingState {
  PendingDataLoadedState({
    required Map<String, dynamic> userData,
    required Map<String, dynamic> friendsUserData,
    required PendingState state,
    required bool? isOrderReversed,
  }) : super(
          userData: userData,
          friendsUserData: {},
          isOrderReversed: isOrderReversed,
        );
}

// State to represent loaded data
class PendingfriendsDataLoadedState extends PendingState {
  PendingfriendsDataLoadedState({
    required Map<String, dynamic> userData,
    required Map<String, dynamic> friendsUserData,
    required PendingState state,
    final int? selectedPage,
  }) : super(
            userData: state.userData,
            friendsUserData: friendsUserData,
            selectedPage: state.selectedPage);
}

class PendingRequestDeletedState extends PendingState {
  PendingRequestDeletedState({
    required PendingState state,
    required Map<String, dynamic> userData,
    required Map<String, dynamic> friendsUserData,
    final int? selectedPage,
  }) : super(
          userData: state.userData,
          friendsUserData: state.friendsUserData,
          selectedPage: state.selectedPage
        );
}

// State for incrementing the selected page
class PendingPageIncrementState extends PendingState {
  PendingPageIncrementState({
    int? selectedPage,
    required PendingState state,
    required Map<String, dynamic> userData,
    required Map<String, dynamic> friendsUserData,
    required bool? isOrderReversed,
  }) : super(
          friendsUserData: state.friendsUserData,
          userData: state.userData,
          isOrderReversed: isOrderReversed,
          selectedPage: selectedPage,
        );
}
