import 'package:app_developments/app/theme/color_theme_util.dart';
import 'package:app_developments/app/views/view_pending/view_model/pending_event.dart';
import 'package:app_developments/app/views/view_pending/view_model/pending_state.dart';
import 'package:app_developments/app/views/view_pending/view_model/pending_view_model.dart';
import 'package:app_developments/app/views/view_pending/widgets/pending_debts_page_widget.dart';
import 'package:app_developments/app/views/view_pending/widgets/pending_requests_page_widget.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class PendingView extends StatelessWidget {
  final int? selectedPage;

  const PendingView({
    super.key,
    this.selectedPage,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PendingViewModel()
        ..add(PendingInitialEvent(
            context: context,
            selectedPage:
                selectedPage ?? 1)), // Use selectedPage or default to 1
      child: BlocBuilder<PendingViewModel, PendingState>(
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: ColorThemeUtil.getBgDarkColor(context),
              // Displaying bodyWidget
              body: bodyWidget(state, context),
            ),
          );
        },
      ),
    );
  }

  // Select page widget
  Widget bodyWidget(PendingState state, BuildContext context) {
    if (selectedPage == 1) {
      return const PendingDebtsPageWidget();
    } else if (selectedPage == 2) {
      return const PendingRequestsPageWidget();
    }
    return const PendingDebtsPageWidget();
  }
}
