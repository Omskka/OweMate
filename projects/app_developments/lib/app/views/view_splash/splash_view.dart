import 'package:app_developments/app/views/view_splash/view_model/splash_event.dart';
import 'package:app_developments/app/views/view_splash/view_model/splash_state.dart';
import 'package:app_developments/app/views/view_splash/view_model/splash_view_model.dart';
import 'package:app_developments/app/views/view_splash/widgets/splash_page_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashViewModel()..add(SplashInitialEvent(context: context)),
      child: BlocBuilder<SplashViewModel, SplashState>(
        builder: (context, state) {
          return  const SafeArea(
            child: Scaffold(
              body: SplashPageWidget(),
            ),
          );
        },
      ),
    );
  }
}
