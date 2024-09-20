import 'package:app_developments/app/theme/color_theme_util.dart';
import 'package:app_developments/app/views/view_messages/view_model/messages_event.dart';
import 'package:app_developments/app/views/view_messages/view_model/messages_state.dart';
import 'package:app_developments/app/views/view_messages/view_model/messages_view_model.dart';
import 'package:app_developments/app/views/view_messages/widgets/messages_page_widget.dart';
import 'package:app_developments/app/views/view_messages/widgets/messages_view_page_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class MessagesView extends StatelessWidget {
  const MessagesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MessagesViewModel()..add(MessagesInitialEvent()),
      child: BlocBuilder<MessagesViewModel, MessagesState>(
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: ColorThemeUtil.getBgLightColor(context),
              // Displaying bodyWidget
              body: bodyWidget(state, context),
            ),
          );
        },
      ),
    );
  }

  // Selectpage widget
  Widget bodyWidget(MessagesState state, BuildContext context) {
    if (state.selectedPage == 1) {
      return const MessagesPageWidget();
    } else if (state.selectedPage == 2) {
      return const MessagesViewPageWidget();
    }
    return const MessagesPageWidget();
  }
}
