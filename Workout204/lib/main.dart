import 'package:Workout204/authentication.dart';
import 'package:Workout204/client.dart';
import 'package:Workout204/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'authentication.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
    runApp(MyApp());
}

class MyApp extends StatelessWidget{
  Widget build(BuildContext context){
    return StreamProvider<Client>.value(
      value: Authentication().user,
      child: MaterialApp(
        home:SplashScreen(),

      ),
    );
  }
}




