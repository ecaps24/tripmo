import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tripmo/screens/login_screen.dart';
import 'package:tripmo/screens/main_page.dart';
import 'package:tripmo/screens/register_screen.dart';
import 'package:tripmo/screens/splashScreen/splash_screen.dart';
import 'package:tripmo/screens/themeProvider/theme_provider.dart';

Future<void> main() async {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.system,
      theme: MyThemes.lightTheme,
      darkTheme: MyThemes.darkTheme,
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
