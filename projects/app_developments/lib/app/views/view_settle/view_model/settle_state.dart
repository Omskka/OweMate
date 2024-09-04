// Abstract base class for settle states
import 'package:flutter/material.dart';

abstract class SettleState {
  final Map<String, dynamic> userData;
  final int? selectedPage;
  final Map<String, dynamic> friendsUserData;
  final int? index;
  SettleState({
    required this.userData,
    required this.friendsUserData,
    this.selectedPage,
    this.index,
  });
}

// State to represent the initial state
class SettleInitialState extends SettleState {
  SettleInitialState()
      : super(
          selectedPage: 0,
          userData: {},
          friendsUserData: {},
          index: null,
        );
}

// State to represent loaded data
class SettleDataLoadedState extends SettleState {
  SettleDataLoadedState({
    required Map<String, dynamic> userData,
    required SettleState state,
  }) : super(
          userData: userData,
          selectedPage: state.selectedPage,
          friendsUserData: {},
        );
}

// State to represent loaded data
class SettlefriendsDataLoadedState extends SettleState {
  SettlefriendsDataLoadedState({
    required Map<String, dynamic> userData,
    required Map<String, dynamic> friendsUserData,
    required SettleState state,
  }) : super(
          selectedPage: state.selectedPage,
          userData: state.userData,
          friendsUserData: friendsUserData,
        );
}

//  Loading state
class SettleLoadingState extends SettleState {
  SettleLoadingState()
      : super(
          userData: {},
          friendsUserData: {},
        );
}

// Page increment state
class SettlePageIncrementState extends SettleState {
  final int? selectedPage;
  final SettleState state;
  final int index;
  SettlePageIncrementState({
    required this.state,
    required this.selectedPage,
    required this.index,
  }) : super(
          selectedPage: selectedPage,
          userData: state.userData,
          friendsUserData: state.friendsUserData,
          index: index,
        );
}
