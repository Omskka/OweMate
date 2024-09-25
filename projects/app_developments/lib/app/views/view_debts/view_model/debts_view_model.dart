// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:async';
import 'package:app_developments/app/theme/color_theme_util.dart';
import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:app_developments/core/extension/context_extension.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:app_developments/app/views/view_debts/view_model/debts_event.dart';
import 'package:app_developments/app/views/view_debts/view_model/debts_state.dart';
import 'package:app_developments/core/auth/fetch_user_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DebtsViewModel extends Bloc<DebtsEvent, DebtsState> {
  // Define global keys for the tutorial
  final GlobalKey debtsKey = GlobalKey();
  final GlobalKey requestsKey = GlobalKey();

  DebtsViewModel() : super(DebtsInitialState()) {
    on<DebtsInitialEvent>(_initial);
    on<DebtsDrawerOpenedEvent>(_onDrawerOpened);
    on<DebtsDrawerClosedEvent>(_onDrawerClosed);
  }

  // Define key for drawer
  GlobalKey drawerKey = GlobalKey();

  StreamSubscription? _internetConnection;
  final bool isConnectedToInternet = false;

  final FetchUserData fetchUserDataService = FetchUserData();
  final formKey = GlobalKey<FormState>();

  String name = '';
  String gender = '';
  String email = '';
  String profileImageUrl = '';
  List friendsList = [];
  List requestList = [];

  bool isDrawerOpen = false; // Property to track drawer state

  // Method to create the tutorial
  Future<void> createTutorial(BuildContext context) async {
    final targets = [
      TargetFocus(
        identify: 'requests',
        keyTarget: requestsKey,
        enableOverlayTab: true,
        alignSkip: Alignment.bottomCenter,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            padding: EdgeInsets.only(top: context.onlyTopPaddingHigh.top * 1.5),
            builder: (context, controller) => Center(
              child: Text(
                'Request money from friends',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      TargetFocus(
        identify: 'debts',
        keyTarget: debtsKey,
        alignSkip: Alignment.bottomCenter,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            padding: EdgeInsets.only(
                bottom: context.onlyBottomPaddingHigh.bottom * 1.5),
            builder: (context, controller) => Center(
              child: Text(
                'Settle your debts',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    ];

    final tutorial = TutorialCoachMark(
      targets: targets,
    );

    // Delay to ensure everything is built before showing the tutorial
    Future.delayed(const Duration(milliseconds: 500), () {
      tutorial.show(context: context);
    });
  }

  // Initial event
  FutureOr<void> _initial(
      DebtsInitialEvent event, Emitter<DebtsState> emit) async {
    try {
      // Check for internet connection before proceeding
      _checkInternetConnection(event.context);

      // Fetch user data
      final userData = await fetchUserDataService.fetchUserData();
      name = userData['firstName']!;
      gender = userData['gender']!;
      email = userData['email']!;
      profileImageUrl = userData['profileImageUrl']!;
      friendsList = userData['friendsList']!;
      requestList = userData['requestList']!;

      // Show tutorial only on the first launch
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool hasSeenFinanceTutorial =
          prefs.getBool('hasSeenFinanceTutorial') ?? false;

      if (!hasSeenFinanceTutorial) {
        createTutorial(event.context);
        prefs.setBool('hasSeenFinanceTutorial', true);
      }
      // Emit the loaded state with the fetched data
      emit(DebtsDataLoadedState(requestNumber: requestList, state: state));
    } catch (e) {
      // Throw exception
      throw Exception('$e');
    }
  }

  void _checkInternetConnection(BuildContext context) {
    try {
      _internetConnection = InternetConnection().onStatusChange.listen((event) {
        switch (event) {
          case InternetStatus.connected:
            if (state.isConnectedToInternet == false ||
                state.isConnectedToInternet == null) {
              _showInternetConnectedDialog(context);
            }
            emit(
              DebtsInternetState(
                state: state,
                requestNumber: state.requestNumber,
                isConnectedToInternet: true,
              ),
            );
            break;
          case InternetStatus.disconnected:
            emit(
              DebtsInternetState(
                state: state,
                requestNumber: state.requestNumber,
                isConnectedToInternet: false,
              ),
            );
            _showNoInternetDialog(context);
            break;
          default:
            emit(
              DebtsInternetState(
                state: state,
                requestNumber: state.requestNumber,
                isConnectedToInternet: false,
              ),
            );
            _showNoInternetDialog(context);
            break;
        }
      });
    } catch (e) {
      throw Exception();
    }
  }

// Declare a variable to keep track of the dialog
  BuildContext? _noInternetDialogContext;

  void _showNoInternetDialog(BuildContext context) {
    try {
      // If the dialog is already open, do nothing
      if (_noInternetDialogContext != null) return;

      // Store the current dialog context to dismiss later
      _noInternetDialogContext = context;

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext dialogContext) {
          // Use dialogContext for dialog management
          _noInternetDialogContext =
              dialogContext; // Update to correct dialog context
          return AlertDialog(
            title: Center(
              child: Text(
                'No Internet Connection',
                style:
                    TextStyle(color: ColorThemeUtil.getBgInverseColor(context)),
              ),
            ),
            content: Column(
              mainAxisSize:
                  MainAxisSize.min, // Prevents the dialog from being too tall
              children: [
                const Icon(
                  Icons.wifi_off,
                  color: AppLightColorConstants.errorColor,
                  size: 35,
                ),
                const SizedBox(height: 16), // Space between icon and text
                Text(
                  'Please check your internet connection and try again.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ColorThemeUtil.getBgInverseColor(context),
                  ),
                ),
              ],
            ),
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }

  void _showInternetConnectedDialog(BuildContext context) {
    try {
      // Dismiss the no internet dialog if it's being displayed
      if (_noInternetDialogContext != null) {
        // Check if the dialog context is still valid (mounted) before dismissing
        if (Navigator.canPop(_noInternetDialogContext!)) {
          Navigator.of(_noInternetDialogContext!).pop(); // Close the dialog
        }
        _noInternetDialogContext = null; // Reset the dialog context
      }

      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: Center(
              child: Text(
                'You\'re Back Online',
                style:
                    TextStyle(color: ColorThemeUtil.getBgInverseColor(context)),
              ),
            ),
            content: Column(
              mainAxisSize:
                  MainAxisSize.min, // Prevents the dialog from being too tall
              children: [
                const Icon(
                  Icons.wifi,
                  color: AppLightColorConstants.successColor,
                  size: 35,
                ),
                const SizedBox(height: 16), // Space between icon and text
                Text(
                  'You are now connected to the internet.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ColorThemeUtil.getBgInverseColor(context),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(dialogContext)
                      .pop(); // Use correct dialog context for closing
                },
                child: Center(
                  child: Text(
                    'Continue',
                    style: TextStyle(
                        color: ColorThemeUtil.getPrimaryColor(context)),
                  ),
                ),
              ),
            ],
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }

  void _onDrawerOpened(DebtsDrawerOpenedEvent event, Emitter<DebtsState> emit) {
    isDrawerOpen = true; // Update drawer state
    emit(DebtsDrawerOpenedState(
        state: state, requestNumber: state.requestNumber));
  }

  void _onDrawerClosed(DebtsDrawerClosedEvent event, Emitter<DebtsState> emit) {
    isDrawerOpen = false; // Update drawer state
    emit(DebtsDrawerClosedState(
        state: state, requestNumber: state.requestNumber));
  }

  @override
  void dispose() {
    _internetConnection?.cancel();
  }
}
