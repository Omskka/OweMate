import 'package:app_developments/app/l10n/app_localizations.dart';
import 'package:app_developments/app/routes/app_router.dart';
import 'package:app_developments/app/theme/dark_theme_data.dart';
import 'package:app_developments/app/theme/light_theme_data.dart';
import 'package:app_developments/app/views/view_settings/view_model/settings_state.dart';
import 'package:app_developments/app/views/view_settings/view_model/settings_view_model.dart';
import 'package:flavor/flavor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App extends StatefulWidget {
  const App({super.key});

  static void setTheme(BuildContext context, bool isDarkTheme) {
    final state = context.findAncestorStateOfType<_AppState>();
    state?.changeTheme(isDarkTheme);
  }

  static void setLocale(BuildContext context, Locale newLocale) {
    final stateLang = context.findAncestorStateOfType<_AppState>();
    stateLang?.changeLanguage(newLocale);
  }

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  Locale _locale = const Locale('tr', 'TR');
  bool _isDarkTheme = false; // Default to light theme

  changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
      debugPrint("Language changed to: ${locale.languageCode}");
    });
  }

  @override
  void initState() {
    super.initState();
    _loadThemePreference();
  }

  // Load the saved theme preference
  Future<void> _loadThemePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkTheme = prefs.getBool('isDarkTheme') ?? false; // Default to false
    });
  }

  // Function to change the theme
  Future<void> changeTheme(bool isDarkTheme) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkTheme', isDarkTheme);

    setState(() {
      _isDarkTheme = isDarkTheme;
      debugPrint("Theme changed to: ${_isDarkTheme ? 'Dark' : 'Light'}");
    });
  }

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return FlavorBanner(
      child: ScreenUtilInit(
        builder: (context, child) =>
            BlocBuilder<SettingsViewModel, SettingsState>(
          builder: (context, state) {
            return MaterialApp.router(
              supportedLocales: L10n.supportedLocales,
              localizationsDelegates: L10n.localizationsDelegates,
              debugShowCheckedModeBanner: false,
              theme: AppThemeLight.getTheme(),
              darkTheme: AppThemeDark.getTheme(),
              themeMode: _isDarkTheme ? ThemeMode.dark : ThemeMode.light,
              locale: _locale,
              routerConfig: _appRouter.config(),
            );
          },
        ),
      ),
    );
  }
}
