// import 'package:flutter/material.dart';
// import 'package:mp_pay/app_constant.dart';
// import 'package:url_launcher/url_launcher.dart';
// class Screen extends StatefulWidget {
//   const Screen({Key? key}) : super(key: key);
//
//   @override
//   State<Screen> createState() => _ScreenState();
// }
//
// class _ScreenState extends State<Screen> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child:Scaffold(
//           appBar: AppBar(),
//           body: InkWell(
//             onTap: (){
//               _launchURL();
//             },
//             child: Container(
//               height: 50,width: 50,
//               // color: Colors.orange,
//               decoration: BoxDecoration(
//
//                 border: Border.all(
//                   color: kTabBarBg,
//                   width: 8,
//                 ), //Border.all
//
//                 borderRadius: BorderRadius.circular(15),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black,
//                     offset: const Offset(
//                       5.0,
//                       5.0,
//                     ), //Offset
//                     blurRadius: 10.0,
//                     spreadRadius: 2.0,
//                   ), //BoxShadow
//                   BoxShadow(
//                     color: Colors.white,
//                     offset: const Offset(0.0, 0.0),
//                     blurRadius: 0.0,
//                     spreadRadius: 0.0,
//                   ), //BoxShadow
//                 ],
//               ),
//               child: Image.asset('assets/phone.gif',
//                 height: 20,width: 20,),
//             ),
//           ),
//     ));
//   }
// }
//
//
// void _launchURL() async {
//   String _url='upi://pay?pa=8009296978@ybl&pn=Dinesh&am=1&tn=Test Payment&cu=INR';
//   var result = await launch(_url);
//   debugPrint(result.toString());
//   if (result ==true) {
//     print("Done");
//   } else if (result ==false){
//     print("Fail");
//   }
// }

import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mp_pay/app_constant.dart';
import 'package:mp_pay/curved_painty.dart';
import 'package:mp_pay/wigets/back_button.dart';
import 'package:http/http.dart' as http;
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Payment extends StatefulWidget {
  const Payment();
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<Payment> {
  _MyAppState();
  // late Future<Order> futureAlbum;
  final amoount = TextEditingController();
 // static const platform = MethodChannel("Sagar sandwich");
  late Razorpay _razorpay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Column(
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child:  CustomPaint(
                  painter: SplashPainter(),
                  child: Column(
                    children: <Widget>[
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Container(
                            // width: width,
                            // height: 120.h,
                            decoration: BoxDecoration(
                              color: kTabBarBg,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        'Enter Amount',
                                        style:TextStyle(
                                            fontFamily: "Windsor",
                                            fontSize: 40
                                        )
                                      //color:kGreenPurchaseColor,
                                    ),
                                    SizedBox(height: 5),
                                    Container(
                                      width: 100,
                                      alignment: Alignment.center,
                                      child: TextFormField(
                                        style: TextStyle(
                                          fontSize: 40,
                                        ),
                                        textAlign: TextAlign.center,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color:kGreenPurchaseColor,
                                            ),
                                          ),
                                          hintText: "00",),
                                        controller: amoount,
                                      ),
                                    ),
                                    SizedBox( height: 40,),
                                    Container(
                                      height: 30,width: 200,
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Center(child: Text("100% safe & Secure")),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                          ),
                        ),

                      ),
                      SizedBox(height: 20,),
                      Container(
                        child: Center(child: Text("PAY USING",
                          style: TextStyle(fontFamily: "Windsor",),)),
                      ),
                      SizedBox(height: 20,),
                      SizedBox(
                        width: double.infinity,
                        child:
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0,
                              right: 15,
                              top: 10,
                              bottom: 10),
                          child: MaterialButton(
                            elevation: 10,
                            onPressed:(){

                              openCheckout(amoount.text);
                            } ,

                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: const [
                                Text(
                                  'PAY',
                                  style: TextStyle(fontFamily: "Windsor",
                                    fontSize: 26,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            color: kRedColor,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadiusDirectional.circular(10),
                              // side: const BorderSide(color: kRedColor),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )

            ),
            const SizedBox(
              height: 20,
            ),

          ],
        ),
      ),
    );
  }
  String datetime = DateTime.now().toString();

  var dt = DateTime.now();

  @override
  void initState() {
    super.initState();
    //  (UserSimplePref.getTotalPrice() ?? 1) *


    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

   openCheckout(String am) async {
    final pref1= await SharedPreferences.getInstance();
    pref1.setString('amoun', am);


    final email =pref1.getString('ema');
    final mobile =pref1.getString('mob');
    var options = {
      //  double.parse(something) *
      'key': 'rzp_live_lHpffukxVooemY',
      'amount': am+'00',
      'name': 'Desham Pay',
      'description': "Mobile Recharge Balance",
      'retry': {'enabled': true, 'max_count': 100},
      'send_sms_hash': true,
      'prefill': {'contact': '$mobile',
        'email': '$email'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response)async {
    // print('Success Response: $response');


    int random(int min, int max) {
      return min + Random().nextInt(max - min);
    }
      final prefs = await SharedPreferences.getInstance();
      final key = 'user_id';
      final value = prefs.getInt(key) ?? "0";


    final amo =prefs.getString('amoun');
final trx = random(1111111, 99999999999999999);
      // int random(int min, int max) {
      //   return min + Random().nextInt(max - min);
      // }
      final date=dt.day;
      final month=dt.month;
      final year=dt.year;
      final prefs2 = await SharedPreferences.getInstance();
      final key2 = 'apptoken';
      final value2 = prefs2.getString(key2) ?? "0";
      final response = await http.post(
        Uri.parse(
            Apiconst.baseurl+"android/loadwalletre?"+'apptoken=$value2&'+'user_id=$value&paymentmode=online&amount=$amo'
                '&respmsg=success&txndate=$date/$month/$year&transactionid=$trx&txnid=$trx'),

      );

      final data = jsonDecode(response.body);

      print(data);
      if (data['status'] == 'TXN') {


        Fluttertoast.showToast(
            msg: data['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        print("Payment Add SucessFully");
        // Navigator.push(context, MaterialPageRoute(builder: (context) => MainDashboardScreen()));
      } else {
        Fluttertoast.showToast(
            msg: data['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);

    }




    // postOrder(
    //   id, price, count, sizee, response.paymentId.toString(), 'upi',
    //     totalPrice.toString(), 'success', addressid, context);
    // Text(response.paymentId.toString());
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print('Error Response: $response');

    Fluttertoast.showToast(
        msg: "ERROR: ${response.code} - ${response.message!}",
        toastLength: Toast.LENGTH_SHORT);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('External SDK Response: $response');
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: ${response.walletName!}",
        toastLength: Toast.LENGTH_SHORT);
  }
}





