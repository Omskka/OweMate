// Creates the application's splash screen.
import 'package:app_developments/app/views/view_request/view_model/request_event.dart';
import 'package:app_developments/app/views/view_request/view_model/request_state.dart';
import 'package:app_developments/app/views/view_request/view_model/request_view_model.dart';
import 'package:app_developments/app/views/view_request/widgets/request_page_amount_page_widget.dart';
import 'package:app_developments/app/views/view_request/widgets/request_page_widget.dart';
import 'package:app_developments/app/views/view_request/widgets/request_success_page_widget.dart';
import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class RequestView extends StatelessWidget {
  const RequestView({Key? key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RequestViewModel()..add(RequestInitialEvent()),
      child: BlocBuilder<RequestViewModel, RequestState>(
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
  Widget bodyWidget(RequestState state, BuildContext context) {
    if (state.selectedPage == 1) {
      return const RequestPageWidget();
    } else if (state.selectedPage == 2) {
      return const RequestPageAmountPageWidget();
    } else if (state.selectedPage == 3) {
      return const RequestSuccessPageWidget();
    }
    return const RequestPageWidget();
  }
}
