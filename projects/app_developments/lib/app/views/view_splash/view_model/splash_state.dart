// ignore_for_file: overridden_fields, annotate_overrides

abstract class SplashState {
    final int? selectedPage;

  SplashState({this.selectedPage});
}

class SplashInitialState extends SplashState {
  SplashInitialState();
}

class SplashSelectedPageState extends SplashState {
  final int selectedPage;
  SplashState state;
  SplashSelectedPageState({required this.selectedPage, required this.state});
}
