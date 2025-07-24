// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swedish (`sv`).
class AppLocalizationsSv extends AppLocalizations {
  AppLocalizationsSv([String locale = 'sv']) : super(locale);

  @override
  String get noQrImageSelected => 'Ingen QR-bild vald.';

  @override
  String get uploadQrImage => 'Ladda upp QR-bild';
}

/// The translations for Swedish, as used in Finland (`sv_FI`).
class AppLocalizationsSvFi extends AppLocalizationsSv {
  AppLocalizationsSvFi(): super('sv_FI');

  @override
  String get noQrImageSelected => 'Ingen QR-bild vald.';

  @override
  String get uploadQrImage => 'Ladda upp QR-bild';
}
