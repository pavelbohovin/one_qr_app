import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ace.dart';
import 'app_localizations_am.dart';
import 'app_localizations_an.dart';
import 'app_localizations_ar.dart';
import 'app_localizations_as.dart';
import 'app_localizations_ast.dart';
import 'app_localizations_az.dart';
import 'app_localizations_bal.dart';
import 'app_localizations_ban.dart';
import 'app_localizations_be.dart';
import 'app_localizations_bg.dart';
import 'app_localizations_bn.dart';
import 'app_localizations_bo.dart';
import 'app_localizations_br.dart';
import 'app_localizations_brh.dart';
import 'app_localizations_bs.dart';
import 'app_localizations_ca.dart';
import 'app_localizations_cs.dart';
import 'app_localizations_cy.dart';
import 'app_localizations_da.dart';
import 'app_localizations_de.dart';
import 'app_localizations_doi.dart';
import 'app_localizations_dv.dart';
import 'app_localizations_el.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_et.dart';
import 'app_localizations_eu.dart';
import 'app_localizations_fa.dart';
import 'app_localizations_fi.dart';
import 'app_localizations_fo.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_fy.dart';
import 'app_localizations_ga.dart';
import 'app_localizations_gag.dart';
import 'app_localizations_gd.dart';
import 'app_localizations_gl.dart';
import 'app_localizations_gu.dart';
import 'app_localizations_gv.dart';
import 'app_localizations_he.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_hno.dart';
import 'app_localizations_hr.dart';
import 'app_localizations_hu.dart';
import 'app_localizations_hy.dart';
import 'app_localizations_id.dart';
import 'app_localizations_is.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_jv.dart';
import 'app_localizations_ka.dart';
import 'app_localizations_kfa.dart';
import 'app_localizations_kk.dart';
import 'app_localizations_kl.dart';
import 'app_localizations_km.dart';
import 'app_localizations_kn.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_kok.dart';
import 'app_localizations_ks.dart';
import 'app_localizations_ku.dart';
import 'app_localizations_kw.dart';
import 'app_localizations_ky.dart';
import 'app_localizations_lad.dart';
import 'app_localizations_lb.dart';
import 'app_localizations_lo.dart';
import 'app_localizations_lt.dart';
import 'app_localizations_lv.dart';
import 'app_localizations_min.dart';
import 'app_localizations_mk.dart';
import 'app_localizations_ml.dart';
import 'app_localizations_mn.dart';
import 'app_localizations_mni.dart';
import 'app_localizations_mr.dart';
import 'app_localizations_ms.dart';
import 'app_localizations_mt.dart';
import 'app_localizations_mwl.dart';
import 'app_localizations_my.dart';
import 'app_localizations_nb.dart';
import 'app_localizations_ne.dart';
import 'app_localizations_nl.dart';
import 'app_localizations_nn.dart';
import 'app_localizations_no.dart';
import 'app_localizations_oc.dart';
import 'app_localizations_or.dart';
import 'app_localizations_pa.dart';
import 'app_localizations_pl.dart';
import 'app_localizations_prs.dart';
import 'app_localizations_ps.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_qu.dart';
import 'app_localizations_rm.dart';
import 'app_localizations_ro.dart';
import 'app_localizations_rom.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_sa.dart';
import 'app_localizations_sd.dart';
import 'app_localizations_si.dart';
import 'app_localizations_sk.dart';
import 'app_localizations_skr.dart';
import 'app_localizations_sl.dart';
import 'app_localizations_sq.dart';
import 'app_localizations_sr.dart';
import 'app_localizations_su.dart';
import 'app_localizations_sv.dart';
import 'app_localizations_ta.dart';
import 'app_localizations_tcy.dart';
import 'app_localizations_te.dart';
import 'app_localizations_tg.dart';
import 'app_localizations_th.dart';
import 'app_localizations_tk.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_ug.dart';
import 'app_localizations_uk.dart';
import 'app_localizations_ur.dart';
import 'app_localizations_uz.dart';
import 'app_localizations_vi.dart';
import 'app_localizations_yi.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ace'),
    Locale('am'),
    Locale('an'),
    Locale('ar'),
    Locale('as'),
    Locale('ast'),
    Locale('az'),
    Locale('bal'),
    Locale('ban'),
    Locale('be'),
    Locale('bg'),
    Locale('bn'),
    Locale('bo'),
    Locale('br'),
    Locale('brh'),
    Locale('bs'),
    Locale('ca'),
    Locale('cs'),
    Locale('cy'),
    Locale('da'),
    Locale('de'),
    Locale('de', 'AT'),
    Locale('de', 'CH'),
    Locale('doi'),
    Locale('dv'),
    Locale('el'),
    Locale('en'),
    Locale('en', 'GB'),
    Locale('en', 'US'),
    Locale('es'),
    Locale('es', 'MX'),
    Locale('et'),
    Locale('eu'),
    Locale('fa'),
    Locale('fi'),
    Locale('fo'),
    Locale('fr'),
    Locale('fr', 'CA'),
    Locale('fy'),
    Locale('ga'),
    Locale('gag'),
    Locale('gd'),
    Locale('gl'),
    Locale('gu'),
    Locale('gv'),
    Locale('he'),
    Locale('hi'),
    Locale('hno'),
    Locale('hr'),
    Locale('hu'),
    Locale('hy'),
    Locale('id'),
    Locale('is'),
    Locale('it'),
    Locale('it', 'CH'),
    Locale('ja'),
    Locale('jv'),
    Locale('ka'),
    Locale('kfa'),
    Locale('kk'),
    Locale('kl'),
    Locale('km'),
    Locale('kn'),
    Locale('ko'),
    Locale('kok'),
    Locale('ks'),
    Locale('ku'),
    Locale('kw'),
    Locale('ky'),
    Locale('lad'),
    Locale('lb'),
    Locale('lo'),
    Locale('lt'),
    Locale('lv'),
    Locale('min'),
    Locale('mk'),
    Locale('ml'),
    Locale('mn'),
    Locale('mni'),
    Locale('mr'),
    Locale('ms'),
    Locale('mt'),
    Locale('mwl'),
    Locale('my'),
    Locale('nb'),
    Locale('ne'),
    Locale('nl'),
    Locale('nl', 'BE'),
    Locale('nn'),
    Locale('no'),
    Locale('oc'),
    Locale('or'),
    Locale('pa'),
    Locale('pl'),
    Locale('prs'),
    Locale('ps'),
    Locale('pt'),
    Locale('pt', 'BR'),
    Locale('qu'),
    Locale('rm'),
    Locale('ro'),
    Locale('ro', 'MD'),
    Locale('rom'),
    Locale('ru'),
    Locale('sa'),
    Locale('sd'),
    Locale('si'),
    Locale('sk'),
    Locale('skr'),
    Locale('sl'),
    Locale('sq'),
    Locale('sr'),
    Locale('su'),
    Locale('sv'),
    Locale('sv', 'FI'),
    Locale('ta'),
    Locale('tcy'),
    Locale('te'),
    Locale('tg'),
    Locale('th'),
    Locale('tk'),
    Locale('tr'),
    Locale('ug'),
    Locale('uk'),
    Locale('ur'),
    Locale('uz'),
    Locale('vi'),
    Locale('yi'),
    Locale('zh'),
    Locale('zh', 'HK'),
    Locale('zh', 'TW')
  ];

  /// Message shown when no QR image is selected
  ///
  /// In en, this message translates to:
  /// **'No QR image selected.'**
  String get noQrImageSelected;

  /// Tooltip for the upload button
  ///
  /// In en, this message translates to:
  /// **'Upload QR Image'**
  String get uploadQrImage;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ace', 'am', 'an', 'ar', 'as', 'ast', 'az', 'bal', 'ban', 'be', 'bg', 'bn', 'bo', 'br', 'brh', 'bs', 'ca', 'cs', 'cy', 'da', 'de', 'doi', 'dv', 'el', 'en', 'es', 'et', 'eu', 'fa', 'fi', 'fo', 'fr', 'fy', 'ga', 'gag', 'gd', 'gl', 'gu', 'gv', 'he', 'hi', 'hno', 'hr', 'hu', 'hy', 'id', 'is', 'it', 'ja', 'jv', 'ka', 'kfa', 'kk', 'kl', 'km', 'kn', 'ko', 'kok', 'ks', 'ku', 'kw', 'ky', 'lad', 'lb', 'lo', 'lt', 'lv', 'min', 'mk', 'ml', 'mn', 'mni', 'mr', 'ms', 'mt', 'mwl', 'my', 'nb', 'ne', 'nl', 'nn', 'no', 'oc', 'or', 'pa', 'pl', 'prs', 'ps', 'pt', 'qu', 'rm', 'ro', 'rom', 'ru', 'sa', 'sd', 'si', 'sk', 'skr', 'sl', 'sq', 'sr', 'su', 'sv', 'ta', 'tcy', 'te', 'tg', 'th', 'tk', 'tr', 'ug', 'uk', 'ur', 'uz', 'vi', 'yi', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {

  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'de': {
  switch (locale.countryCode) {
    case 'AT': return AppLocalizationsDeAt();
case 'CH': return AppLocalizationsDeCh();
   }
  break;
   }
    case 'en': {
  switch (locale.countryCode) {
    case 'GB': return AppLocalizationsEnGb();
case 'US': return AppLocalizationsEnUs();
   }
  break;
   }
    case 'es': {
  switch (locale.countryCode) {
    case 'MX': return AppLocalizationsEsMx();
   }
  break;
   }
    case 'fr': {
  switch (locale.countryCode) {
    case 'CA': return AppLocalizationsFrCa();
   }
  break;
   }
    case 'it': {
  switch (locale.countryCode) {
    case 'CH': return AppLocalizationsItCh();
   }
  break;
   }
    case 'nl': {
  switch (locale.countryCode) {
    case 'BE': return AppLocalizationsNlBe();
   }
  break;
   }
    case 'pt': {
  switch (locale.countryCode) {
    case 'BR': return AppLocalizationsPtBr();
   }
  break;
   }
    case 'ro': {
  switch (locale.countryCode) {
    case 'MD': return AppLocalizationsRoMd();
   }
  break;
   }
    case 'sv': {
  switch (locale.countryCode) {
    case 'FI': return AppLocalizationsSvFi();
   }
  break;
   }
    case 'zh': {
  switch (locale.countryCode) {
    case 'HK': return AppLocalizationsZhHk();
case 'TW': return AppLocalizationsZhTw();
   }
  break;
   }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ace': return AppLocalizationsAce();
    case 'am': return AppLocalizationsAm();
    case 'an': return AppLocalizationsAn();
    case 'ar': return AppLocalizationsAr();
    case 'as': return AppLocalizationsAs();
    case 'ast': return AppLocalizationsAst();
    case 'az': return AppLocalizationsAz();
    case 'bal': return AppLocalizationsBal();
    case 'ban': return AppLocalizationsBan();
    case 'be': return AppLocalizationsBe();
    case 'bg': return AppLocalizationsBg();
    case 'bn': return AppLocalizationsBn();
    case 'bo': return AppLocalizationsBo();
    case 'br': return AppLocalizationsBr();
    case 'brh': return AppLocalizationsBrh();
    case 'bs': return AppLocalizationsBs();
    case 'ca': return AppLocalizationsCa();
    case 'cs': return AppLocalizationsCs();
    case 'cy': return AppLocalizationsCy();
    case 'da': return AppLocalizationsDa();
    case 'de': return AppLocalizationsDe();
    case 'doi': return AppLocalizationsDoi();
    case 'dv': return AppLocalizationsDv();
    case 'el': return AppLocalizationsEl();
    case 'en': return AppLocalizationsEn();
    case 'es': return AppLocalizationsEs();
    case 'et': return AppLocalizationsEt();
    case 'eu': return AppLocalizationsEu();
    case 'fa': return AppLocalizationsFa();
    case 'fi': return AppLocalizationsFi();
    case 'fo': return AppLocalizationsFo();
    case 'fr': return AppLocalizationsFr();
    case 'fy': return AppLocalizationsFy();
    case 'ga': return AppLocalizationsGa();
    case 'gag': return AppLocalizationsGag();
    case 'gd': return AppLocalizationsGd();
    case 'gl': return AppLocalizationsGl();
    case 'gu': return AppLocalizationsGu();
    case 'gv': return AppLocalizationsGv();
    case 'he': return AppLocalizationsHe();
    case 'hi': return AppLocalizationsHi();
    case 'hno': return AppLocalizationsHno();
    case 'hr': return AppLocalizationsHr();
    case 'hu': return AppLocalizationsHu();
    case 'hy': return AppLocalizationsHy();
    case 'id': return AppLocalizationsId();
    case 'is': return AppLocalizationsIs();
    case 'it': return AppLocalizationsIt();
    case 'ja': return AppLocalizationsJa();
    case 'jv': return AppLocalizationsJv();
    case 'ka': return AppLocalizationsKa();
    case 'kfa': return AppLocalizationsKfa();
    case 'kk': return AppLocalizationsKk();
    case 'kl': return AppLocalizationsKl();
    case 'km': return AppLocalizationsKm();
    case 'kn': return AppLocalizationsKn();
    case 'ko': return AppLocalizationsKo();
    case 'kok': return AppLocalizationsKok();
    case 'ks': return AppLocalizationsKs();
    case 'ku': return AppLocalizationsKu();
    case 'kw': return AppLocalizationsKw();
    case 'ky': return AppLocalizationsKy();
    case 'lad': return AppLocalizationsLad();
    case 'lb': return AppLocalizationsLb();
    case 'lo': return AppLocalizationsLo();
    case 'lt': return AppLocalizationsLt();
    case 'lv': return AppLocalizationsLv();
    case 'min': return AppLocalizationsMin();
    case 'mk': return AppLocalizationsMk();
    case 'ml': return AppLocalizationsMl();
    case 'mn': return AppLocalizationsMn();
    case 'mni': return AppLocalizationsMni();
    case 'mr': return AppLocalizationsMr();
    case 'ms': return AppLocalizationsMs();
    case 'mt': return AppLocalizationsMt();
    case 'mwl': return AppLocalizationsMwl();
    case 'my': return AppLocalizationsMy();
    case 'nb': return AppLocalizationsNb();
    case 'ne': return AppLocalizationsNe();
    case 'nl': return AppLocalizationsNl();
    case 'nn': return AppLocalizationsNn();
    case 'no': return AppLocalizationsNo();
    case 'oc': return AppLocalizationsOc();
    case 'or': return AppLocalizationsOr();
    case 'pa': return AppLocalizationsPa();
    case 'pl': return AppLocalizationsPl();
    case 'prs': return AppLocalizationsPrs();
    case 'ps': return AppLocalizationsPs();
    case 'pt': return AppLocalizationsPt();
    case 'qu': return AppLocalizationsQu();
    case 'rm': return AppLocalizationsRm();
    case 'ro': return AppLocalizationsRo();
    case 'rom': return AppLocalizationsRom();
    case 'ru': return AppLocalizationsRu();
    case 'sa': return AppLocalizationsSa();
    case 'sd': return AppLocalizationsSd();
    case 'si': return AppLocalizationsSi();
    case 'sk': return AppLocalizationsSk();
    case 'skr': return AppLocalizationsSkr();
    case 'sl': return AppLocalizationsSl();
    case 'sq': return AppLocalizationsSq();
    case 'sr': return AppLocalizationsSr();
    case 'su': return AppLocalizationsSu();
    case 'sv': return AppLocalizationsSv();
    case 'ta': return AppLocalizationsTa();
    case 'tcy': return AppLocalizationsTcy();
    case 'te': return AppLocalizationsTe();
    case 'tg': return AppLocalizationsTg();
    case 'th': return AppLocalizationsTh();
    case 'tk': return AppLocalizationsTk();
    case 'tr': return AppLocalizationsTr();
    case 'ug': return AppLocalizationsUg();
    case 'uk': return AppLocalizationsUk();
    case 'ur': return AppLocalizationsUr();
    case 'uz': return AppLocalizationsUz();
    case 'vi': return AppLocalizationsVi();
    case 'yi': return AppLocalizationsYi();
    case 'zh': return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
