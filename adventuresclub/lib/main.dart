import 'package:adventuresclub/app_theme.dart';
import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/provider/navigation_index_provider.dart';
import 'package:adventuresclub/provider/services_provider.dart';
import 'package:adventuresclub/splashScreen/splash_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  initializeDateFormatting().then(
    (_) => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => ServicesProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => NavigationIndexProvider(),
          ),
        ],
        child: EasyLocalization(
          supportedLocales: const [Locale('en', 'US'), Locale('ar', 'SA')],
          path: 'assets/translations',
          fallbackLocale: const Locale('en', 'US'),
          child: const MyApp(),
        ),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<void> getApp() async {
    await Constants.getPrefs();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    bool isDark = false;
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'Adventures Club',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.getCurrentTheme(isDark),
      home: FutureBuilder(
        future: getApp(),
        builder: (context, asppsnapshot) {
          // return const TempGoogleMap();
          return const SplashScreen();
        },
      ),
    );
  }
}
