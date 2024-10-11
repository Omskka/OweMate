// ignore_for_file: use_build_context_synchronously
import 'package:app_developments/app/theme/color_theme_util.dart';
import 'package:app_developments/core/auth/firebase_api.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:app_developments/core/auth/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_developments/app/views/view_request/view_model/request_event.dart';
import 'package:app_developments/app/views/view_request/view_model/request_state.dart';
import 'package:app_developments/core/auth/fetch_user_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class RequestViewModel extends Bloc<RequestEvent, RequestState> {
  String name = '';
  String gender = '';
  String email = '';
  String phoneNumber = '';
  String profileImageUrl = '';
  List friendsList = [];
  List requestList = [];
  final FetchUserData fetchUserDataService = FetchUserData();
  final TextEditingController currencyController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  // Define global key
  final formKey = GlobalKey<FormState>();

  RequestViewModel() : super(RequestInitialState()) {
    on<RequestInitialEvent>(_initial);
    on<RequestNavigateToNextPageEvent>(__navigateToNextPage);
    on<RequestUpdateCurrencyEvent>(_updateCurrency);
    on<RequestSendEvent>(_sendRequest);
  }

  FutureOr<void> _initial(
      RequestInitialEvent event, Emitter<RequestState> emit) async {
    try {
      emit(RequestLoadingState());

      // Fetch friends' data
      List<Map<String, String>> friends =
          await fetchUserDataService.fetchFriends();

      // Emit the state with the fetched friends data
      emit(
        RequestLoadFriendsState(
          friends: friends,
          state: state,
        ),
      );
    } catch (e) {
      // Handle the exception
      throw Exception(e);
    }
  }

  FutureOr<void> __navigateToNextPage(
      RequestNavigateToNextPageEvent event, Emitter<RequestState> emit) {
    emit(
      RequestPageIncrementState(
        selectedPage: event.selectedPage,
        selectedUser: event.selectedUser,
        state: state,
      ),
    );
  }

  FutureOr<void> _updateCurrency(
      RequestUpdateCurrencyEvent event, Emitter<RequestState> emit) {
    var selectedLabel = currencyController.text.trim();

    switch (selectedLabel) {
      case 'TL':
        selectedLabel = '₺';
        break; // Added break

      case 'USD':
        selectedLabel = '\$';
        break; // Added break

      case 'EURO':
        selectedLabel = '€';
        break; // Added break

      case 'GBP':
        selectedLabel = '£';
        break; // Added break

      case 'JPY':
        selectedLabel = '¥';
        break; // Added break

      case 'INR':
        selectedLabel = '₹';
        break; // Added break

      case 'CHF':
        selectedLabel = '₣';
        break; // Added break

      default:
      // Handle unknown currency label
    }
    emit(
      RequestUpdateCurrencyState(
        prefix: selectedLabel,
        friends: state.friends,
        state: state,
      ),
    );
  }

  FutureOr<void> _sendRequest(
      RequestSendEvent event, Emitter<RequestState> emit) async {
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

      // Fetch current user ID
      String? currentUserId = AuthenticationRepository().getCurrentUserId();

      // Get the selected friend ID and the amount to request from the event
      String? friendUserId = event.selectedUser![0]['userId'];
      double amount = double.tryParse(amountController.text.trim()) ?? 0.0;
      String? currencyPrefix = event.prefix;

      // Combine prefix and amount
      String formattedAmount = '$currencyPrefix$amount';

      // Get the current date and format it
      String formattedDate = DateFormat('MMMM d, yyyy').format(DateTime.now());

      // Generate a unique request ID
      var uuid = Uuid();
      String requestId = uuid.v4();

      // Define Firestore instance
      final firestore = FirebaseFirestore.instance;

      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(friendUserId)
          .get();

      DocumentSnapshot currentUserDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserId)
          .get();

      String? currentUserName = currentUserDoc.get('name');

      // Check if the user document exists
      if (userDoc.exists) {
        // Get the token field from the user document
        String? token = userDoc.get('token');

        if (token != null && token.isNotEmpty) {
          // Send the push message
          await FirebaseApi().sendPushMessage(friendUserId!, token,
              '$currentUserName sent you a money request.', 'New Request');
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

      // Update current user's requestMoney array
      await firestore.collection('users').doc(currentUserId).update({
        'requestedMoney': FieldValue.arrayUnion([
          {
            'requestId': requestId,
            'amount': formattedAmount,
            'friendUserId': friendUserId,
            'message': messageController.text.trim(),
            'date': formattedDate,
            'status': 'pending'
          },
        ]),
      });

      // Update friend's owedMoney array
      await firestore.collection('users').doc(friendUserId).update(
        {
          'owedMoney': FieldValue.arrayUnion(
            [
              {
                'requestId': requestId,
                'amount': formattedAmount,
                'friendUserId': currentUserId,
                'message': messageController.text.trim(),
                'date': formattedDate,
                'status': 'pending'
              },
            ],
          ),
        },
      );

      emit(RequestSuccessState(state: state));

      // Close the loading circle after the update is done
      Navigator.of(event.context).pop();
    } catch (e) {
      // Handle errors
      if (!kReleaseMode) {
        print('Error sending request: $e');
      }
      Navigator.of(event.context).pop();
    }
  }
}
