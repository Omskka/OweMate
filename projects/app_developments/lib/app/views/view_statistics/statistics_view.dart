// ignore_for_file: use_key_in_widget_constructors
import 'package:app_developments/app/theme/color_theme_util.dart';
import 'package:app_developments/app/views/view_statistics/view_model/statistics_event.dart';
import 'package:app_developments/app/views/view_statistics/view_model/statistics_state.dart';
import 'package:app_developments/app/views/view_statistics/view_model/statistics_view_model.dart';
import 'package:app_developments/app/views/view_statistics/widgets/statistics_page_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class StatisticsView extends StatelessWidget {
  const StatisticsView({Key? key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StatisticsViewModel()..add(StatisticsInitialEvent()),
      child: BlocBuilder<StatisticsViewModel, StatisticsState>(
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: ColorThemeUtil.getBgLightColor(context),
              // Set the body of the Scaffold to display the page widget
              body: const StatisticsPageWidget(),
            ),
          );
        },
      ),
    );
  }
}
