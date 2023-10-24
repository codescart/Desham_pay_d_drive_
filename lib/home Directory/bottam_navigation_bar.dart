import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mp_pay/1_home_page/wallet.dart';
import 'package:mp_pay/app_constant.dart';
import 'package:mp_pay/home%20Directory/help.dart';
import 'package:mp_pay/home%20Directory/profile.dart';
import 'package:mp_pay/home%20Directory/report.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Timer? timer;
  void initState() {

    timer = Timer.periodic(Duration(seconds: 4), (Timer t) =>leader());
    // TODO: implement initState
    super.initState();
  }

  int pageIndex = 0;

  final pages = [
    const home(),
     report_page(),
    const help_page(),
    const profile_page(),
  ];

  @override
  Widget build(BuildContext context ) {
    return Scaffold(
      backgroundColor:kBackgroundColor,
      appBar: AppBar(

        toolbarHeight: 70,
        // leading:  Image.asset(
        //   'assets/logo.png',
        //   height: 50,
        // ),
        title: Image.asset(
          'assets/logo.png',
          height: 60,
        ),
        // title: Text(
        //   "DESHAM Pay",
        //   style: TextStyle(
        //     color: kTextLowBlackColor,
        //     fontSize: 25,
        //     fontWeight: FontWeight.w600,
        //   ),
        // ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(

              decoration: BoxDecoration(
                color: kTextLowBlackColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                         Navigator.push(context, MaterialPageRoute(builder: (context)=> Wallet()));
                      },
                      child: Container(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                 map==null?Text(''):
                                 Text(
                                  map['mainwallet'] == ''?
                                 '\u{20B9}'+'0' : '\u{20B9}'+map['mainwallet'].toString(),
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: "Windsor",
                                    fontWeight: FontWeight.w400,
                                  ),
                                 ),
                                Icon(
                                  Icons.account_balance_wallet_outlined,
                                  size: 18,
                                )
                              ],
                            ),
                            Text(
                              'Wallet',
                              style: TextStyle(
                                fontSize: 10,
                                fontFamily: "Windsor",
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: pages[pageIndex],
      bottomNavigationBar: buildMyNavBar(context),
    );
  }

  Container buildMyNavBar(BuildContext context) {
    return Container(
      height: 65,
      decoration: BoxDecoration(
        color: kTextLowBlackColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  setState(() {
                    pageIndex = 0;
                  });
                },
                icon: pageIndex == 0
                    ? const Icon(
                  Icons.home_filled,
                  color: Colors.white,
                  size: 35,
                )
                    : const Icon(
                  Icons.home_outlined,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              Text('Home', style: TextStyle(fontFamily: "Windsor",
                color: Colors.white,fontWeight: FontWeight.bold
              ),),
            ],
          ),
          Column(
            children: [
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  setState(() {
                    pageIndex = 1;
                  });
                },

                icon: pageIndex == 1
                    ? const Icon(
                  Icons.note_add,
                  color: Colors.white,
                  size: 35,
                )
                    : const Icon(
                  Icons.note_add_outlined,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              Text('Report', style: TextStyle(fontFamily: "Windsor",
                  color: Colors.white,fontWeight: FontWeight.bold
              ),),
            ],
          ),
          Column(
            children: [
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  setState(() {
                    pageIndex = 2;
                  });
                },
                icon: pageIndex == 2
                    ? const Icon(
                  Icons.widgets_rounded,
                  color: Colors.white,
                  size: 35,
                )
                    : Image.asset('assets/helpcenter_light.png',
                  height: 35,width: 35,color: Colors.white,),
              ),
              Text('Support', style: TextStyle(fontFamily: "Windsor",
                  color: Colors.white,fontWeight: FontWeight.bold
              ),),
            ],
          ),
          Column(
            children: [
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  setState(() {
                    pageIndex = 3;
                  });
                },
                icon: pageIndex == 3
                    ? const Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 35,

                )
                    : const Icon(
                  Icons.person_outline,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              Text('Profile', style: TextStyle(fontFamily: "Windsor",
                  color: Colors.white,fontWeight: FontWeight.bold
              ),),
            ],
          ),
        ],
      ),
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
    if (data['status'] == 'TXN') {
      setState(() {
        map=data['data'];
      });
    }
  }
}


