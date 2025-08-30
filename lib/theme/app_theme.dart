import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      useMaterial3: true,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        brightness: Brightness.dark,
      ),
      useMaterial3: true,
    );
  }

  static const List<Locale> supportedLocales = [
    Locale('en'), // English
    Locale('en', 'US'), // American English
    Locale('en', 'GB'), // British English
    Locale('es'), // Spanish
    Locale('es', 'MX'), // Mexican Spanish
    Locale('fr'), // French
    Locale('fr', 'CA'), // Canadian French
    Locale('de'), // German
    Locale('de', 'AT'), // Austrian German
    Locale('de', 'CH'), // Swiss German
    Locale('it'), // Italian
    Locale('it', 'CH'), // Swiss Italian
    Locale('pt'), // Portuguese
    Locale('pt', 'BR'), // Brazilian Portuguese
    Locale('nl'), // Dutch
    Locale('nl', 'BE'), // Belgian Dutch
    Locale('sv'), // Swedish
    Locale('sv', 'FI'), // Finland Swedish
    Locale('no'), // Norwegian
    Locale('nb'), // Norwegian Bokmål
    Locale('nn'), // Norwegian Nynorsk
    Locale('da'), // Danish
    Locale('fi'), // Finnish
    Locale('is'), // Icelandic
    Locale('fo'), // Faroese
    Locale('kl'), // Greenlandic
    Locale('ga'), // Irish
    Locale('gd'), // Scottish Gaelic
    Locale('gv'), // Manx
    Locale('cy'), // Welsh
    Locale('br'), // Breton
    Locale('kw'), // Cornish
    Locale('fy'), // Frisian
    Locale('lb'), // Luxembourgish
    Locale('rm'), // Romansh
    Locale('oc'), // Occitan
    Locale('ca'), // Catalan
    Locale('eu'), // Basque
    Locale('gl'), // Galician
    Locale('ast'), // Asturian
    Locale('an'), // Aragonese
    Locale('mwl'), // Mirandese
    Locale('lad'), // Ladino
    Locale('yi'), // Yiddish
    Locale('ru'), // Russian
    Locale('uk'), // Ukrainian
    Locale('be'), // Belarusian
    Locale('pl'), // Polish
    Locale('cs'), // Czech
    Locale('sk'), // Slovak
    Locale('hr'), // Croatian
    Locale('sl'), // Slovenian
    Locale('bg'), // Bulgarian
    Locale('mk'), // Macedonian
    Locale('sq'), // Albanian
    Locale('sr'), // Serbian
    Locale('bs'), // Bosnian
    Locale('ro'), // Romanian
    Locale('mo'), // Moldovan
    Locale('gag'), // Gagauz
    Locale('rom'), // Romani
    Locale('hu'), // Hungarian
    Locale('et'), // Estonian
    Locale('lv'), // Latvian
    Locale('lt'), // Lithuanian
    Locale('el'), // Greek
    Locale('tr'), // Turkish
    Locale('az'), // Azerbaijani
    Locale('ka'), // Georgian
    Locale('hy'), // Armenian
    Locale('kk'), // Kazakh
    Locale('ky'), // Kyrgyz
    Locale('uz'), // Uzbek
    Locale('tg'), // Tajik
    Locale('tk'), // Turkmen
    Locale('ug'), // Uyghur
    Locale('mn'), // Mongolian
    Locale('bo'), // Tibetan
    Locale('zh'), // Chinese Simplified
    Locale('zh', 'TW'), // Chinese Traditional (Taiwan)
    Locale('zh', 'HK'), // Chinese Traditional (Hong Kong)
    Locale('ja'), // Japanese
    Locale('ko'), // Korean
    Locale('ar'), // Arabic
    Locale('he'), // Hebrew
    Locale('fa'), // Persian
    Locale('ps'), // Pashto
    Locale('prs'), // Dari
    Locale('ku'), // Kurdish
    Locale('bal'), // Balochi
    Locale('brh'), // Brahui
    Locale('sd'), // Sindhi
    Locale('ur'), // Urdu
    Locale('skr'), // Saraiki
    Locale('hno'), // Hindko
    Locale('ks'), // Kashmiri
    Locale('doi'), // Dogri
    Locale('kok'), // Konkani
    Locale('mni'), // Manipuri
    Locale('sa'), // Sanskrit
    Locale('hi'), // Hindi
    Locale('bn'), // Bengali
    Locale('as'), // Assamese
    Locale('or'), // Odia
    Locale('mr'), // Marathi
    Locale('gu'), // Gujarati
    Locale('pa'), // Punjabi
    Locale('ne'), // Nepali
    Locale('si'), // Sinhala
    Locale('dv'), // Dhivehi/Maldivian
    Locale('ta'), // Tamil
    Locale('te'), // Telugu
    Locale('ml'), // Malayalam
    Locale('kn'), // Kannada
    Locale('tcy'), // Tulu
    Locale('kfa'), // Kodava
    Locale('ms'), // Malay
    Locale('id'), // Indonesian
    Locale('jv'), // Javanese
    Locale('su'), // Sundanese
    Locale('ban'), // Balinese
    Locale('ace'), // Acehnese
    Locale('min'), // Minangkabau
    Locale('th'), // Thai
    Locale('lo'), // Lao
    Locale('km'), // Khmer
    Locale('vi'), // Vietnamese
    Locale('my'), // Burmese
    Locale('qu'), // Quechua
    Locale('am'), // Amharic
  ];
}
