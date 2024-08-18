// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:io';
import 'package:app_developments/app/l10n/app_localizations.dart';
import 'package:app_developments/app/routes/app_router.dart';
import 'package:app_developments/app/views/view_profile_update/view_model/profile_update_event.dart';
import 'package:app_developments/app/views/view_profile_update/view_model/profile_update_state.dart';
import 'package:app_developments/core/auth/authentication_repository.dart';
import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:app_developments/core/widgets/custom_flutter_toast.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ProfileUpdateViewModel
    extends Bloc<ProfileUpdateEvent, ProfileUpdateState> {
  // Define TextEditingController
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  // Define global key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  // Selected image
  File? selectedImage;

  ProfileUpdateViewModel() : super(ProfileUpdateInitialState()) {
    on<ProfileUpdateInitialEvent>(_initial);
    on<ProfileUpdateSelectImageEvent>(_selectImage);
    on<ProfileUpdateAddUserEvent>(_addUserDetails);
    on<ProfileUpdateSelectedPageEvent>(_selectPage);
    on<ProfileUpdateAddPhoneNumberEvent>(_addPhoneNumber);
  }

  // ProfileUpdateInitialEvent handler method.
  FutureOr<void> _initial(
      ProfileUpdateInitialEvent event, Emitter<ProfileUpdateState> emit) {}

  // Select image from gallery
  FutureOr<void> _selectImage(ProfileUpdateSelectImageEvent event,
      Emitter<ProfileUpdateState> emit) async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage != null) {
      selectedImage = File(returnedImage.path);
      emit(ProfileUpdateImageSelectedState(
          selectedImage!)); // Emit state if needed
    }
  }

  // Add user detail to firebase
  FutureOr<void> _addUserDetails(
      ProfileUpdateAddUserEvent event, Emitter<ProfileUpdateState> emit) async {
    // Loading circle
    try {
      showDialog(
        context: event.context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        },
      );
      // upload the inputs to firebase
      String? userid = AuthenticationRepository().getCurrentUserId();
      await FirebaseFirestore.instance.collection('users').doc(userid).set({
        'Name': firstnameController.text.trim(),
        'Gender': genderController.text.trim(),
      });

      // Upload the image to Firebase Storage
      if (selectedImage != null) {
        final path = 'users/$userid/profile_image.jpg';
        final ref = FirebaseStorage.instance.ref().child(path);
        UploadTask uploadTask = ref.putFile(selectedImage!);

        // Wait for the upload to complete
        TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);

        // Get the download URL of the uploaded image
        String downloadURL = await snapshot.ref.getDownloadURL();

        // Save the download URL to Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userid)
            .update({
          'profile_image_url': downloadURL,
        });
      } else {
        // Give user default profile image
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userid)
            .update({
          'profile_image_url':
              'https://firebasestorage.googleapis.com/v0/b/fintechapp-c4276.appspot.com/o/users%2Fblank_profile.jpg?alt=media&token=cb0df389-81c6-4f7c-9d5b-1c1b37cd5b65',
        });
      }
      // If addUserDetails method completes without throwing an exception,
      // it indicates a successful process.

      // Emit a success state and display FlutterToast
      emit(ProfileUpdateSuccessState());
      CustomFlutterToast(
              backgroundColor: AppLightColorConstants.successColor,
              context: event.context,
              msg: 'Profile Updated Successfully')
          .flutterToast();
      // Navigate to next page
      emit(ProfileUpdateSelectedPageState(selectedPage: 2, state: state));
      // Dismiss the loading circle dialog
      Navigator.of(event.context).pop();
      // Handle error if proccess failed
    } catch (e) {
      // Dismiss the loading circle dialog
      Navigator.of(event.context).pop();
      CustomFlutterToast(
        context: event.context,
        msg: e.toString(),
      ).flutterToast();
    }
  }

  FutureOr<void> _selectPage(
      ProfileUpdateSelectedPageEvent event, Emitter<ProfileUpdateState> emit) {
    emit(
      ProfileUpdateSelectedPageState(
        selectedPage: event.selectedPage,
        state: state,
      ),
    );
  }

  FutureOr<void> _addPhoneNumber(ProfileUpdateAddPhoneNumberEvent event,
      Emitter<ProfileUpdateState> emit) async {
    try {
      // Loading circle
      showDialog(
        context: event.context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        },
      );
      String? userid = AuthenticationRepository().getCurrentUserId();
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userid)
          .update({'phoneNumber': phoneNumberController.text.trim()});

      // If addPhoneNumber method completes without throwing an exception,
      // it indicates a successful process.

      // Emit a success state and display FlutterToast
      emit(ProfileUpdateSuccessState());
      CustomFlutterToast(
              backgroundColor: AppLightColorConstants.successColor,
              context: event.context,
              msg: 'Phone Number Successfully Added')
          .flutterToast();
      // Navigate to next page
      emit(ProfileUpdateSelectedPageState(selectedPage: 4, state: state));
      // Dismiss the loading circle dialog
      Navigator.of(event.context).pop();
      // Handle error if proccess failed
    } catch (e) {
      // Dismiss the loading circle dialog
      Navigator.of(event.context).pop();
      CustomFlutterToast(
        context: event.context,
        msg: e.toString(),
      ).flutterToast();
    }
  }
}
