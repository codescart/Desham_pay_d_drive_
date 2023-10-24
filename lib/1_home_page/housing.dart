import 'package:flutter/material.dart';
import 'package:mp_pay/app_constant.dart';
import 'package:mp_pay/curved_painty.dart';
import 'package:mp_pay/wigets/back_button.dart';


class housing_page extends StatefulWidget {
  const housing_page({Key? key}) : super(key: key);

  @override
  State<housing_page> createState() => _housing_pageState();
}

class _housing_pageState extends State<housing_page> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
    Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        leading: back(),
        title: Text(
          "Housing Services",
          style: TextStyle(
            fontFamily: "Windsor",
            color: kTextLowBlackColor,
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child:  CustomPaint(
              painter: SplashPainter(),
              child:Center(
                child: Container(
                  height: 210,width: 300,
                  child: Image.asset('assets/comming_soon.gif',),
                ),
              ),
            )

        ),
      ),
    )
    );
  }
}
