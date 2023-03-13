import 'package:adventuresclub/constants.dart';
import 'package:adventuresclub/provider/complete_profile_provider/complete_profile_provider.dart';
import 'package:adventuresclub/provider/filter_provider.dart';
import 'package:adventuresclub/provider/services_provider.dart';
import 'package:adventuresclub/splashScreen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting().then(
    (_) => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => CompleteProfileProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => ServicesProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => FilterProvider(),
          ),
        ],
        child: const MyApp(),
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
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Raleway'),
      home: FutureBuilder(
        future: getApp(),
        builder: (context, asppsnapshot) {
          return const SplashScreen();
        },
      ),
    );
  }
}
