import 'package:firestore_app/screens/home.dart';
import 'package:firestore_app/screens/login.dart';
import 'package:firestore_app/screens/reg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MaterialApp(
    home: new SplashScreen(
      seconds: 4,
      navigateAfterSeconds: new MyLogin(),
      title: new Text('Linux Terminal App '),
      image: new Image.asset('assets/l1.png'),
      backgroundColor: Colors.orange,
      styleTextUnderTheLoader: new TextStyle(fontWeight: FontWeight.w100),
      photoSize: 100.0,
      loaderColor: Colors.white,
      loadingText: Text('Connecting to Firebase'),
    ),
    routes: {
      "home": (context) => MyHome(),
      "reg": (context) => MyReg(),
      "login": (context) => MyLogin(),
    },
  ));
}
