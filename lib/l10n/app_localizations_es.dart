// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get noQrImageSelected => 'No se ha seleccionado ninguna imagen QR.';

  @override
  String get uploadQrImage => 'Subir imagen QR';
}

/// The translations for Spanish Castilian, as used in Mexico (`es_MX`).
class AppLocalizationsEsMx extends AppLocalizationsEs {
  AppLocalizationsEsMx(): super('es_MX');

  @override
  String get noQrImageSelected => 'No se ha seleccionado ninguna imagen QR.';

  @override
  String get uploadQrImage => 'Subir imagen QR';
}
