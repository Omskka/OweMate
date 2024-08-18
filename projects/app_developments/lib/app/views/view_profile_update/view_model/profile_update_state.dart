import 'dart:io';

// Abstract class defining the base for profile update states
abstract class ProfileUpdateState {
  final int? selectedPage;
  ProfileUpdateState({
    this.selectedPage,
  });
}

// State indicating the initial state of profile update
class ProfileUpdateInitialState extends ProfileUpdateState {
  ProfileUpdateInitialState();
}

// State indicating an image has been selected for profile update
class ProfileUpdateImageSelectedState extends ProfileUpdateState {
  final File? selectedImage;

  ProfileUpdateImageSelectedState(this.selectedImage);
}

// State indicating the profile update was successful
class ProfileUpdateSuccessState extends ProfileUpdateState {
  ProfileUpdateSuccessState();
}

/// State representing the selected page in the money transfer process
class ProfileUpdateSelectedPageState extends ProfileUpdateState {
  final int selectedPage;
  final ProfileUpdateState state;

  ProfileUpdateSelectedPageState({
    required this.selectedPage,
    required this.state,
  }) : super(
          selectedPage: state.selectedPage
        );
}