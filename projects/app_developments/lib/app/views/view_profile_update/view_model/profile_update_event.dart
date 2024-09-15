import 'package:flutter/src/widgets/framework.dart';

// Abstract class defining the base for profile update events
abstract class ProfileUpdateEvent {
  ProfileUpdateEvent();
}

// Event for initializing the profile update process
class ProfileUpdateInitialEvent extends ProfileUpdateEvent {
  ProfileUpdateInitialEvent({required BuildContext context});
}

// Event for selecting an image during profile update
class ProfileUpdateSelectImageEvent extends ProfileUpdateEvent {
  ProfileUpdateSelectImageEvent({required BuildContext context});
}

// Event for adding user information during profile update
class ProfileUpdateAddUserEvent extends ProfileUpdateEvent {
  final BuildContext context;
  ProfileUpdateAddUserEvent({required this.context});
}

/// Event for selecting a page
class ProfileUpdateSelectedPageEvent extends ProfileUpdateEvent {
  final int selectedPage;
  final BuildContext context;

  // Constructor to initialize the context
  ProfileUpdateSelectedPageEvent({
    required this.context,
    required this.selectedPage,
  });
}

