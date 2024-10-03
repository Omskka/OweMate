import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class L10nTr extends L10n {
  L10nTr([String locale = 'tr']) : super(locale);

  @override
  String get done => 'Tamam';

  @override
  String get transferMoney => 'Para Transferi';

  @override
  String get bestMoneyTransfer => 'En İyi Para Transferi Ortağınız.';
}
