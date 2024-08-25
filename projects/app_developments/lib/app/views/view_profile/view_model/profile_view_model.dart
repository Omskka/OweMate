// ignore_for_file: avoid_print, no_leading_underscores_for_local_identifiers, use_build_context_synchronously

import 'dart:async';
import 'dart:io';
import 'package:app_developments/app/l10n/app_localizations.dart';
import 'package:app_developments/core/auth/authentication_repository.dart';
import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:app_developments/core/widgets/custom_flutter_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app_developments/app/views/view_profile/view_model/profile_event.dart';
import 'package:app_developments/app/views/view_profile/view_model/profile_state.dart';
import 'package:app_developments/core/auth/fetch_user_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ProfileViewModel extends Bloc<ProfileEvent, ProfileState> {
  // Selected image
  File? selectedImage;
  final FetchUserData fetchUserDataService = FetchUserData();

  ProfileViewModel() : super(ProfileInitialState()) {
    on<ProfileInitialEvent>(_initial);
    on<ProfileFetchUserDataEvent>(_fetchUserData);
    on<ProfileChangeImageEvent>(_changeProfileImage);
    on<ProfileChangePasswordEvent>(_changePassword);
    on<ProfileSelectedPageEvent>(_selectPage);
  }

  // Add controllers
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController newConfirmPasswordController =
      TextEditingController();

  String firstName = '';
  String lastName = '';
  String email = '';
  String phoneNumber = '';
  String schoolName = '';
  String profileImageUrl = '';

  FutureOr<void> _initial(
      ProfileInitialEvent event, Emitter<ProfileState> emit) {}

  // Fetch user data
  FutureOr<void> _fetchUserData(
      ProfileFetchUserDataEvent event, Emitter<ProfileState> emit) async {
    try {
      // Fetch the current user ID
      String? userId = AuthenticationRepository().getCurrentUserId();
      final FirebaseFirestore _firestore = FirebaseFirestore.instance;
      final userDoc = await _firestore.collection('users').doc(userId).get();

      if (userDoc.exists) {
        final userData = await fetchUserDataService.fetchUserData();

        firstName = userData['firstName'] ?? '';
        lastName = userData['lastName'] ?? '';
        phoneNumber = userData['phoneNumber'] ?? '';
        schoolName = userData['schoolName'] ?? '';
        email = userData['email'] ?? '';
        profileImageUrl = userData['profileImageUrl'] ?? '';

        emit(ProfileLoadDataState(
          state: state,
          firstName: firstName,
          lastName: lastName,
          phoneNumber: phoneNumber,
          schoolName: schoolName,
          email: email,
          profileImageUrl: profileImageUrl,
        ));
      }
    } catch (e) {
      print('$e');
    }
  }

  // Change profile image
  FutureOr<void> _changeProfileImage(
      ProfileChangeImageEvent event, Emitter<ProfileState> emit) async {
    // Get current user id
    String? userid = AuthenticationRepository().getCurrentUserId();
    print("UserID: $userid");

    try {
      // Pick the image
      final returnedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (returnedImage != null) {
        selectedImage = File(returnedImage.path);
        emit(ProfileSelectImageState(
            selectedImage!)); // Emit the state with the selected image
      } else {
        return;
      }

      if (selectedImage != null) {
        // Upload the image to Firebase Storage
        final path = 'users/$userid/profile_image.jpg';
        final ref = FirebaseStorage.instance.ref().child(path);
        UploadTask uploadTask = ref.putFile(selectedImage!);

        // Wait for the upload to complete
        TaskSnapshot snapshot = await uploadTask;

        // Get the download URL of the uploaded image
        String downloadURL = await snapshot.ref.getDownloadURL();

        // Save the download URL to Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userid)
            .update({
          'profile_image_url': downloadURL,
        });

        // Emit a new state to signal that the image has been updated
        emit(ProfileLoadDataState(
          state: state,
          firstName: firstName,
          lastName: lastName,
          phoneNumber: phoneNumber,
          schoolName: schoolName,
          email: email,
          profileImageUrl: profileImageUrl,
        ));
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // Update password
  FutureOr<void> _changePassword(
      ProfileChangePasswordEvent event, Emitter<ProfileState> emit) async {
    final oldPassword = oldPasswordController.text.trim();
    final newPassword = newPasswordController.text.trim();

    try {
      // Loading circle
      showDialog(
        context: event.context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        },
      );

      // Get the current user
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        throw Exception();
      }

      // Re-authenticate the user
      final credential = EmailAuthProvider.credential(
        email: user.email ?? '',
        password: oldPassword,
      );

      await user.reauthenticateWithCredential(credential);

      // Update the password
      await user.updatePassword(newPassword);

      // Reset controllers (if necessary, handle this in the UI)
      oldPasswordController.clear();
      newPasswordController.clear();
      newConfirmPasswordController.clear();

      // Emit a success state
      emit(ProfileSelectedPageState(selectedPage: 1, state: state));

      // Dismiss the loading circle dialog
      Navigator.of(event.context).pop();

      CustomFlutterToast(
        context: event.context,
        backgroundColor: AppLightColorConstants.successColor,
        msg: 'Password changed Successfully',
      ).flutterToast();
    } catch (e) {
      // Dismiss the loading circle dialog
      Navigator.of(event.context).pop();
      CustomFlutterToast(
        backgroundColor: AppLightColorConstants.errorColor,
        context: event.context,
        msg: 'Error Updating Password',
      ).flutterToast();
    }
  }

  // Select page
  FutureOr<void> _selectPage(
      ProfileSelectedPageEvent event, Emitter<ProfileState> emit) {
    emit(ProfileSelectedPageState(
        selectedPage: event.selectedPage, state: state));
  }
}
