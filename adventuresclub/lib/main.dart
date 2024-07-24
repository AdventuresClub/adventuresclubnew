import 'package:adventuresclub/app_theme.dart';
import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/firebase_options.dart';
import 'package:adventuresclub/provider/navigation_index_provider.dart';
import 'package:adventuresclub/provider/services_provider.dart';
import 'package:adventuresclub/splashScreen/splash_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';

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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future getAppFuture;
  @override
  void initState() {
    getAppFuture = getApp();

    super.initState();
  }

  Future<void> registerFCM() async {
    await FirebaseMessaging.instance.requestPermission();
    final fcmToken = await FirebaseMessaging.instance.getToken(
        vapidKey:
            "BEr0HbHx_pAg1PMPbqHuA2g0hQrHtbvsM5cNfxMThTHvnvcH01-Z8MnBo-qyDR0LvRPi2fvb_3WVWf4T2rlLOhg");
    if (fcmToken != null) {
      setFCMToken(fcmToken);
    }
    FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
      setFCMToken(fcmToken);
    }).onError((err) {});
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      if (notification != null) {
        Constants.showMessage(
            context, "${notification.title}: ${notification.body}");
        debugPrint('onMessage: ${notification.toString()}');
      }
    });
  }

  Future<void> getApp() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await registerFCM();

    await Constants.getPrefs();
  }

  void setFCMToken(String fcmToken) async {}

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
