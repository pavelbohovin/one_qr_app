// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class AppLocalizationsNl extends AppLocalizations {
  AppLocalizationsNl([String locale = 'nl']) : super(locale);

  @override
  String get noQrImageSelected => 'Geen QR-afbeelding geselecteerd.';

  @override
  String get uploadQrImage => 'QR-afbeelding uploaden';
}

/// The translations for Dutch Flemish, as used in Belgium (`nl_BE`).
class AppLocalizationsNlBe extends AppLocalizationsNl {
  AppLocalizationsNlBe(): super('nl_BE');

  @override
  String get noQrImageSelected => 'Geen QR-afbeelding geselecteerd.';

  @override
  String get uploadQrImage => 'QR-afbeelding uploaden';
}
