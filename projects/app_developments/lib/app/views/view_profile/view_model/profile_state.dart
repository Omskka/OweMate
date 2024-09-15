import 'dart:io';

// Base state for profile management with optional page tracking
abstract class ProfileState {
  final int? selectedPage;
  ProfileState({this.selectedPage});
}

// Initial state when the profile is first loaded
class ProfileInitialState extends ProfileState {}

// State when user data is loaded
class ProfileLoadDataState extends ProfileState {
  final String firstName, schoolName, email, profileImageUrl, gender;

  ProfileLoadDataState({
    required this.firstName,
    required this.schoolName,
    required this.email,
    required this.gender,
    required this.profileImageUrl,
    required ProfileState state,
  }) : super(selectedPage: state.selectedPage);
}

// State when an image is selected for the profile
class ProfileSelectImageState extends ProfileState {
  final File? selectedImage;
  ProfileSelectImageState(this.selectedImage);
}

// State when the profile image is successfully updated
class ProfileImageUpdatedState extends ProfileState {
  final String downloadURL;
  ProfileImageUpdatedState(this.downloadURL);
}

// State for page selection in the profile
class ProfileSelectedPageState extends ProfileState {
  final int selectedPage;
  final ProfileState state;

  ProfileSelectedPageState({
    required this.selectedPage,
    required this.state,
  }) : super(selectedPage: state.selectedPage);
}
