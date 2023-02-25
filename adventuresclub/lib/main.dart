import 'package:adventuresclub/provider/complete_profile_provider/complete_profile_provider.dart';
import 'package:adventuresclub/splashScreen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting().then((_) => runApp(MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => CompleteProfileProvider(),
          ),
          // ChangeNotifierProvider(
          //   create: (_) => CompletePartnerProvider(),
          // ),
        ],
        child: const MyApp(),
      )));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Roboto'),
        home: const SplashScreen());
  }
}
