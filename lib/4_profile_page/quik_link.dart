import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mp_pay/4_profile_page/fund_transfer.dart';
import 'package:mp_pay/4_profile_page/privacy_Policy.dart';
import 'package:mp_pay/4_profile_page/t&c.dart';
import 'package:mp_pay/app_constant.dart';
import 'package:mp_pay/curved_painty.dart';
import 'package:mp_pay/wigets/back_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class quik extends StatefulWidget {
  const quik({Key? key}) : super(key: key);

  @override
  State<quik> createState() => _quikState();
}

class _quikState extends State<quik> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
    Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        leading: back(),
        title: Text(
          "",
           style: TextStyle(
            fontFamily: "Windsor",
            color: kTextLowBlackColor,
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child:  CustomPaint(
            painter: SplashPainter(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 14.0,bottom: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap:(){
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>  Fund(),
                            ),
                          );
                        },
                        child: Container(
                          height: 90,width: 90,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: kTabBarBg,
                              width: 4,
                            ), //Border.all
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: iCardColor,
                                offset: const Offset(0.0, 0.0),
                                blurRadius: 0.0,
                                spreadRadius: 0.0,
                              ), //BoxShadow
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Image.asset('assets/fund_transfer.png',
                                    height: 40,width: 40,color:kTextLowBlackColor ,),
                                ),
                              ),
                              SizedBox(height: 5,),
                              Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Text('Fund Transfer', style: TextStyle(fontFamily: "Windsor",fontSize: 11,fontWeight: FontWeight.bold))),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>  TermCondition(),
                            ),
                          );
                        },
                        child: Container(
                          height: 90,width: 90,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: kTabBarBg,
                              width: 4,
                            ), //Border.all
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: iCardColor,
                                offset: const Offset(0.0, 0.0),
                                blurRadius: 0.0,
                                spreadRadius: 0.0,
                              ), //BoxShadow
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Image.asset('assets/t&c.png',
                                    height: 40,width: 40,color:kTextLowBlackColor ,),
                                ),
                              ),
                              SizedBox(height: 5,),
                              Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Text('T & C', style: TextStyle(fontFamily: "Windsor",fontSize: 11,fontWeight: FontWeight.bold))),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>  Privacy(),
                            ),
                          );
                        },
                        child: Container(
                          height: 90,width: 90,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: kTabBarBg,
                              width: 4,
                            ), //Border.all
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: iCardColor,
                                offset: const Offset(0.0, 0.0),
                                blurRadius: 0.0,
                                spreadRadius: 0.0,
                              ), //BoxShadow
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Image.asset('assets/privacy_policy.png',
                                    height: 40,width: 40,color:kTextLowBlackColor ,),
                                ),
                              ),
                              SizedBox(height: 5,),
                              Align(

                                  alignment: Alignment.bottomCenter,
                                  child: Text('Privacy Policy', style: TextStyle(fontFamily: "Windsor",fontSize: 11,fontWeight: FontWeight.bold))),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 2,
                ),
        Container(
          height: MediaQuery.of(context).size.height*0.74,
          child: FutureBuilder<List<AddM>>(
              future: add(),
              builder: (context, snapshot) {
                if (snapshot.hasError) print(snapshot.error);

                return snapshot.hasData
                    ? ListView.builder(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data!.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                              height: 120,width: 360,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: kTabBarBg,
                                  width: 4,
                                ), //Border.all
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black,
                                    offset: const Offset(
                                      5.0,
                                      5.0,
                                    ), //Offset
                                    blurRadius: 10.0,
                                    spreadRadius: 2.0,
                                  ), //BoxShadow
                                  BoxShadow(
                                    color: Colors.white,
                                    offset: const Offset(0.0, 0.0),
                                    blurRadius: 0.0,
                                    spreadRadius: 0.0,
                                  ), //BoxShadow
                                ],
                              ),
                              child: ListTile(
                                leading: Column(
                                  children: [
                                    Icon(Icons.account_balance, size:30),
                                    Text('${snapshot.data![index].status}',textAlign: TextAlign.center,),
                                  ],
                                ),
                                title: Text('${snapshot.data![index].shopname}',textAlign: TextAlign.center,),
                                trailing: Column(
                                  children: [
                                    Text('Main Bal',textAlign: TextAlign.center),
                                    Text('${snapshot.data![index].mainwallet}',textAlign: TextAlign.center,
                                       style: TextStyle(fontFamily: "Windsor",fontWeight: FontWeight.bold,fontSize: 15),),
                                  ],
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 18.0),
                                  child: Column(

                                    children: [
                                      Text('${snapshot.data![index].mobile}',),
                                      Text('${snapshot.data![index].email}'),
                                    ],
                                  ),
                                ),
                              )
                          ),
                        ],
                      ),
                    );
                  },
                ):Center(child:Column(
                  children: [
                    Container(
                      child:
                      Image.asset(
                        'assets/no_data.gif',

                      ),
                    ),
                    Text('No data found', style: TextStyle(fontFamily: "Windsor",fontSize: 25,fontWeight: FontWeight.bold),),
                  ],
                ),);
              }
          ),
        ),
              ],
            ),
          )

      ),
    )
    );
  }

}
Future<List<AddM>> add() async{
  final prefs = await SharedPreferences.getInstance();
  final key = 'user_id';
  final value = prefs.getInt(key) ?? "0";

  final response = await http.post(
    Uri.parse(Apiconst.baseurl2+'api/roloelist_api.php?id=$value'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },


  );
  print(Apiconst.baseurl2+'api/roloelist_api.php?id=$value');
  var jsond = json.decode(response.body)["data"];
  print(jsond);
  print('pppppppppppppppppppppp');
  List<AddM> allround = [];
  for (var o in jsond)  {
    AddM al = AddM(
      o["name"],
      o["email"],
      o["mobile"],
      o["mainwallet"],
       o["balance"],
      o["status"],
      o["shopname"],
    );



    allround.add(al);
  }
  return allround;
}
class AddM {
  String name;
  String email;
  String mobile;
  String mainwallet;
  String balance;
  String status;
  String shopname;



  AddM(
      this.name,
      this.email,
      this.mobile,
      this.mainwallet,
       this.balance,
      this.status,
      this.shopname,
      );
}