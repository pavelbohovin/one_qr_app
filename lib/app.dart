import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';
import 'theme/app_theme.dart';
import 'features/splash/splash_screen.dart';

class OneQRApp extends StatelessWidget {
  const OneQRApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'One QR',
      themeMode: ThemeMode.system, // Follows system dark/light mode
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppTheme.supportedLocales,
      home: const SplashScreen(),
    );
  }
}
