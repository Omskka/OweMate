// ignore_for_file: use_key_in_widget_constructors
import 'package:app_developments/app/views/view_settle/view_model/settle_event.dart';
import 'package:app_developments/app/views/view_settle/view_model/settle_state.dart';
import 'package:app_developments/app/views/view_settle/view_model/settle_view_model.dart';
import 'package:app_developments/app/views/view_settle/widgets/settle_page_widget.dart';
import 'package:app_developments/app/views/view_settle/widgets/settle_paid_page_widget.dart';
import 'package:app_developments/app/views/view_settle/widgets/setttle_decline_page_widget.dart';
import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class SettleView extends StatelessWidget {
  const SettleView({Key? key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettleViewModel()..add(SettleInitialEvent()),
      child: BlocBuilder<SettleViewModel, SettleState>(
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: AppLightColorConstants.bgLight,
              // Set the body of the Scaffold to display the page widget
              body: bodyWidget(state, context),
            ),
          );
        },
      ),
    );
  }

  // Selectpage widget
  Widget bodyWidget(SettleState state, BuildContext context) {
    if (state.selectedPage == 1) {
      return const SettlePageWidget();
    } else if (state.selectedPage == 2) {
      return const SetttleDeclinePageWidget();
    } else if (state.selectedPage == 3) {
      return const SettlePaidPageWidget();
    }
    return const SettlePageWidget();
  }
}
