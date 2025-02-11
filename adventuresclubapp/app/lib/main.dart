import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:app/app_theme.dart';
import 'package:app/constants.dart';
import 'package:app/firebase_options.dart';
import 'package:app/models/received_notification.dart';
import 'package:app/provider/edit_provider.dart';
import 'package:app/provider/navigation_index_provider.dart';
import 'package:app/provider/services_provider.dart';
import 'package:app/routes.dart';
import 'package:app/splashScreen/splash_screen.dart';
import 'package:app_links/app_links.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
          ChangeNotifierProvider(
            create: (_) => EditProvider(),
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
  final navigatorKey = GlobalKey<NavigatorState>();
  late AppLinks appLinks;
  StreamSubscription<Uri>? linkSubscription;

  @override
  void initState() {
    getAppFuture = getApp();
    super.initState();
    initDeepLinks();
  }

  @override
  void dispose() {
    linkSubscription?.cancel();
    super.dispose();
  }

  Future<void> initDeepLinks() async {
    appLinks = AppLinks();

    // Handle links
    linkSubscription = appLinks.uriLinkStream.listen((uri) {
      debugPrint('onAppLink: $uri');
      openAppLink(uri);
    });
  }

  void openAppLink(Uri uri) {
    navigatorKey.currentState?.pushNamed(uri.fragment);
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// Streams are created so that app can respond to notification-related events
  /// since the plugin is initialised in the `main` function
  final StreamController<ReceivedNotification>
      didReceiveLocalNotificationStream =
      StreamController<ReceivedNotification>.broadcast();

  final StreamController<String?> selectNotificationStream =
      StreamController<String?>.broadcast();

  /// Create a [AndroidNotificationChannel] for heads up notifications
  late AndroidNotificationChannel channel;
  String? selectedNotificationPayload;

  /// A notification action which triggers a url launch event
  static const String urlLaunchActionId = 'id_1';

  /// A notification action which triggers a App navigation event
  static const String navigationActionId = 'id_3';

  /// Defines a iOS/MacOS notification category for text input actions.
  static const String darwinNotificationCategoryText = 'textCategory';

  /// Defines a iOS/MacOS notification category for plain actions.
  static const String darwinNotificationCategoryPlain = 'plainCategory';

  @pragma('vm:entry-point')
  void notificationTapBackground(
      NotificationResponse notificationResponse) async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    //Constants.updateBookingStatus(notificationResponse.actionId!, notificationResponse.payload!);
    if (notificationResponse.input?.isNotEmpty ?? false) {
      // ignore: avoid_print
      print(
          'notification action tapped with input: ${notificationResponse.input}');
    }
  }

  @pragma('vm:entry-point')
  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await setupFlutterNotifications();
    showFlutterNotification(message);
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    log('Handling a background message ${message.messageId}');
  }

  Future<void> setupFlutterNotifications() async {
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  void showFlutterNotification(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null && !kIsWeb) {
      debugPrint(jsonEncode(message.data));
      if (message.data['type'] != null && message.data['type'] == 'created') {
        // showNotificationWithActions(message);
      } else {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              icon: '@mipmap/launcher_icon',
            ),
          ),
        );
      }
    }
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
    //await registerFCM();

    await Constants.getPrefs();
  }

  void setFCMToken(String fcmToken) async {}

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    bool isDark = false;
    // return MaterialApp(
    //   navigatorKey: navigatorKey,
    //   initialRoute: "/",
    //   onGenerateRoute: (RouteSettings settings) {
    //     Widget routeWidget = SplashScreen();

    //     // Mimic web routing
    //     final routeName = settings.name;
    //     if (routeName != null) {
    //       if (routeName.startsWith('/book/')) {
    //         // Navigated to /book/:id
    //         routeWidget = customScreen(
    //           routeName.substring(routeName.indexOf('/book/')),
    //         );
    //       } else if (routeName == '/book') {
    //         // Navigated to /book without other parameters
    //         routeWidget = customScreen("None");
    //       }
    //     }

    //     return MaterialPageRoute(
    //       builder: (context) => routeWidget,
    //       settings: settings,
    //       fullscreenDialog: true,
    //     );
    //   },
    // );

    return MaterialApp.router(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'Adventures Club',
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: AppTheme.getCurrentTheme(isDark),
      // home: FutureBuilder(
      //   future: getApp(),
      //   builder: (context, asppsnapshot) {
      //     // return const TempGoogleMap();
      //     return const SplashScreen();
      //   },
      // ),
    );
  }
}

Widget customScreen(String bookId) {
  return Scaffold(
    appBar: AppBar(title: const Text('Second Screen')),
    body: Center(child: Text('Opened with parameter: $bookId')),
  );
}
