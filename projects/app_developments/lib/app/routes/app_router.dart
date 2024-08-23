import 'package:app_developments/app/views/view_debts/debts_view.dart';
import 'package:app_developments/app/views/view_friends/friends_view.dart';
import 'package:app_developments/app/views/view_home/home_view.dart';
import 'package:app_developments/app/views/view_login/login_view.dart';
import 'package:app_developments/app/views/view_onboarding/onboarding_view.dart';
import 'package:app_developments/app/views/view_profile_update/profile_update_view.dart';
import 'package:app_developments/app/views/view_signup/signup_view.dart';
import 'package:app_developments/app/views/view_splash/splash_view.dart';
import 'package:app_developments/core/widgets/custom_navbar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(
  replaceInRouteName: 'View',
)
class AppRouter extends _$AppRouter {
  final routerObserver = AutoRouterObserver();

  @override
  RouteType get defaultRouteType => RouteType.custom(
        barrierColor: Colors.transparent,
        durationInMilliseconds: 180,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: SafeArea(
              top: false,
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                extendBody: true,
                extendBodyBehindAppBar: true,
                // bottomNavigationBar: getNavBar(
                //   context,
                // ),
                body: child,
              ),
            ),
          );
        },
      );
  @override
  final List<AutoRoute> routes = [
    AutoRoute(page: SplashViewRoute.page, initial: true),
    AutoRoute(page: OnboardingViewRoute.page),
    AutoRoute(page: SignupViewRoute.page),
    AutoRoute(page: LoginViewRoute.page),
    AutoRoute(page: ProfileUpdateViewRoute.page),
    AutoRoute(page: CustomNavbarRoute.page, children: [
      AutoRoute(page: HomeViewRoute.page),
      AutoRoute(page: DebtsViewRoute.page),
      AutoRoute(page: FriendsViewRoute.page),
    ]),
  ];
}
