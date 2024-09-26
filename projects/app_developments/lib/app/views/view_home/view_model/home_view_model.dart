// ignore_for_file: invalid_use_of_visible_for_testing_member, use_build_context_synchronously

import 'dart:async';
import 'package:app_developments/app/theme/color_theme_util.dart';
import 'package:app_developments/core/auth/authentication_repository.dart';
import 'package:app_developments/core/auth/fetch_user_data.dart';
import 'package:app_developments/core/auth/shared_preferences/preferencesService.dart';
import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeViewModel extends Bloc<HomeEvent, HomeState> {
  // Define global keys for the tutorial
  final GlobalKey debtsKey = GlobalKey();
  final GlobalKey requestsKey = GlobalKey();
  final GlobalKey navbarDebtsKey = GlobalKey();

  StreamSubscription? _internetConnection;
  final bool isConnectedToInternet = false;

  final FetchUserData fetchUserDataService = FetchUserData();
  final PreferencesService preferencesService = PreferencesService();

  HomeViewModel() : super(HomeInitialState()) {
    on<HomeInitialEvent>(_initial);
    on<HomeDrawerOpenedEvent>(_onDrawerOpened);
    on<HomeDrawerClosedEvent>(_onDrawerClosed);
    on<HomefetchRequestDataEvent>(_fetchFriendsData);
    on<HomefetchDeleteRequestEvent>(_deleteRequest);
  }

  // Method to create the tutorial
  Future<void> createTutorial(BuildContext context) async {
    final targets = [
      TargetFocus(
        identify: 'debts',
        keyTarget: debtsKey,
        alignSkip: Alignment.bottomCenter,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.right,
            builder: (context, controller) => Text(
              'View your debts here',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
      TargetFocus(
        identify: 'requests',
        keyTarget: requestsKey,
        enableOverlayTab: true,
        alignSkip: Alignment.bottomCenter,
        contents: [
          TargetContent(
            align: ContentAlign.right,
            builder: (context, controller) => Text(
              'view your requests here',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Colors.white),
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

  // Define key for drawer
  GlobalKey drawerKey = GlobalKey();

  final formKey = GlobalKey<FormState>();
  String name = '';
  String gender = '';
  String email = '';
  String profileImageUrl = '';
  List friendsList = [];
  List requestList = [];
  List requestedMoney = [];
  List owedMoney = [];

  bool isDrawerOpen = false;

  FutureOr<void> _initial(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    try {
      emit(HomeLoadingState());
      final isOrderReversed = await preferencesService.loadOrderPreference();
      // Check for internet connection before proceeding
      _checkInternetConnection(event.context);

      // Fetch user data
      final userData = await fetchUserDataService.fetchUserData();
      name = userData['firstName'];
      gender = userData['gender'];
      email = userData['email'];
      profileImageUrl = userData['profileImageUrl'];
      friendsList = userData['friendsList'];
      requestList = userData['requestList'];
      requestedMoney = List.from(userData['requestedMoney'].reversed);
      owedMoney = List.from(userData['owedMoney'].reversed);

      // Show tutorial only on the first launch
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool hasSeenHomeTutorial = prefs.getBool('hasSeenHomeTutorial') ?? false;

      if (!hasSeenHomeTutorial) {
        createTutorial(event.context);
        prefs.setBool('hasSeenHomeTutorial', true);
      }

      emit(HomeDataLoadedState(
        userData: userData,
        state: state,
        isOrderReversed: isOrderReversed,
        friendsUserData: {},
      ));
    } catch (e) {
      throw Exception(e);
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
              HomeInternetState(
                state: state,
                userData: state.userData,
                friendsUserData: state.friendsUserData,
                isConnectedToInternet: true,
              ),
            );
            break;
          case InternetStatus.disconnected:
            emit(
              HomeInternetState(
                state: state,
                userData: state.userData,
                friendsUserData: state.friendsUserData,
                isConnectedToInternet: false,
              ),
            );
            _showNoInternetDialog(context);
            break;
          default:
            emit(
              HomeInternetState(
                state: state,
                userData: state.userData,
                friendsUserData: state.friendsUserData,
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
        builder: (BuildContext context) {
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
      Navigator.of(_noInternetDialogContext!)
          .pop(); // Close the no internet dialog
      _noInternetDialogContext = null; // Reset the dialog context

      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
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
                  Navigator.of(context).pop();
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

  int fetchRequestNumber(List requestList) {
    return requestList.isEmpty ? 0 : requestList.length;
  }

  void _onDrawerOpened(HomeDrawerOpenedEvent event, Emitter<HomeState> emit) {
    isDrawerOpen = true; // Update drawer state
    emit(
      HomeDrawerOpenedState(
          userData: state.userData,
          state: state,
          friendsUserData: state.friendsUserData),
    );
  }

  void _onDrawerClosed(HomeDrawerClosedEvent event, Emitter<HomeState> emit) {
    isDrawerOpen = false; // Update drawer state
    emit(
      HomeDrawerClosedState(
          userData: state.userData,
          state: state,
          friendsUserData: state.friendsUserData),
    );
  }

  FutureOr<void> _fetchFriendsData(
      HomefetchRequestDataEvent event, Emitter<HomeState> emit) async {
    try {
      final friendsUserData =
          await fetchUserDataService.fetchUserData(userId: event.friendsUserId);

      // Update the state with fetched friends data
      final updatedFriendsUserData =
          Map<String, dynamic>.from(state.friendsUserData)
            ..[event.friendsUserId] = friendsUserData;

      // Emit the updated state
      emit(
        HomefriendsDataLoadedState(
          userData: state.userData,
          friendsUserData: updatedFriendsUserData,
          state: state,
        ),
      );
    } catch (e) {
      // Log the error
      // Optionally emit an error state if needed
    }
  }

  FutureOr<void> _deleteRequest(
      HomefetchDeleteRequestEvent event, Emitter<HomeState> emit) async {
    try {
      // Get the current user's ID
      String? currentUserId = AuthenticationRepository().getCurrentUserId();

      // Fetch current user's data
      var currentUserData =
          await fetchUserDataService.fetchUserData(userId: currentUserId);

      // Check if friend's user data exists
      var friendUserDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(event.friendUserId)
          .get();

      // Remove the request from the current user's `requestedMoney` list
      currentUserData['requestedMoney']
          .removeWhere((item) => item['requestId'] == event.requestId);

      // Update the current user's data in Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserId)
          .update({'requestedMoney': currentUserData['requestedMoney']});

      // Proceed to remove the request from friend's `owedMoney` list only if the friend's document exists
      if (friendUserDoc.exists) {
        var friendUserData = friendUserDoc.data();

        // Ensure `owedMoney` exists in friend's data before trying to remove
        if (friendUserData != null && friendUserData['owedMoney'] != null) {
          friendUserData['owedMoney']
              .removeWhere((item) => item['requestId'] == event.requestId);

          // Update the friend's data in Firestore
          await FirebaseFirestore.instance
              .collection('users')
              .doc(event.friendUserId)
              .update({'owedMoney': friendUserData['owedMoney']});
        }
      } else {
        print('Friend user does not exist, skipping deletion from owedMoney.');
      }

      // Add HomeInitialEvent to refresh requests on the page
      add(HomeInitialEvent(context: event.context));
    } catch (e) {
      // Handle any errors
      print('Error in _deleteRequest: ${e.toString()}');
      throw Exception(e);
    }
  }

  @override
  void dispose() {
    _internetConnection?.cancel();
  }
}
