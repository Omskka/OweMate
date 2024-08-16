import 'package:app_developments/app/views/view_login/view_model/login_state.dart';
import 'package:app_developments/app/views/view_login/view_model/login_view_model.dart';
import 'package:app_developments/app/views/view_login/widgets/login_page_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginViewModel(),
      child: BlocBuilder<LoginViewModel, LoginState>(
        builder: (context, state) {
          return const SafeArea(
            child: Scaffold(
              // Add resizeToAvoidBottomInset to avoid overflow
              resizeToAvoidBottomInset: true,
              // Set the body of the Scaffold to display the login page widget
              body: LoginPageWidget(),
            ),
          );
        },
      ),
    );
  }
}
