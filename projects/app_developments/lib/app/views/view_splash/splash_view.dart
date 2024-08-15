import 'package:app_developments/app/l10n/app_localizations.dart';
import 'package:app_developments/app/views/view_splash/view_model/splash_event.dart';
import 'package:app_developments/app/views/view_splash/view_model/splash_state.dart';
import 'package:app_developments/app/views/view_splash/view_model/splash_view_model.dart';
import 'package:app_developments/core/constants/ligth_theme_color_constants.dart';
import 'package:app_developments/core/extension/context_extension.dart';
import 'package:app_developments/gen/assets.gen.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

@RoutePage()
class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashViewModel()..add(SplashInitialEvent()),
      child: BlocBuilder<SplashViewModel, SplashState>(
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              body: SizedBox(),
            ),
          );
        },
      ),
    );
  }
}
