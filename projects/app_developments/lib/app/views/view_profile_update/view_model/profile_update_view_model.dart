// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:io';
import 'package:app_developments/app/theme/color_theme_util.dart';
import 'package:app_developments/app/views/view_profile_update/view_model/profile_update_event.dart';
import 'package:app_developments/app/views/view_profile_update/view_model/profile_update_state.dart';
import 'package:app_developments/core/auth/authentication_repository.dart';
import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:app_developments/core/widgets/custom_flutter_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

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
  bool gotPermissions = false;

  ProfileUpdateViewModel() : super(ProfileUpdateInitialState()) {
    on<ProfileUpdateInitialEvent>(_initial);
    on<ProfileUpdateSelectImageEvent>(_selectImage);
    on<ProfileUpdateAddUserEvent>(_addUserDetails);
    on<ProfileUpdateSelectedPageEvent>(_selectPage);
  }

  // ProfileUpdateInitialEvent handler method.
  FutureOr<void> _initial(
      ProfileUpdateInitialEvent event, Emitter<ProfileUpdateState> emit) {}

  // Select image from gallery
  FutureOr<void> _selectImage(ProfileUpdateSelectImageEvent event,
      Emitter<ProfileUpdateState> emit) async {
    // Initialize DeviceInfoPlugin and get Android device info
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

    var sdkInt = androidInfo.version.sdkInt; // SDK, example: 31

    if (Platform.isAndroid) {
      var storage = await Permission.storage.status;

      if (storage != PermissionStatus.granted) {
        await Permission.storage.request();
      }

      if (sdkInt >= 30) {
        var storage_external = await Permission.manageExternalStorage.status;

        if (storage_external != PermissionStatus.granted) {
          await Permission.photos.request();
        }

        storage_external = await Permission.photos.status;

        if (storage_external == PermissionStatus.granted) {
          gotPermissions = true;
        }
      } else {
        // (SDK < 30)
        storage = await Permission.storage.status;

        if (storage == PermissionStatus.granted) {
          gotPermissions = true;
        }
      }
    }
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
      // If permission is denied, show a toast and return
      if (!gotPermissions) {
        Navigator.of(event.context).pop(); // Close loading circle
        CustomFlutterToast(
                backgroundColor: AppLightColorConstants.errorColor,
                context: event.context,
                msg: 'Permission denied to access images')
            .flutterToast();
        return;
      }

      // Get current user ID
      String? userid = AuthenticationRepository().getCurrentUserId();

      // Upload user data to Firestore
      await FirebaseFirestore.instance.collection('users').doc(userid).set(
        {
          'name': firstnameController.text.trim(),
          'gender': genderController.text.trim(),
          'profile_image_url':
              '', // Default empty URL, will be updated if an image is selected
          'friendsList': [], // Initialize with an empty list
          'requestList': [], // Initialize with an empty list
          'owedMoney': [], // Initialize with an empty list
          'requestedMoney': [], // Initialize with an empty list
        },
      );

      // Upload the image to Firebase Storage if selected
      if (selectedImage != null) {
        final path = 'users/$userid/profile_image.jpg';
        final ref = FirebaseStorage.instance.ref().child(path);
        UploadTask uploadTask = ref.putFile(selectedImage!);

        // Wait for the upload to complete
        TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);

        // Get the download URL of the uploaded image
        String downloadURL = await snapshot.ref.getDownloadURL();

        // Update Firestore with the image URL
        await FirebaseFirestore.instance.collection('users').doc(userid).update(
          {
            'profile_image_url': downloadURL,
          },
        );
      } else {
        // Give user a default profile image if no image was selected
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userid)
            .update({
          'profile_image_url':
              'https://firebasestorage.googleapis.com/v0/b/fintechapp-c4276.appspot.com/o/users%2Fblank_profile.jpg?alt=media&token=cb0df389-81c6-4f7c-9d5b-1c1b37cd5b65',
        });
      }

      // Emit a success state and display a success message
      emit(ProfileUpdateSuccessState());
      CustomFlutterToast(
              backgroundColor: AppLightColorConstants.successColor,
              context: event.context,
              msg: 'Profile Updated Successfully')
          .flutterToast();

      // Navigate to the next page
      emit(ProfileUpdateSelectedPageState(selectedPage: 2, state: state));
      Navigator.of(event.context).pop();
    } catch (e) {
      throw Exception(e);
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
}
