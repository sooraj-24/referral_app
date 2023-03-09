import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:referral_app/Processing/auth_provider.dart';
import 'package:referral_app/Processing/referral_provider.dart';
import 'package:referral_app/Screens/home.dart';
import 'package:referral_app/Screens/login.dart';
import 'package:referral_app/Screens/referral.dart';
import 'package:referral_app/Screens/splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => RefProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'Raleway',
        ),
        home: SplashScreen(),
      ),
    );
  }
}
