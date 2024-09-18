import 'package:app_developments/app/views/view_settings/view_model/settings_event.dart';
import 'package:app_developments/app/views/view_settings/view_model/settings_state.dart';
import 'package:app_developments/app/views/view_settings/view_model/settings_view_model.dart';
import 'package:app_developments/core/widgets/back_button_with_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsTutorialPageWidget extends StatelessWidget {
  const SettingsTutorialPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsViewModel, SettingsState>(
      builder: (context, state) {
        final viewModel = BlocProvider.of<SettingsViewModel>(context);
        return SingleChildScrollView(
          child: Column(
            children: [
              BackButtonWithTitle(
                title: 'User Tutorial',
                ontap: () {
                  viewModel.add(
                    SettingsNavigateToNextPageEvent(
                      context: context,
                      selectedPage: 1,
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
