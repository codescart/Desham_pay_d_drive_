import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mp_pay/1_home_page/add_money.dart';
import 'package:mp_pay/Drawer_directory/wallet_history.dart';
import 'package:mp_pay/app_constant.dart';
import 'package:mp_pay/curved_painty.dart';
import 'package:mp_pay/wigets/back_button.dart';
import 'package:mp_pay/wigets/custom%20button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Wallet extends StatefulWidget {
  const Wallet({Key? key}) : super(key: key);

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {

  void initState() {
    leader();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kBackgroundColor,
          leading: back(),
          title: Text(
            "WALLET",
            style: TextStyle(
                            fontFamily: "Windsor",
              color: kTextLowBlackColor,
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
         body:   Container(
          child:  CustomPaint(
           painter: SplashPainter(),
           child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 50,),
                Center(
                  child: Container(
                    // width: width,
                    // height: 120.h,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: kTabBarBg,
                        width: 4,
                      ), //Border.all
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'My Money',

                              style:
                              TextStyle(
                                fontSize: 30,
                                fontFamily: "Windsor",
                                fontWeight: FontWeight.w700,
                                color:kTextLightColor,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Positioned(
                                  top: 7.5,
                                  left: -15,
                                  child: Text(
                                    '',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1!
                                        .copyWith(
                                      fontSize: 36,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                map==null?Text(''):
                                Text(
                                  map['mainwallet'] == ''?
                                  '\u{20B9}'+'0' : '\u{20B9}'+map['mainwallet'].toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1!
                                      .copyWith(
                                    fontSize: 36,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),

                              ],
                            ),
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
                SizedBox(height: 25,),
                SizedBox(height: 25,),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        child: ButtonTheme(
                          height: 40,
                          minWidth: 150,
                          child: RaisedButton(
                            color:kRedColor,
                            child: Text("WALLET HISTORY"),
                            onPressed: () {
                               Navigator.push(context, MaterialPageRoute(builder: (context)=>Wallet_history_page()));
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),),
                        ),
                      ),
                      Container(
                        child: ButtonTheme(
                          height: 40,
                          minWidth: 150,
                          child: RaisedButton(
                            color:kRedColor,
                            child: Text("ADD CASH"),
                            onPressed: () {
                               Navigator.push(context, MaterialPageRoute(builder: (context)=>pay()));
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25,),

              ],
            ),
          ),
        ),
      ),
      )
    );
  }
  var map;
  Future leader() async{
    final prefs = await SharedPreferences.getInstance();
    final key = 'user_id';
    final value = prefs.getInt(key) ?? "0";
    final prefs2 = await SharedPreferences.getInstance();
    final key2 = 'apptoken';
    final value2 = prefs2.getString(key2) ?? "0";
    print(Apiconst.baseurl+'android/getbalance?user_id=$value&apptoken=$value2');
    final response = await http.post(
      Uri.parse(Apiconst.baseurl+'android/getbalance?user_id=$value&apptoken=$value2'),

      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{

        "user_id":"$value"
      }),
    );
    var data = jsonDecode(response.body);
    print(data);
    print('llllllllllllll');
    if (data['status'] == 'TXN') {
      setState(() {
        map=data['data'];
      });
    }
  }
}
