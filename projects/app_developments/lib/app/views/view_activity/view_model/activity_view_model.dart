// ignore_for_file: constant_pattern_never_matches_value_type

import 'dart:async';
import 'package:app_developments/core/auth/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_developments/app/views/view_activity/view_model/activity_event.dart';
import 'package:app_developments/app/views/view_activity/view_model/activity_state.dart';
import 'package:app_developments/core/auth/fetch_user_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActivityViewModel extends Bloc<ActivityEvent, ActivityState> {
  final FetchUserData fetchUserDataService = FetchUserData();

  String name = '';
  String gender = '';
  String email = '';
  String profileImageUrl = '';
  List friendsList = [];
  List requestList = [];
  List requestedMoney = [];
  List owedMoney = [];

  final TextEditingController requestCurrencyController =
      TextEditingController();
  final TextEditingController debtCurrencyController = TextEditingController();
  final TextEditingController activityTypeController = TextEditingController();

  bool isDrawerOpen = false; // Property to track drawer state
  ActivityViewModel() : super(ActivityInitialState()) {
    on<ActivityInitialEvent>(_initial);
    on<ActivityDrawerOpenedEvent>(_onDrawerOpened);
    on<ActivityDrawerClosedEvent>(_onDrawerClosed);
    on<ActivityRequestCurrencyEvent>(_getRequestCurrency);
    on<ActivityDebtCurrencyEvent>(_getDebtCurrency);
    on<ActivitySelectEvent>(_selectActivityType);
    on<ActivityFetchUserDataEvent>(_fetchUserData);
    on<ActivityDeleteEvent>(_deleteItem);
  }

  double _parseAmount(String? amountString) {
    if (amountString == null) return 0.0;

    // Remove non-numeric characters except for dots and digits
    String cleanedAmount = amountString.replaceAll(RegExp(r'[^\d.]'), '');
    return double.tryParse(cleanedAmount) ?? 0.0;
  }

  FutureOr<void> _initial(
      ActivityInitialEvent event, Emitter<ActivityState> emit) async {
    try {
      // Fetch user data
      final userData = await fetchUserDataService.fetchUserData();
      name = userData['firstName']!;
      gender = userData['gender']!;
      email = userData['email']!;
      profileImageUrl = userData['profileImageUrl']!;
      friendsList = userData['friendsList']!;
      requestList = userData['requestList']!;
      requestedMoney = userData['requestedMoney'];
      owedMoney = userData['owedMoney'];

      // Initialize lists for requested and owed money totals
      List<double> requestedMoneyTotals = [
        0.0, // USD
        0.0, // TL
        0.0, // EURO
        0.0, // GBP
        0.0, // JPY
        0.0, // CHF
        0.0 // INR
      ];
      List<double> owedMoneyTotals = [
        0.0, // USD
        0.0, // TL
        0.0, // EURO
        0.0, // GBP
        0.0, // JPY
        0.0, // CHF
        0.0 // INR
      ];

      // Process requested money (pending status)
      requestedMoney
          .where((request) => request['status'] == 'pending')
          .forEach((request) {
        String? amountString = request['amount']?.toString();
        if (amountString != null && amountString.isNotEmpty) {
          if (amountString.startsWith('\$')) {
            requestedMoneyTotals[0] += _parseAmount(amountString); // USD
          } else if (amountString.startsWith('₺')) {
            requestedMoneyTotals[1] += _parseAmount(amountString); // TL
          } else if (amountString.startsWith('€')) {
            requestedMoneyTotals[2] += _parseAmount(amountString); // EURO
          } else if (amountString.startsWith('£')) {
            requestedMoneyTotals[3] += _parseAmount(amountString); // GBP
          } else if (amountString.startsWith('¥')) {
            requestedMoneyTotals[4] += _parseAmount(amountString); // JPY
          } else if (amountString.startsWith('₣')) {
            requestedMoneyTotals[5] += _parseAmount(amountString); // CHF
          } else if (amountString.startsWith('₹')) {
            requestedMoneyTotals[6] += _parseAmount(amountString); // INR
          }
        }
      });

      // Process owed money (pending status)
      owedMoney.where((owed) => owed['status'] == 'pending').forEach((owed) {
        String? amountString = owed['amount']?.toString();
        if (amountString != null && amountString.isNotEmpty) {
          if (amountString.startsWith('\$')) {
            owedMoneyTotals[0] += _parseAmount(amountString); // USD
          } else if (amountString.startsWith('₺')) {
            owedMoneyTotals[1] += _parseAmount(amountString); // TL
          } else if (amountString.startsWith('€')) {
            owedMoneyTotals[2] += _parseAmount(amountString); // EURO
          } else if (amountString.startsWith('£')) {
            owedMoneyTotals[3] += _parseAmount(amountString); // GBP
          } else if (amountString.startsWith('¥')) {
            owedMoneyTotals[4] += _parseAmount(amountString); // JPY
          } else if (amountString.startsWith('₣')) {
            owedMoneyTotals[5] += _parseAmount(amountString); // CHF
          } else if (amountString.startsWith('₹')) {
            owedMoneyTotals[6] += _parseAmount(amountString); // INR
          }
        }
      });

      // Filter requestedMoney where status is not 'pending'
      List filteredRequestedMoney = requestedMoney
          .where((request) => request['status'] != 'pending')
          .toList()
          .reversed
          .toList();

      // Filter owedMoney where status is not 'pending'
      List filteredOwedMoney = owedMoney
          .where((owed) => owed['status'] != 'pending')
          .toList()
          .reversed
          .toList();

      // Combine the two filtered lists
      List combinedFilteredList =
          [...filteredRequestedMoney, ...filteredOwedMoney].reversed.toList();

      // Initialize controller to requests
      activityTypeController.text = event.activityType;

      // Emit the loaded state with the totals for both requested and owed money
      emit(
        ActivityDataLoadedState(
          requestNumber: requestList,
          requestedMoneyTotals: requestedMoneyTotals,
          owedMoneyTotals: owedMoneyTotals,
          filteredRequestedMoney: filteredRequestedMoney,
          filteredOwedMoney: filteredOwedMoney,
          combinedFilteredList: combinedFilteredList,
          requestCurrencyIndex: null,
          debtCurrencyIndex: null,
          friendsUserData: {},
        ),
      );
    } catch (e) {
      // Throw exception
      throw Exception('$e');
    }
  }

  void _onDrawerOpened(
      ActivityDrawerOpenedEvent event, Emitter<ActivityState> emit) {
    isDrawerOpen = true; // Update drawer state
    emit(
      ActivityDrawerOpenedState(
        state: state,
        requestNumber: state.requestNumber,
        filteredRequestedMoney: state.filteredRequestedMoney,
        filteredOwedMoney: state.filteredOwedMoney,
        combinedFilteredList: state.combinedFilteredList,
        friendsUserData: state.friendsUserData,
      ),
    );
  }

  void _onDrawerClosed(
      ActivityDrawerClosedEvent event, Emitter<ActivityState> emit) {
    isDrawerOpen = false; // Update drawer state
    emit(
      ActivityDrawerClosedState(
        state: state,
        requestNumber: state.requestNumber,
        filteredRequestedMoney: state.filteredRequestedMoney,
        filteredOwedMoney: state.filteredOwedMoney,
        combinedFilteredList: state.combinedFilteredList,
        friendsUserData: state.friendsUserData,
      ),
    );
  }

  Future<void> _getRequestCurrency(
      ActivityRequestCurrencyEvent event, Emitter<ActivityState> emit) async {
    // Helper function to determine currency index based on the currency string
    int currencyIndex = 0; // Default to USD
    switch (requestCurrencyController.text.trim()) {
      case 'USD (\$)':
        currencyIndex = 0;
        break;
      case 'TL (₺)':
        currencyIndex = 1;
        break;
      case 'EURO (€)':
        currencyIndex = 2;
        break;
      case 'GBP (£)':
        currencyIndex = 3;
        break;
      case 'JPY (¥)':
        currencyIndex = 4;
        break;
      case 'CHF (₣)':
        currencyIndex = 5;
        break;
      case 'INR (₹)':
        currencyIndex = 6;
        break;
    }

    // Emit a new state with the updated currency index
    emit(
      ActivityGetIndexState(
        state: state,
        requestNumber: state.requestNumber,
        owedMoneyTotals: state.owedMoneyTotals,
        requestedMoneyTotals: state.requestedMoneyTotals,
        requestCurrencyIndex: currencyIndex,
        debtCurrencyIndex: state.debtCurrencyIndex,
        filteredRequestedMoney: state.filteredRequestedMoney,
        filteredOwedMoney: state.filteredOwedMoney,
        combinedFilteredList: state.combinedFilteredList,
        friendsUserData: state.friendsUserData,
      ),
    );
  }

  FutureOr<void> _getDebtCurrency(
      ActivityDebtCurrencyEvent event, Emitter<ActivityState> emit) {
    // Helper function to determine currency index based on the currency string
    int currencyIndex = 0; // Default to USD
    switch (debtCurrencyController.text.trim()) {
      case 'USD (\$)':
        currencyIndex = 0;
        break;
      case 'TL (₺)':
        currencyIndex = 1;
        break;
      case 'EURO (€)':
        currencyIndex = 2;
        break;
      case 'GBP (£)':
        currencyIndex = 3;
        break;
      case 'JPY (¥)':
        currencyIndex = 4;
        break;
      case 'CHF (₣)':
        currencyIndex = 5;
        break;
      case 'INR (₹)':
        currencyIndex = 6;
        break;
    }

    // Emit a new state with the updated currency index
    emit(
      ActivityGetIndexState(
        state: state,
        requestNumber: state.requestNumber,
        owedMoneyTotals: state.owedMoneyTotals,
        requestedMoneyTotals: state.requestedMoneyTotals,
        requestCurrencyIndex: state.requestCurrencyIndex,
        debtCurrencyIndex: currencyIndex,
        filteredRequestedMoney: state.filteredRequestedMoney,
        filteredOwedMoney: state.filteredOwedMoney,
        combinedFilteredList: state.combinedFilteredList,
        friendsUserData: state.friendsUserData,
      ),
    );
  }

  FutureOr<void> _selectActivityType(
      ActivitySelectEvent event, Emitter<ActivityState> emit) {
    emit(
      ActivitySelectState(
        state: state,
        requestNumber: state.requestNumber,
        owedMoneyTotals: state.owedMoneyTotals,
        requestedMoneyTotals: state.requestedMoneyTotals,
        requestCurrencyIndex: state.requestCurrencyIndex,
        debtCurrencyIndex: state.debtCurrencyIndex,
        filteredRequestedMoney: state.filteredRequestedMoney,
        filteredOwedMoney: state.filteredOwedMoney,
        combinedFilteredList: state.combinedFilteredList,
        friendsUserData: state.friendsUserData,
      ),
    );
  }

  FutureOr<void> _fetchUserData(
      ActivityFetchUserDataEvent event, Emitter<ActivityState> emit) async {
    try {
      final friendsUserData =
          await fetchUserDataService.fetchUserData(userId: event.friendUserId);

      // Update the state with fetched friends data
      final updatedFriendsUserData =
          Map<String, dynamic>.from(state.friendsUserData)
            ..[event.friendUserId] = friendsUserData;

      // Emit the updated state
      emit(
        ActivityfriendsDataLoadedState(
          state: state,
          requestNumber: state.requestNumber,
          owedMoneyTotals: state.owedMoneyTotals,
          requestedMoneyTotals: state.requestedMoneyTotals,
          requestCurrencyIndex: state.requestCurrencyIndex,
          debtCurrencyIndex: state.debtCurrencyIndex,
          filteredRequestedMoney: state.filteredRequestedMoney,
          filteredOwedMoney: state.filteredOwedMoney,
          combinedFilteredList: state.combinedFilteredList,
          friendsUserData: updatedFriendsUserData,
        ),
      );
    } catch (e) {
      // Log the error
      // Optionally emit an error state if needed
    }
  }

  FutureOr<void> _deleteItem(
      ActivityDeleteEvent event, Emitter<ActivityState> emit) async {
    try {
      // Get the current user's ID
      String? currentUserId = AuthenticationRepository().getCurrentUserId();

      // Fetch the current user's data
      var currentUserData =
          await fetchUserDataService.fetchUserData(userId: currentUserId);

      // Check if the request ID is in the current user's `requestedMoney` list
      bool isInRequestedMoney = currentUserData['requestedMoney']
          .any((item) => item['requestId'] == event.requestId);

      // Check if the request ID is in the current user's `owedMoney` list
      bool isInOwedMoney = currentUserData['owedMoney']
          .any((item) => item['requestId'] == event.requestId);

      if (isInRequestedMoney) {
        // Remove the request from the `requestedMoney` list
        currentUserData['requestedMoney']
            .removeWhere((item) => item['requestId'] == event.requestId);

        // Update the current user's `requestedMoney` list in Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUserId)
            .update({'requestedMoney': currentUserData['requestedMoney']});
      } else if (isInOwedMoney) {
        // Remove the request from the `owedMoney` list
        currentUserData['owedMoney']
            .removeWhere((item) => item['requestId'] == event.requestId);

        // Update the current user's `owedMoney` list in Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUserId)
            .update({'owedMoney': currentUserData['owedMoney']});
      }
      add(ActivityInitialEvent(
          activityType: isInRequestedMoney ? 'Requests' : 'Debts'));
    } catch (e) {
      // Handle any errors
      throw Exception(e);
    }
  }
}
