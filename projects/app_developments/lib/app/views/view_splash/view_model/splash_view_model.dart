import 'dart:async';
import 'package:app_developments/app/routes/app_router.dart';
import 'package:app_developments/app/views/view_splash/view_model/splash_event.dart';
import 'package:app_developments/app/views/view_splash/view_model/splash_state.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashViewModel extends Bloc<SplashEvent, SplashState> {
  SplashViewModel() : super(SplashInitialState()) {
    on<SplashInitialEvent>(_initial);
    on<SplashSelectedPageEvent>(_selectedPage);
  }

  FutureOr<void> _initial(
      SplashInitialEvent event, Emitter<SplashState> emit) async {
    final User? currentUser = FirebaseAuth.instance.currentUser;

    // Simulate a loading delay
    await Future.delayed(const Duration(seconds: 3));

    if (currentUser != null) {
      // User is logged in, navigate to HomePage
      event.context.router.push(const HomeViewRoute());
    } else {
      // User is not logged in, navigate to Onboarding/Login
      event.context.router.push(const OnboardingViewRoute());
    }
  }

  FutureOr<void> _selectedPage(
      SplashSelectedPageEvent event, Emitter<SplashState> emit) {
    emit(SplashSelectedPageState(
      selectedPage: event.selectedPage,
      state: state,
    ));
  }
}
