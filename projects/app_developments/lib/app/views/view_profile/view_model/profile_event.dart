import 'package:flutter/material.dart';

// Abstract class representing a general profile event
abstract class ProfileEvent {
  ProfileEvent();
}

// Event to initialize profile data or view
class ProfileInitialEvent extends ProfileEvent {
  ProfileInitialEvent();
}

// Event to fetch user data from the server or database
class ProfileFetchUserDataEvent extends ProfileEvent {
  ProfileFetchUserDataEvent();
}

// Event to handle profile image change
class ProfileChangeImageEvent extends ProfileEvent {
  ProfileChangeImageEvent();
}

// Event to change the user's password
class ProfileChangePasswordEvent extends ProfileEvent {
  final BuildContext context;
  ProfileChangePasswordEvent({
    required this.context,
  });
}

// Event to select a specific page in the profile
class ProfileSelectedPageEvent extends ProfileEvent {
  final int selectedPage; // Page number to be selected
  ProfileSelectedPageEvent({
    required this.selectedPage,
  });
}
