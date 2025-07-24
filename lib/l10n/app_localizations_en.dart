// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get noQrImageSelected => 'No QR image selected.';

  @override
  String get uploadQrImage => 'Upload QR Image';
}

/// The translations for English, as used in the United Kingdom (`en_GB`).
class AppLocalizationsEnGb extends AppLocalizationsEn {
  AppLocalizationsEnGb(): super('en_GB');

  @override
  String get noQrImageSelected => 'No QR image selected.';

  @override
  String get uploadQrImage => 'Upload QR Image';
}

/// The translations for English, as used in the United States (`en_US`).
class AppLocalizationsEnUs extends AppLocalizationsEn {
  AppLocalizationsEnUs(): super('en_US');

  @override
  String get noQrImageSelected => 'No QR image selected.';

  @override
  String get uploadQrImage => 'Upload QR Image';
}
