import 'package:app_developments/app/views/view_profile_update/view_model/profile_update_state.dart';
import 'package:app_developments/app/views/view_profile_update/widgets/profile_update_page_widget.dart';
import 'package:app_developments/app/views/view_profile_update/widgets/profile_update_success_page_widget.dart';
import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:app_developments/app/views/view_profile_update/view_model/profile_update_view_model.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Creates the application's splash screen.
@RoutePage()
class ProfileUpdateView extends StatelessWidget {
  const ProfileUpdateView({Key? key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileUpdateViewModel(),
      child: BlocBuilder<ProfileUpdateViewModel, ProfileUpdateState>(
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: AppLightColorConstants.bgLight,
              // Set the body of the Scaffold to display the profile update widget
              body: bodyWidget(state, context),
            ),
          );
        },
      ),
    );
  }

  // Selectpage widget
  Widget bodyWidget(ProfileUpdateState state, BuildContext context) {
    if (state.selectedPage == 1) {
      return const ProfileUpdatePageWidget();
    }  else if (state.selectedPage == 2) {
      return const ProfileUpdateSuccessPageWidget();
    }
    return const ProfileUpdatePageWidget();
  }
}
