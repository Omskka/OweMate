// ignore_for_file: use_build_context_synchronously, invalid_use_of_visible_for_testing_member

import 'dart:async';
import 'package:app_developments/app/theme/color_theme_util.dart';
import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:app_developments/core/extension/context_extension.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:app_developments/app/views/view_friends/view_model/friends_event.dart';
import 'package:app_developments/app/views/view_friends/view_model/friends_state.dart';
import 'package:app_developments/core/auth/authentication_repository.dart';
import 'package:app_developments/core/auth/fetch_user_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FriendsViewModel extends Bloc<FriendsEvent, FriendsState> {
  final TextEditingController friendsSearchController = TextEditingController();

  String name = '';
  String gender = '';
  String email = '';
  String profileImageUrl = '';
  List friendsList = [];
  List requestList = [];
  List<Map<String, String>> allFriends = [];

  // Define global keys for the tutorial
  final GlobalKey addFriendKey = GlobalKey();
  final GlobalKey searchFriendKey = GlobalKey();

  StreamSubscription? _internetConnection;
  final bool isConnectedToInternet = false;

  final FetchUserData fetchUserDataService = FetchUserData();
  final formKey = GlobalKey<FormState>();

  FriendsViewModel() : super(FriendsInitialState()) {
    on<FriendsInitialEvent>(_initial);
    on<FriendsSearchEvent>(_searchFriend);
    on<FriendsRemoveFriendEvent>(_removeFriend);
  }

  // Method to create the tutorial
  Future<void> createTutorial(BuildContext context) async {
    final targets = [
      TargetFocus(
        identify: 'addFriends',
        keyTarget: addFriendKey,
        enableOverlayTab: true,
        alignSkip: Alignment.bottomCenter,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            padding: EdgeInsets.only(
                bottom: context.onlyBottomPaddingHigh.bottom * 1.5),
            builder: (context, controller) => Center(
              child: Text(
                'Add friends',
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
        identify: 'searchFriends',
        keyTarget: searchFriendKey,
        alignSkip: Alignment.bottomCenter,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            padding: EdgeInsets.only(top: context.onlyTopPaddingHigh.top * 1.5),
            builder: (context, controller) => Center(
              child: Text(
                'Search friends',
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

  FutureOr<void> _initial(
      FriendsInitialEvent event, Emitter<FriendsState> emit) async {
    try {
      emit(FriendsLoadingState());

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

      // Fetch friends' data
      List<Map<String, String>> friends =
          await fetchUserDataService.fetchFriends();

      // Show tutorial only on the first launch
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool hasSeenFriendsTutorial =
          prefs.getBool('hasSeenFriendsTutorial') ?? false;

      if (!hasSeenFriendsTutorial) {
        createTutorial(event.context);
        prefs.setBool('hasSeenFriendsTutorial', true);
      }

      // Emit the state with the fetched friends data
      emit(FriendsDataLoadedState(
        friends: friends,
        state: state,
        requestNumber: requestList,
      ));
    } catch (e) {
      // Handle the exception
      throw Exception('Failed to fetch data: $e');
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
              FriendsInternetState(
                state: state,
                requestNumber: state.requestNumber,
                friends: state.friends,
                isConnectedToInternet: true,
              ),
            );
            break;
          case InternetStatus.disconnected:
            emit(
              FriendsInternetState(
                state: state,
                requestNumber: state.requestNumber,
                friends: state.friends,
                isConnectedToInternet: false,
              ),
            );
            _showNoInternetDialog(context);
            break;
          default:
            emit(
              FriendsInternetState(
                state: state,
                requestNumber: state.requestNumber,
                friends: state.friends,
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
      // Dismiss the no internet dialog if it's being displayed
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

  FutureOr<void> _searchFriend(
      FriendsSearchEvent event, Emitter<FriendsState> emit) async {
    try {
      // Get the search query from the TextEditingController
      String query = friendsSearchController.text.trim().toLowerCase();

      // Clear the list before fetching new data
      allFriends.clear();

      // Fetch friends' data
      allFriends = await fetchUserDataService.fetchFriends();
      // Filter friends based on the search query
      List<Map<String, String>> matchedFriends;
      if (query.isEmpty) {
        // If the search query is empty, return an empty list
        matchedFriends = allFriends;
      } else {
        matchedFriends = allFriends.where((user) {
          String firstName = user['Name']?.toLowerCase() ?? '';
          return firstName.contains(query);
        }).toList();
      }

      // Emit the state with the matched friends data
      emit(FriendsSearchedState(
        friends: matchedFriends,
        state: state,
        requestNumber: requestList,
      ));
    } catch (e) {
      // Handle the exception
      throw Exception('Failed to search friends: $e');
    }
  }

  FutureOr<void> _removeFriend(
      FriendsRemoveFriendEvent event, Emitter<FriendsState> emit) async {
    try {
      // Get current user ID
      String? userId = AuthenticationRepository().getCurrentUserId();
      // Get friend's ID
      String friendId = event.friendId;

      if (userId == null) {
        throw Exception("User ID is not available");
      }

      // Fetch current user data
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      // Fetch friend data
      DocumentSnapshot friendDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(friendId)
          .get();

      if (!friendDoc.exists) {
        throw Exception("Friend data not found");
      }

      // Update Firestore: Remove friendId from the current user's friendsList
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'friendsList': FieldValue.arrayRemove([friendId]),
      });

      // Update Firestore: Remove current user ID from the friend's friendsList
      await FirebaseFirestore.instance
          .collection('users')
          .doc(friendId)
          .update({
        'friendsList': FieldValue.arrayRemove([userId]),
      });

      // Fetch and emit updated friends list
      add(FriendsInitialEvent(context: event.context));
    } catch (e) {
      throw Exception('Failed to remove friend: $e');
    }
  }

  @override
  void dispose() {
    _internetConnection?.cancel();
  }
}
