import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mp_pay/app_constant.dart';
import 'package:mp_pay/curved_painty.dart';
import 'package:mp_pay/wigets/back_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upi_india/upi_india.dart';
 import 'package:http/http.dart' as http;
import  'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class pay extends StatefulWidget {
  @override
  _payState createState() => _payState();
}

class _payState extends State<pay> {
  final amoount = TextEditingController();
  late Razorpay _razorpay;

  Future<UpiResponse>? _transaction;
  UpiIndia _upiIndia = UpiIndia();
  UpiApp app = UpiApp.googlePay;
  List<UpiApp>? apps =[ UpiApp.googlePay,];

  TextStyle header = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  TextStyle value = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );

  @override
  void initState() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    _upiIndia.getAllUpiApps(mandatoryTransactionId: false).then((value) {
      setState(() {
        apps = value;
      });
    }).catchError((e) {
      apps = [];
    });
    super.initState();
  }

  Future<UpiResponse> initiateTransaction(UpiApp app, {required String amount}) async {
    final prefs1 = await SharedPreferences.getInstance();
    final key1 = 'amount';
    final mobile = amount ;
    prefs1.setString(key1, mobile);

    var long2 = double.parse(amount);
    return _upiIndia.startTransaction(
      app: app,
      receiverUpiId: "deshampaytechnoservices@icici",
      receiverName: 'Desham PAY',
      transactionRefId: 'Razorpay0256',
      transactionNote: 'Balance',
      amount: long2,
    );
  }
  String datetime = DateTime.now().toString();

  var dt = DateTime.now();

  Widget displayUpiApps() {

    if (apps == null)
      return Center(child: CircularProgressIndicator());
    else if (apps!.length == 0)
      return Center(
        child: Text(
          "No apps found to handle transaction.",
          style: TextStyle(fontFamily: "Windsor",),
        ),
      );
    else
      return Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Wrap(
            children: apps!.map<Widget>((UpiApp app) {
              return GestureDetector(
                onTap: () {
                  _transaction = initiateTransaction(app, amount:amoount.text);
                  setState(() {});
                },
                child: Container(
                  height: 100,
                  width: 100,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.memory(
                        app.icon,
                        height: 60,
                        width: 60,
                      ),
                      Text(app.name),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      );
  }

  String _upiErrorHandler(error) {
    switch (error) {
      case UpiIndiaAppNotInstalledException:
        return 'Requested app not installed on device';
      case UpiIndiaUserCancelledException:
        return 'You cancelled the transaction';
      case UpiIndiaNullResponseException:
        return 'Requested app didn\'t return any response';
      case UpiIndiaInvalidParametersException:
        return 'Requested app cannot handle the transaction';
      default:
        return 'Please Enter Amount';
    }
  }
  String ?txnId ;
  String? resCode ;
  String ?txnRef ;
  String ?status ;
  String ?approvalRef;
  void _checkTxnStatus(String status) {
    switch (status) {
      case UpiPaymentStatus.SUCCESS:
       pank(amoount.text);
        print('Transaction Successful');
        break;
      case UpiPaymentStatus.SUBMITTED:
        print('Transaction Submitted');
        break;
      case UpiPaymentStatus.FAILURE:
        print('Transaction Failed');
        print('Received an Unknown transaction status');
    }
  }

  Widget displayTransactionData(title, body) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$title: ", style: header),
          Flexible(
              child: Text(
                body,
                style: value,
              )),
        ],
      ),
    );
  }
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


                  Container(
                    height: MediaQuery.of(context).size.width*0.30,
                    child: displayUpiApps(),
                    // Expanded(
                    //   child: displayUpiApps(),
                    // ),
                  ),
                  // SizedBox(
                  //   width: double.infinity,
                  //   child:
                  //   Padding(
                  //     padding: const EdgeInsets.only(
                  //         left: 15.0,
                  //         right: 15,
                  //         top: 0,
                  //         bottom: 10),
                  //     child: MaterialButton(
                  //       elevation: 10,
                  //       onPressed:(){
                  //
                  //         openCheckout(amoount.text);
                  //       } ,
                  //
                  //       child: Row(
                  //         mainAxisAlignment:
                  //         MainAxisAlignment.center,
                  //         children:  [
                  //           Image.asset('assets/razor.png',
                  //             height:30,
                  //           )
                  //
                  //
                  //         ],
                  //       ),
                  //       color: Colors.black12,
                  //       padding: const EdgeInsets.symmetric(
                  //           horizontal: 20, vertical: 14),
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius:
                  //         BorderRadiusDirectional.circular(10),
                  //         // side: const BorderSide(color: kRedColor),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Expanded(
                    child: FutureBuilder(
                      future: _transaction,
                      builder: (BuildContext context, AsyncSnapshot<UpiResponse> snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasError) {
                            return Center(
                              child: Text(
                                _upiErrorHandler(snapshot.error.runtimeType),
                                style: header,
                              ), // Print's text message on screen
                            );
                          }

                          // If we have data then definitely we will have UpiResponse.
                          // It cannot be null
                          UpiResponse _upiResponse = snapshot.data!;

                          // Data in UpiResponse can be null. Check before printing
                           txnId = _upiResponse.transactionId ?? 'N/A';
                           resCode = _upiResponse.responseCode ?? 'N/A';
                           txnRef = _upiResponse.transactionRefId ?? 'N/A';
                           status = _upiResponse.status ?? 'N/A';
                           approvalRef = _upiResponse.approvalRefNo ?? 'N/A';
                          _checkTxnStatus(status!);
                         print('mddddddd') ;
                          print(_upiResponse.status);

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                displayTransactionData('Transaction Id', txnId),
                                displayTransactionData('Response Code', resCode),
                                displayTransactionData('Reference Id', txnRef),
                                displayTransactionData('Status', status!.toUpperCase()),
                                displayTransactionData('Approval No', approvalRef),
                              ],
                            ),
                          );
                        } else
                          return Center(
                            child: Text(''),
                          );
                      },
                    ),
                  )
                ],
              ),
            )

        ),
      ),
    )
    );
  }
  pank(String amount) async{
        final prefs = await SharedPreferences.getInstance();
    final key = 'user_id';
    final value = prefs.getInt(key) ?? "0";


final date=dt.day;
        final month=dt.month;
        final year=dt.year;
    final prefs2 = await SharedPreferences.getInstance();
    final key2 = 'apptoken';
    final value2 = prefs2.getString(key2) ?? "0";
    final response = await http.post(
      Uri.parse(
          Apiconst.baseurl+"android/loadwalletre?"+'apptoken=$value2&'+'user_id=$value&paymentmode=online&amount=$amount'
    '&respmsg=$status&txndate=$date/$month/$year&transactionid=$txnId&txnid=$approvalRef'),

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
      'key': 'rzp_live_ZUcMj3I9xxDqYy',
      'amount': am+'00',
      'name': 'Desham Pay',
      'description': "Mobile Recharge Balance",
      'retry': {'enabled': true, 'max_count': 100},
      'send_sms_hash': true,
      'prefill': {'contact': '$mobile',
        'email': '$email'},
      // 'external': {
      //   'wallets': ['paytm']
      // }
    };

    try {
      _razorpay.open(

          options);
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








