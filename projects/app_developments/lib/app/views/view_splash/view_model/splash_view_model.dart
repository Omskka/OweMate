import 'dart:async';

import 'package:app_developments/app/views/view_splash/view_model/splash_event.dart';
import 'package:app_developments/app/views/view_splash/view_model/splash_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashViewModel extends Bloc<SplashEvent, SplashState> {
  SplashViewModel() : super(SplashInitialState()) {
    on<SplashInitialEvent>(_initial);
    on<SplashSelectedPageEvent>(_selectedPage);
  }

  FutureOr<void> _initial(SplashInitialEvent event, Emitter<SplashState> emit) {

  }

  FutureOr<void> _selectedPage(
      SplashSelectedPageEvent event, Emitter<SplashState> emit) {
    emit(SplashSelectedPageState(
      selectedPage: event.selectedPage,
      state: state,
    ));
  }
}
