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
              body: SizedBox(
                width: context.width,
                height: context.height,
                child: Column(
                  children: [
                    SizedBox(
                      width: context.width,
                      height: context.height * 0.45,
                      child: Stack(
                        children: [
                          Positioned(
                              top: 255,
                              left: 120,
                              child: SvgPicture.asset(
                                  Assets.images.svg.ellipse127)),
                          Positioned(
                              top: 255,
                              left: 172,
                              child: SvgPicture.asset(
                                  Assets.images.svg.ellipse128)),
                        ],
                      ),
                    ),
                    Text(
                      "TransferMe",
                      style: context.textStyleH1(context),
                    ),
                    Text(L10n.of(context)?.bestMoneyTransfer ?? "",
                        style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: AppLightColorConstants.primaryColor)),
                    const Spacer(),
                    Padding(
                      padding: context.onlyBottomPaddingMedium,
                      child: const Text(
                        "Secured by TransferMe.",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: AppLightColorConstants.primaryColor),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
