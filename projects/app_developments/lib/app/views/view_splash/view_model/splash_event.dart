import 'package:flutter/material.dart';

abstract class SplashEvent {
  SplashEvent();
}

class SplashInitialEvent extends SplashEvent {
  SplashInitialEvent();
}

class SplashSelectedPageEvent extends SplashEvent {
  final int selectedPage;
  final BuildContext context;
  SplashSelectedPageEvent(this.selectedPage, this.context);
}
