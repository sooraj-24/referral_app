import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:referral_app/Screens/home.dart';
import 'package:referral_app/Screens/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    navigate();
  }

  FirebaseAuth auth = FirebaseAuth.instance;

  void navigate(){
    Future.delayed(const Duration(seconds: 2),(){
      if(auth.currentUser != null){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return HomePage();
        }));
      } else {
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return SignInScreen();
        }));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlutterLogo(),
      ),
    );
  }
}
