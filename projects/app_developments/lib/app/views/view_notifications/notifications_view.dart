import 'package:app_developments/app/views/view_notifications/view_model/notifications_event.dart';
import 'package:app_developments/app/views/view_notifications/view_model/notifications_state.dart';
import 'package:app_developments/app/views/view_notifications/view_model/notifications_view_model.dart';
import 'package:app_developments/app/views/view_notifications/widgets/notifications_page_widget.dart';
import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          NotificationsViewModel()..add(NotificationsInitialEvent()),
      child: BlocBuilder<NotificationsViewModel, NotificationsState>(
        builder: (context, state) {
          return const SafeArea(
            child: Scaffold(
              backgroundColor: AppLightColorConstants.bgLight,
              // Displaying bodyWidget
              body: NotificationsPageWidget(),
            ),
          );
        },
      ),
    );
  }
}
