// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get noQrImageSelected => 'Aucune image QR sélectionnée.';

  @override
  String get uploadQrImage => 'Télécharger l\'image QR';
}

/// The translations for French, as used in Canada (`fr_CA`).
class AppLocalizationsFrCa extends AppLocalizationsFr {
  AppLocalizationsFrCa(): super('fr_CA');

  @override
  String get noQrImageSelected => 'Aucune image QR sélectionnée.';

  @override
  String get uploadQrImage => 'Télécharger l\'image QR';
}
