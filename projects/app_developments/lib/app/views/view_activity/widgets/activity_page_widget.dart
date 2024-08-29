import 'package:app_developments/app/views/view_activity/view_model/activity_state.dart';
import 'package:app_developments/app/views/view_activity/view_model/activity_view_model.dart';
import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:app_developments/core/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActivityPageWidget extends StatelessWidget {
  const ActivityPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActivityViewModel, ActivityState>(
      builder: (context, state) {
        final screenHeight = MediaQuery.of(context).size.height;
        final screenWidth = MediaQuery.of(context).size.width;

        // Determine height and width based on screen width

        // Height
        if (screenHeight <= 600) {
        } else if (screenHeight <= 800) {
        } else if (screenHeight <= 900) {
        } else if (screenHeight <= 1080) {
        } else {}

        // Width
        if (screenWidth <= 600) {
        } else if (screenWidth <= 800) {
        } else if (screenWidth <= 900) {
        } else if (screenWidth <= 1080) {
        } else {}
        return SingleChildScrollView(
          child: Column(
            children: [
              context.sizedHeightBoxLow,
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(
                        left: context.dynamicWidth(0.2),
                        right: context.dynamicWidth(0.06),
                      ),
                      child: const Divider(
                        color: AppLightColorConstants.contentDisabled,
                        height: 36,
                        thickness: 1.5,
                      ),
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'Activity',
                      style: context.textStyleGrey(context).copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: AppLightColorConstants.bgInverse,
                          ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(
                        left: context.dynamicWidth(0.06),
                        right: context.dynamicWidth(0.2),
                      ),
                      child: const Divider(
                        color: AppLightColorConstants.contentDisabled,
                        height: 36,
                        thickness: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
              Placeholder(),
            ],
          ),
        );
      },
    );
  }
}
