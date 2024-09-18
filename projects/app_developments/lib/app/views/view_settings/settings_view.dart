import 'package:app_developments/app/views/view_settings/view_model/settings_state.dart';
import 'package:app_developments/app/views/view_settings/view_model/settings_view_model.dart';
import 'package:app_developments/app/views/view_settings/widgets/settings_page_widget.dart';
import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsViewModel(),
      child: BlocBuilder<SettingsViewModel, SettingsState>(
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: AppLightColorConstants.bgLight,
              // Displaying bodyWidget
              body: SettingsPageWidget(),
            ),
          );
        },
      ),
    );
  }

}
