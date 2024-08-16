import 'package:app_developments/app/views/view_signup/view_model/signup_state.dart';
import 'package:app_developments/app/views/view_signup/view_model/signup_view_model.dart';
import 'package:app_developments/app/views/view_signup/widgets/signup_page_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class SignupView extends StatelessWidget {
  const SignupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupViewModel(),
      child: BlocBuilder<SignupViewModel, SignupState>(
        builder: (context, state) {
          // Access the ViewModel
          return const SafeArea(
            child: Scaffold(
              // Add resizeToAvoidBottomInset to avoid overflow
              resizeToAvoidBottomInset: false,
              // Set the body of the Scaffold to display the signup page widget
              body: SignupPageWidget(),
            ),
          );
        },
      ),
    );
  }
}
