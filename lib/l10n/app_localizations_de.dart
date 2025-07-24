// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get noQrImageSelected => 'Kein QR-Bild ausgewählt.';

  @override
  String get uploadQrImage => 'QR-Bild hochladen';
}

/// The translations for German, as used in Austria (`de_AT`).
class AppLocalizationsDeAt extends AppLocalizationsDe {
  AppLocalizationsDeAt(): super('de_AT');

  @override
  String get noQrImageSelected => 'Kein QR-Bild ausgewählt.';

  @override
  String get uploadQrImage => 'QR-Bild hochladen';
}

/// The translations for German, as used in Switzerland (`de_CH`).
class AppLocalizationsDeCh extends AppLocalizationsDe {
  AppLocalizationsDeCh(): super('de_CH');

  @override
  String get noQrImageSelected => 'Kein QR-Bild ausgewählt.';

  @override
  String get uploadQrImage => 'QR-Bild hochladen';
}
