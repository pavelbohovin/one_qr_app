// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Romanian Moldavian Moldovan (`ro`).
class AppLocalizationsRo extends AppLocalizations {
  AppLocalizationsRo([String locale = 'ro']) : super(locale);

  @override
  String get noQrImageSelected => 'Nu a fost selectată nicio imagine QR.';

  @override
  String get uploadQrImage => 'Încarcă imagine QR';
}

/// The translations for Romanian Moldavian Moldovan, as used in Moldova (`ro_MD`).
class AppLocalizationsRoMd extends AppLocalizationsRo {
  AppLocalizationsRoMd(): super('ro_MD');

  @override
  String get noQrImageSelected => 'Nu a fost selectată nicio imagine QR.';

  @override
  String get uploadQrImage => 'Încarcă imagine QR';
}
