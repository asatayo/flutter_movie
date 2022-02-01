import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movie/const/constarts.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  //Init fuction is the fuction which is called first
  // when the app build
  @override
  void initState() {

    //the spash timer function which counts the seconds from when the app is lauched
    _splashTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(body: Container(
              margin:  const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                    Colors.black,
                    primaryColor, 
                  ])),
                  child:  Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Image.asset('assets/logo.png', height: 100, ),
      )),
    );
  }

  Future<void> _splashTimer() async {
   
        Timer(const Duration(seconds: 3),
          ()=> Navigator.restorablePushReplacementNamed(context, '/dashboard')
         );
  }
}
