// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:app_developments/app/views/view_notifications/view_model/notifications_event.dart';
import 'package:app_developments/app/views/view_notifications/view_model/notifications_state.dart';
import 'package:app_developments/core/auth/authentication_repository.dart';
import 'package:app_developments/core/auth/fetch_user_data.dart';
import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:app_developments/core/widgets/custom_flutter_toast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationsViewModel
    extends Bloc<NotificationsEvent, NotificationsState> {
  List<String> requestList = [];

  final FetchUserData fetchUserDataService = FetchUserData();

  NotificationsViewModel() : super(NotificationsInitialState()) {
    on<NotificationsInitialEvent>(_initial);
    on<NotificationsAcceptEvent>(_acceptRequest);
    on<NotificationsDeclineEvent>(_declineRequest);
  }

  FutureOr<void> _initial(
      NotificationsInitialEvent event, Emitter<NotificationsState> emit) async {
    try {
      final userData = await fetchUserDataService.fetchUserData();
      requestList = List<String>.from(userData['requestList']!);

      // Fetch user data for each user ID in requestList using fetchAllUsersData method
      List<Map<String, String>> allUsersData =
          await fetchUserDataService.fetchAllUsersData();

      // Filter the users whose IDs are in the requestList
      List<Map<String, String>> friendRequestsData = allUsersData
          .where((user) => requestList.contains(user['userId']))
          .toList();

      // Emit the state with the fetched friend request data
      emit(NotificationsFetchDataState(friendRequests: friendRequestsData));
    } catch (e) {
      throw Exception('$e');
    }
  }

  FutureOr<void> _acceptRequest(
      NotificationsAcceptEvent event, Emitter<NotificationsState> emit) async {
    try {
      String? userId = AuthenticationRepository().getCurrentUserId();
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

      Map<String, dynamic>? friendData =
          friendDoc.data() as Map<String, dynamic>?;
      if (friendData == null) {
        throw Exception("Friend data is null or not of expected type");
      }

      // Update both users' friends lists
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'friendsList': FieldValue.arrayUnion([friendId]),
        'requestList': FieldValue.arrayRemove([friendId]),
      });

      await FirebaseFirestore.instance
          .collection('users')
          .doc(friendId)
          .update({
        'friendsList': FieldValue.arrayUnion([userId]),
      });

      // Fetch updated data
      final updatedUserData = await fetchUserDataService.fetchUserData();

      List<dynamic> requestList = updatedUserData['requestList'];
      List<Map<String, dynamic>> updatedRequests = [];

      for (var item in requestList) {
        if (item is Map<String, dynamic>) {
          updatedRequests.add(item);
        }
      }

      // Emit the updated state
      emit(NotificationsFetchDataState(friendRequests: updatedRequests));

      // Show success message
      CustomFlutterToast(
        backgroundColor: AppLightColorConstants.successColor,
        context: event.context,
        msg: 'Added to Friends',
      ).flutterToast();
    } catch (e) {
      // Handle any errors that occur
      throw Exception('Failed to accept friend request: $e');
    }
  }

  FutureOr<void> _declineRequest(
      NotificationsDeclineEvent event, Emitter<NotificationsState> emit) async {
    try {
      // Get current user ID
      String? userId = AuthenticationRepository().getCurrentUserId();
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

      Map<String, dynamic>? friendData =
          friendDoc.data() as Map<String, dynamic>?;
      if (friendData == null) {
        throw Exception("Friend data is null or not of expected type");
      }

      // Update Firestore: Remove friendId from the current user's requestList
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'requestList': FieldValue.arrayRemove([friendId]),
      });

      // Fetch updated data to reflect changes in the UI
      final updatedUserData = await fetchUserDataService.fetchUserData();

      List<dynamic> requestList = updatedUserData['requestList'];
      List<Map<String, dynamic>> updatedRequests = [];

      for (var item in requestList) {
        if (item is Map<String, dynamic>) {
          updatedRequests.add(item);
        }
      }

      // Emit the updated state
      emit(NotificationsFetchDataState(friendRequests: updatedRequests));
    } catch (e) {
      // Handle any errors that occur
      throw Exception('Failed to decline friend request: $e');
    }
  }
}
