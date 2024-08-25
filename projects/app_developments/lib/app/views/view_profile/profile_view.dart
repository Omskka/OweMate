import 'package:app_developments/app/views/view_profile/view_model/profile_state.dart';
import 'package:app_developments/app/views/view_profile/view_model/profile_view_model.dart';
import 'package:app_developments/app/views/view_profile/widgets/profile_page_widget.dart';
import 'package:app_developments/app/views/view_profile/widgets/profile_password_page_widget.dart';
import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileViewModel(),
      child: BlocBuilder<ProfileViewModel, ProfileState>(
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: AppLightColorConstants.bgLight,
              // Displaying bodyWidget
              body: bodyWidget(state, context),
            ),
          );
        },
      ),
    );
  }

  // Selectpage widget
  Widget bodyWidget(ProfileState state, BuildContext context) {
    if (state.selectedPage == 1) {
      return const ProfilePageWidget();
    } else if (state.selectedPage == 2) {
      return ProfilePasswordPageWidget(
        state: state,
      );
    }
    return const ProfilePageWidget();
  }
}
