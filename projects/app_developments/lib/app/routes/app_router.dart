import 'package:app_developments/app/views/view_activity/activity_view.dart';
import 'package:app_developments/app/views/view_add_friends/add_friends_view.dart';
import 'package:app_developments/app/views/view_debts/debts_view.dart';
import 'package:app_developments/app/views/view_friends/friends_view.dart';
import 'package:app_developments/app/views/view_home/home_view.dart';
import 'package:app_developments/app/views/view_login/login_view.dart';
import 'package:app_developments/app/views/view_messages/messages_view.dart';
import 'package:app_developments/app/views/view_notifications/notifications_view.dart';
import 'package:app_developments/app/views/view_onboarding/onboarding_view.dart';
import 'package:app_developments/app/views/view_pending/pending_view.dart';
import 'package:app_developments/app/views/view_profile/profile_view.dart';
import 'package:app_developments/app/views/view_profile_update/profile_update_view.dart';
import 'package:app_developments/app/views/view_request/request_view.dart';
import 'package:app_developments/app/views/view_settings/settings_view.dart';
import 'package:app_developments/app/views/view_settle/settle_view.dart';
import 'package:app_developments/app/views/view_signup/signup_view.dart';
import 'package:app_developments/app/views/view_splash/splash_view.dart';
import 'package:app_developments/app/views/view_statistics/statistics_view.dart';
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
      AutoRoute(page: ActivityViewRoute.page),
    ]),
    AutoRoute(page: AddFriendsViewRoute.page),
    AutoRoute(page: ProfileViewRoute.page),
    AutoRoute(page: NotificationsViewRoute.page),
    AutoRoute(page: RequestViewRoute.page),
    AutoRoute(page: SettleViewRoute.page),
    AutoRoute(page: MessagesViewRoute.page),
    AutoRoute(page: StatisticsViewRoute.page),
    AutoRoute(page: SettingsViewRoute.page),
    AutoRoute(page: PendingViewRoute.page),
  ];
}
