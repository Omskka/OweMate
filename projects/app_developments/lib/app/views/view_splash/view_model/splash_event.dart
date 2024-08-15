import 'package:flutter/material.dart';

abstract class SplashEvent {
  SplashEvent();
}

class SplashInitialEvent extends SplashEvent {
  final BuildContext context;
  SplashInitialEvent({
    required this.context,
  });
}

class SplashSelectedPageEvent extends SplashEvent {
  final int selectedPage;
  final BuildContext context;
  SplashSelectedPageEvent(this.selectedPage, this.context);
}
