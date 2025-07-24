// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get noQrImageSelected => 'Nessuna immagine QR selezionata.';

  @override
  String get uploadQrImage => 'Carica immagine QR';
}

/// The translations for Italian, as used in Switzerland (`it_CH`).
class AppLocalizationsItCh extends AppLocalizationsIt {
  AppLocalizationsItCh(): super('it_CH');

  @override
  String get noQrImageSelected => 'Nessuna immagine QR selezionata.';

  @override
  String get uploadQrImage => 'Carica immagine QR';
}
