// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    LoginViewRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LoginView(),
      );
    },
    OnboardingViewRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const OnboardingView(),
      );
    },
    SignupViewRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SignupView(),
      );
    },
    SplashViewRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SplashView(),
      );
    },
  };
}

/// generated route for
/// [LoginView]
class LoginViewRoute extends PageRouteInfo<void> {
  const LoginViewRoute({List<PageRouteInfo>? children})
      : super(
          LoginViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginViewRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [OnboardingView]
class OnboardingViewRoute extends PageRouteInfo<void> {
  const OnboardingViewRoute({List<PageRouteInfo>? children})
      : super(
          OnboardingViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnboardingViewRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SignupView]
class SignupViewRoute extends PageRouteInfo<void> {
  const SignupViewRoute({List<PageRouteInfo>? children})
      : super(
          SignupViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignupViewRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SplashView]
class SplashViewRoute extends PageRouteInfo<void> {
  const SplashViewRoute({List<PageRouteInfo>? children})
      : super(
          SplashViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashViewRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
