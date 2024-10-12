import 'package:app_developments/app/views/view_login/view_model/login_event.dart';
import 'package:app_developments/app/views/view_login/view_model/login_state.dart';
import 'package:app_developments/app/views/view_login/view_model/login_view_model.dart';
import 'package:app_developments/app/views/view_login/widgets/login_page_widget.dart';
import 'package:app_developments/app/views/view_login/widgets/login_reset_password_page_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          LoginViewModel()..add(LoginInitialEvent(context: context)),
      child: BlocBuilder<LoginViewModel, LoginState>(
        builder: (context, state) {
          return  SafeArea(
            child: Scaffold(
              // Add resizeToAvoidBottomInset to avoid overflow
              resizeToAvoidBottomInset: true,
              // Set the body of the Scaffold to display the login page widget
              body: bodyWidget(state, context),
            ),
          );
        },
      ),
    );
  }

  // Selectpage widget
  Widget bodyWidget(LoginState state, BuildContext context) {
    if (state.selectedPage == 1) {
      return const LoginPageWidget();
    } else if (state.selectedPage == 2) {
      return const LoginResetPasswordPageWidget();
    }
    return const LoginPageWidget();
  }
}
