import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mp_pay/1_home_page/mobile_page.dart';
import 'package:mp_pay/curved_painty.dart';
import 'package:mp_pay/home%20Directory/bottam_navigation_bar.dart';
import 'package:mp_pay/login_directory/login_screen.dart';


class MAINfingerprint extends StatefulWidget {
  const MAINfingerprint({Key? key}) : super(key: key);

  @override
  State<MAINfingerprint> createState() => _MAINfingerprintState();
}

class _MAINfingerprintState extends State<MAINfingerprint> {
  final LocalAuthentication auth = LocalAuthentication();
  _SupportState _supportState = _SupportState.unknown;
  bool? _canCheckBiometrics;
  List<BiometricType>? _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;

  @override
  void initState() {
    super.initState();
    auth.isDeviceSupported().then(
          (bool isSupported) => setState(() => _supportState = isSupported
          ? _SupportState.supported
          : _SupportState.unsupported),
    );
    _authenticate();
  }


  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
        localizedReason: 'Let OS determine authentication method',
        options: const AuthenticationOptions(
          stickyAuth: true,
        ),
      );
      setState(() {
        _isAuthenticating = false;
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Error - ${e.message}';
      });
      return;
    }
    if (!mounted) {
      return;
    }

    setState(
            () => _authorized = authenticated ? ank() : 'Not Authorized');

  }


  Future<void> _cancelAuthentication() async {
    await auth.stopAuthentication();
    setState(() => _isAuthenticating = false);
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

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
  ank() {
    // Navigator.push(context, MaterialPageRoute(builder: (context)=>mobile()));
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => HomePage()
        )
    );
  }
}



enum _SupportState {
  unknown,
  supported,
  unsupported,
}