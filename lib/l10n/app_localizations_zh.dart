// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get noQrImageSelected => '未选择QR图像。';

  @override
  String get uploadQrImage => '上传QR图像';
}

/// The translations for Chinese, as used in Hong Kong (`zh_HK`).
class AppLocalizationsZhHk extends AppLocalizationsZh {
  AppLocalizationsZhHk(): super('zh_HK');

  @override
  String get noQrImageSelected => '未選擇QR圖像。';

  @override
  String get uploadQrImage => '上傳QR圖像';
}

/// The translations for Chinese, as used in Taiwan (`zh_TW`).
class AppLocalizationsZhTw extends AppLocalizationsZh {
  AppLocalizationsZhTw(): super('zh_TW');

  @override
  String get noQrImageSelected => '未選擇QR圖像。';

  @override
  String get uploadQrImage => '上傳QR圖像';
}
