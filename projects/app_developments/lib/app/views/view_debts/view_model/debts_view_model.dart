// ignore_for_file: invalid_use_of_visible_for_testing_member
import 'dart:async';
import 'package:app_developments/core/extension/context_extension.dart';
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
      emit(
        DebtsDataLoadedState(
          requestNumber: requestList,
          state: state,
        ),
      );
    } catch (e) {
      // Throw exception
      throw Exception('$e');
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
