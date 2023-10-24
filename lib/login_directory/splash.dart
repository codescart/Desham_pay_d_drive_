import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mp_pay/curved_painty.dart';
import 'package:mp_pay/finger_print_page/main_fingerprint.dart';
import 'package:mp_pay/home%20Directory/bottam_navigation_bar.dart';
import 'package:mp_pay/login_directory/sign_up_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_screen.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var email;

  @override
  void initState() {
    super.initState();
pre();

  }

  pre()async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'user_id';
    final value = prefs.getInt(key) ?? "0";

    value == 0?
    Timer(
        Duration(seconds:5),
            () =>
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => login()))):
    Timer(
        Duration(seconds:5),
            () =>
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => MAINfingerprint())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:Column(
        children: [
       Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        child:  CustomPaint(
          painter: SplashPainter(),
         child: Image.asset(
            'assets/logo.png',
            height: 150,width: 150,
          ),
        ),)
        ],
      )
    );
  }
}


