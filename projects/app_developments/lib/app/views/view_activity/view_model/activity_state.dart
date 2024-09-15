import 'package:flutter/material.dart';

abstract class ActivityState {
  final List requestNumber;
  final List<double> requestedMoneyTotals;
  final List<double> owedMoneyTotals;
  final List filteredRequestedMoney;
  final List filteredOwedMoney;
  final List combinedFilteredList;
  final int? requestCurrencyIndex;
  final int? debtCurrencyIndex;
  final Map<String, dynamic> friendsUserData;
  ActivityState({
    required this.requestNumber,
    required this.requestedMoneyTotals,
    required this.owedMoneyTotals,
    required this.filteredRequestedMoney,
    required this.filteredOwedMoney,
    required this.combinedFilteredList,
    required this.friendsUserData,
    this.requestCurrencyIndex,
    this.debtCurrencyIndex,
  });
}

class ActivityInitialState extends ActivityState {
  ActivityInitialState()
      : super(
            requestNumber: [],
            requestedMoneyTotals: [],
            owedMoneyTotals: [],
            filteredRequestedMoney: [],
            filteredOwedMoney: [],
            combinedFilteredList: [],
            friendsUserData: {});
}

class ActivityDataLoadedState extends ActivityState {
  ActivityDataLoadedState({
    required List requestNumber,
    required List<double> requestedMoneyTotals,
    required List<double> owedMoneyTotals,
    required int? requestCurrencyIndex,
    required int? debtCurrencyIndex,
    required List filteredRequestedMoney,
    required List filteredOwedMoney,
    required List combinedFilteredList,
    required Map<String, dynamic> friendsUserData,
  }) : super(
          requestNumber: requestNumber,
          requestedMoneyTotals: requestedMoneyTotals,
          owedMoneyTotals: owedMoneyTotals,
          requestCurrencyIndex: requestCurrencyIndex,
          debtCurrencyIndex: debtCurrencyIndex,
          filteredRequestedMoney: filteredRequestedMoney,
          filteredOwedMoney: filteredOwedMoney,
          combinedFilteredList: combinedFilteredList,
          friendsUserData: {},
        );
}

class ActivityGetIndexState extends ActivityState {
  ActivityGetIndexState({
    required ActivityState state,
    required List requestNumber,
    required List<double> requestedMoneyTotals,
    required List<double> owedMoneyTotals,
    required int? requestCurrencyIndex,
    required int? debtCurrencyIndex,
    required List filteredRequestedMoney,
    required List filteredOwedMoney,
    required List combinedFilteredList,
    required Map<String, dynamic> friendsUserData,
  }) : super(
          requestNumber: state.requestNumber,
          owedMoneyTotals: state.owedMoneyTotals,
          requestedMoneyTotals: state.requestedMoneyTotals,
          requestCurrencyIndex: requestCurrencyIndex,
          debtCurrencyIndex: debtCurrencyIndex,
          filteredRequestedMoney: state.filteredRequestedMoney,
          filteredOwedMoney: state.filteredOwedMoney,
          combinedFilteredList: state.combinedFilteredList,
          friendsUserData: state.friendsUserData,
        );
}

class ActivityDrawerOpenedState extends ActivityState {
  ActivityDrawerOpenedState({
    required ActivityState state,
    required List requestNumber,
    required List filteredRequestedMoney,
    required List filteredOwedMoney,
    required List combinedFilteredList,
    required Map<String, dynamic> friendsUserData,
  }) : super(
            requestNumber: state.requestNumber,
            requestedMoneyTotals: state.requestedMoneyTotals,
            owedMoneyTotals: state.owedMoneyTotals,
            filteredRequestedMoney: state.filteredRequestedMoney,
            filteredOwedMoney: state.filteredOwedMoney,
            combinedFilteredList: state.combinedFilteredList,
            friendsUserData: state.friendsUserData);
}

class ActivityDrawerClosedState extends ActivityState {
  ActivityDrawerClosedState({
    required ActivityState state,
    required List requestNumber,
    required List filteredRequestedMoney,
    required List filteredOwedMoney,
    required List combinedFilteredList,
    required Map<String, dynamic> friendsUserData,
  }) : super(
            requestNumber: state.requestNumber,
            requestedMoneyTotals: state.requestedMoneyTotals,
            owedMoneyTotals: state.owedMoneyTotals,
            filteredRequestedMoney: state.filteredRequestedMoney,
            filteredOwedMoney: state.filteredOwedMoney,
            combinedFilteredList: state.combinedFilteredList,
            friendsUserData: state.friendsUserData);
}

class ActivitySelectState extends ActivityState {
  ActivitySelectState({
    required ActivityState state,
    required List requestNumber,
    required List<double> requestedMoneyTotals,
    required List<double> owedMoneyTotals,
    required int? requestCurrencyIndex,
    required int? debtCurrencyIndex,
    required List filteredRequestedMoney,
    required List filteredOwedMoney,
    required List combinedFilteredList,
    required Map<String, dynamic> friendsUserData,
  }) : super(
          requestNumber: state.requestNumber,
          requestedMoneyTotals: state.requestedMoneyTotals,
          owedMoneyTotals: state.owedMoneyTotals,
          requestCurrencyIndex: state.requestCurrencyIndex,
          debtCurrencyIndex: state.debtCurrencyIndex,
          filteredRequestedMoney: state.filteredRequestedMoney,
          filteredOwedMoney: state.filteredOwedMoney,
          combinedFilteredList: state.combinedFilteredList,
          friendsUserData: state.friendsUserData,
        );
}

class ActivityfriendsDataLoadedState extends ActivityState {
  ActivityfriendsDataLoadedState({
    required ActivityState state,
    required List requestNumber,
    required List<double> requestedMoneyTotals,
    required List<double> owedMoneyTotals,
    required int? requestCurrencyIndex,
    required int? debtCurrencyIndex,
    required List filteredRequestedMoney,
    required List filteredOwedMoney,
    required List combinedFilteredList,
    required Map<String, dynamic> friendsUserData,
  }) : super(
          requestNumber: state.requestNumber,
          requestedMoneyTotals: state.requestedMoneyTotals,
          owedMoneyTotals: state.owedMoneyTotals,
          requestCurrencyIndex: state.requestCurrencyIndex,
          debtCurrencyIndex: state.debtCurrencyIndex,
          filteredRequestedMoney: state.filteredRequestedMoney,
          filteredOwedMoney: state.filteredOwedMoney,
          combinedFilteredList: state.combinedFilteredList,
          friendsUserData: friendsUserData,
        );
}
