import 'package:flutter/material.dart';
import 'package:mp_pay/curved_painty.dart';


class help_page extends StatefulWidget {
  const help_page({Key? key}) : super(key: key);

  @override
  State<help_page> createState() => _help_pageState();
}

class _help_pageState extends State<help_page> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
    Scaffold(
      body: SingleChildScrollView(
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child:  CustomPaint(
              painter: SplashPainter(),
            )

        ),
      ),
    )
    );
  }
}
