import 'package:flutter/material.dart';
import 'package:mp_pay/1_home_page/wallet.dart';
import 'package:mp_pay/app_constant.dart';
import 'package:mp_pay/curved_painty.dart';
import 'package:mp_pay/wigets/back_button.dart';


class Add_upi_bank extends StatefulWidget {
  const Add_upi_bank({Key? key}) : super(key: key);

  @override
  State<Add_upi_bank> createState() => _Add_upi_bankState();
}

class _Add_upi_bankState extends State<Add_upi_bank> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
    Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        leading: back(),
        title: Text(
          "Add Money",
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
              child: Column(
                children: [
                  SizedBox(height: 40,),
                  Divider(),
                  Container(
                      child: Wallet()
                  ),
                  Divider(),
                ],
              ),
            )

        ),
      ),
    )
    );
  }
}
