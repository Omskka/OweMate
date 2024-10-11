// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:app_developments/app/theme/color_theme_util.dart';
import 'package:app_developments/core/auth/authentication_repository.dart';
import 'package:app_developments/core/auth/firebase_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_developments/app/views/view_settle/view_model/settle_event.dart';
import 'package:app_developments/app/views/view_settle/view_model/settle_state.dart';
import 'package:app_developments/core/auth/fetch_user_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettleViewModel extends Bloc<SettleEvent, SettleState> {
  String name = '';
  String gender = '';
  String email = '';
  String profileImageUrl = '';
  List friendsList = [];
  List requestList = [];
  List requestedMoney = [];
  List owedMoney = [];

  final TextEditingController declineMessageController =
      TextEditingController();
  final TextEditingController paidMessageController = TextEditingController();

  // Define global key
  final formKey = GlobalKey<FormState>();

  final FetchUserData fetchUserDataService = FetchUserData();
  SettleViewModel() : super(SettleInitialState()) {
    on<SettleInitialEvent>(_initial);
    on<SettlefetchRequestDataEvent>(_fetchFriendsData);
    on<SettleNavigateToNextPageEvent>(_navigateToNextPage);
    on<SettleDeclineRequestEvent>(_declineRequest);
    on<SettlePayRequestEvent>(_payRequest);
  }

  FutureOr<void> _initial(
      SettleInitialEvent event, Emitter<SettleState> emit) async {
    try {
      emit(SettleLoadingState());
      final userData = await fetchUserDataService.fetchUserData();
      name = userData['firstName']!;
      gender = userData['gender']!;
      email = userData['email']!;
      profileImageUrl = userData['profileImageUrl']!;
      friendsList = userData['friendsList']!;
      requestList = userData['requestList']!;
      requestedMoney = userData['requestedMoney'];
      owedMoney = userData['owedMoney'];
      emit(
        SettleDataLoadedState(
          userData: userData,
          state: state,
        ),
      );
    } catch (e) {
      throw Exception('$e');
    }
  }

  FutureOr<void> _fetchFriendsData(
      SettlefetchRequestDataEvent event, Emitter<SettleState> emit) async {
    try {
      final friendsUserData =
          await fetchUserDataService.fetchUserData(userId: event.friendsUserId);

      // Update the state with fetched friends data
      final updatedFriendsUserData =
          Map<String, dynamic>.from(state.friendsUserData)
            ..[event.friendsUserId] = friendsUserData;

      // Emit the updated state
      emit(
        SettlefriendsDataLoadedState(
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

  FutureOr<void> _navigateToNextPage(
      SettleNavigateToNextPageEvent event, Emitter<SettleState> emit) {
    try {
      emit(
        SettlePageIncrementState(
          state: state,
          selectedPage: event.selectedPage,
          index: event.index!,
        ),
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  FutureOr<void> _declineRequest(
      SettleDeclineRequestEvent event, Emitter<SettleState> emit) async {
    try {
      // Show loading circle
      showDialog(
        context: event.context,
        builder: (context) {
          return Center(
              child: CircularProgressIndicator(
            color: ColorThemeUtil.getContentTeritaryColor(context),
          ));
        },
      );

      // Get current user ID
      String? userId = AuthenticationRepository().getCurrentUserId();
      if (userId == null) {
        throw Exception('User ID is null');
      }

      // Reference to the current user's document
      DocumentReference currentUserDoc =
          FirebaseFirestore.instance.collection('users').doc(userId);

      // Fetch the current user's document
      DocumentSnapshot currentUserSnapshot = await currentUserDoc.get();
      Map<String, dynamic>? currentUserData =
          currentUserSnapshot.data() as Map<String, dynamic>?;

      if (currentUserData == null) {
        throw Exception('User data is null');
      }

      // Get the owedMoney array for the current user
      List<dynamic> owedMoney = currentUserData['owedMoney'] ?? [];

      // Update the transaction status to 'declined' and add the decline message
      for (var transaction in owedMoney) {
        if (transaction['requestId'] == event.requestId) {
          transaction['status'] = 'declined';
          transaction['declineMessage'] = declineMessageController.text.trim();
          break;
        }
      }

      // Update the current user's owedMoney array in Firestore
      await currentUserDoc.update({
        'owedMoney': owedMoney,
      });

      // Get the friend's user ID from the transaction
      String friendUserId = owedMoney.firstWhere((transaction) =>
          transaction['requestId'] == event.requestId)['friendUserId'];

      // Reference to the friend's document
      DocumentReference friendUserDoc =
          FirebaseFirestore.instance.collection('users').doc(friendUserId);
      // Define Firestore instance

      final firestore = FirebaseFirestore.instance;

      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(friendUserId)
          .get();

      String? currentUserName = currentUserSnapshot.get('name');

      // Check if the user document exists
      if (userDoc.exists) {
        // Get the token field from the user document
        String? token = userDoc.get('token');

        if (token != null && token.isNotEmpty) {
          // Send the push message
          await FirebaseApi().sendPushMessage(friendUserId, token,
              '$currentUserName declined your request.', 'Request declined');
        } else {
          if (!kReleaseMode) {
            print('No FCM token found for the recipient.');
          }
        }
      } else {
        if (!kReleaseMode) {
          print('User does not exist in Firestore.');
        }
      }

      // Fetch the friend's document
      DocumentSnapshot friendUserSnapshot = await friendUserDoc.get();
      Map<String, dynamic>? friendUserData =
          friendUserSnapshot.data() as Map<String, dynamic>?;

      if (friendUserData == null) {
        throw Exception('Friend user data is null');
      }

      // Get the requestedMoney array for the friend
      List<dynamic> requestedMoney = friendUserData['requestedMoney'] ?? [];

      // Update the transaction status to 'declined' and add the decline message
      for (var transaction in requestedMoney) {
        if (transaction['requestId'] == event.requestId &&
            transaction['friendUserId'] == userId) {
          transaction['status'] = 'declined';
          transaction['declineMessage'] = declineMessageController.text.trim();
          break;
        }
      }

      // Update the friend's requestedMoney array in Firestore
      await friendUserDoc.update({
        'requestedMoney': requestedMoney,
      });

      // Dismiss the loading circle dialog
      Navigator.of(event.context).pop();

      // Optionally navigate to the next page
      add(
        SettleNavigateToNextPageEvent(
          context: event.context,
          selectedPage: 4,
          index: -1,
        ),
      );
    } catch (e) {
      // Dismiss the loading circle dialog
      Navigator.of(event.context).pop();
      throw Exception('Failed to decline request: $e');
    }
  }

  FutureOr<void> _payRequest(
      SettlePayRequestEvent event, Emitter<SettleState> emit) async {
    try {
      // Show loading circle
      showDialog(
        context: event.context,
        builder: (context) {
          return Center(
              child: CircularProgressIndicator(
            color: ColorThemeUtil.getContentTeritaryColor(context),
          ));
        },
      );

      // Get current user ID
      String? userId = AuthenticationRepository().getCurrentUserId();
      if (userId == null) {
        throw Exception('User ID is null');
      }

      // Reference to the current user's document
      DocumentReference currentUserDoc =
          FirebaseFirestore.instance.collection('users').doc(userId);

      // Fetch the current user's document
      DocumentSnapshot currentUserSnapshot = await currentUserDoc.get();
      Map<String, dynamic>? currentUserData =
          currentUserSnapshot.data() as Map<String, dynamic>?;

      if (currentUserData == null) {
        throw Exception('User data is null');
      }

      // Get the owedMoney array for the current user
      List<dynamic> owedMoney = currentUserData['owedMoney'] ?? [];

      // Update the transaction status to 'paid' and add the paid message
      bool updated = false; // Track if the update was successful
      for (var transaction in owedMoney) {
        if (transaction['requestId'] == event.requestId) {
          transaction['status'] = 'paid';
          transaction['paidMessage'] = paidMessageController.text.trim();
          updated = true;
          break;
        }
      }

      if (!updated) {
        throw Exception('Transaction not found in owedMoney');
      }

      // Update the current user's owedMoney array in Firestore
      await currentUserDoc.update({
        'owedMoney': owedMoney,
      });

      // Get the friend's user ID from the transaction
      String friendUserId = owedMoney.firstWhere((transaction) =>
          transaction['requestId'] == event.requestId)['friendUserId'];

      // Reference to the friend's document
      DocumentReference friendUserDoc =
          FirebaseFirestore.instance.collection('users').doc(friendUserId);

      // Fetch the friend's document
      DocumentSnapshot friendUserSnapshot = await friendUserDoc.get();
      Map<String, dynamic>? friendUserData =
          friendUserSnapshot.data() as Map<String, dynamic>?;

      if (friendUserData == null) {
        throw Exception('Friend user data is null');
      }

      // Get the requestedMoney array for the friend
      List<dynamic> requestedMoney = friendUserData['requestedMoney'] ?? [];

      // Update the transaction status to 'paid' and add the paid message
      updated = false; // Track if the update was successful
      for (var transaction in requestedMoney) {
        if (transaction['requestId'] == event.requestId &&
            transaction['friendUserId'] == userId) {
          transaction['status'] = 'paid';
          transaction['paidMessage'] = paidMessageController.text.trim();
          updated = true;
          break;
        }
      }
      // Define Firestore instance

      final firestore = FirebaseFirestore.instance;

      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(friendUserId)
          .get();

      String? currentUserName = currentUserSnapshot.get('name');

      // Check if the user document exists
      if (userDoc.exists) {
        // Get the token field from the user document
        String? token = userDoc.get('token');

        if (token != null && token.isNotEmpty) {
          // Send the push message
          await FirebaseApi().sendPushMessage(friendUserId, token,
              '$currentUserName paid your request.', 'Request Paid');
        } else {
          if (!kReleaseMode) {
            print('No FCM token found for the recipient.');
          }
        }
      } else {
        if (!kReleaseMode) {
          print('User does not exist in Firestore.');
        }
      }

      if (!updated) {
        throw Exception('Transaction not found in requestedMoney');
      }

      // Update the friend's requestedMoney array in Firestore
      await friendUserDoc.update({
        'requestedMoney': requestedMoney,
      });

      // Dismiss the loading circle dialog
      Navigator.of(event.context).pop();

      // Optionally navigate to the next page
      add(
        SettleNavigateToNextPageEvent(
          context: event.context,
          selectedPage: 5,
          index: -1,
        ),
      );
    } catch (e) {
      // Dismiss the loading circle dialog
      Navigator.of(event.context).pop();
      throw Exception('Failed to pay request: $e');
    }
  }
}
