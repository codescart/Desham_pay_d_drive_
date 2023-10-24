import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mp_pay/app_constant.dart';
import 'package:mp_pay/curved_painty.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class dmt_history extends StatefulWidget {
  const dmt_history({Key? key}) : super(key: key);

  @override
  State<dmt_history> createState() => _dmt_historyState();
}

class _dmt_historyState extends State<dmt_history> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<AddM>>(
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
                        height: 100,width: 360,
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
                              Text('Amount',textAlign: TextAlign.center,),

                              Text('${snapshot.data![index].amount}',textAlign: TextAlign.center,
                                                                                                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,)),
                              Text('success',textAlign: TextAlign.center,
                                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.green)),
                                                                                                    ],
                                                                                                  ),
                          title: Text('${snapshot.data![index].id}',textAlign: TextAlign.center,),
                          trailing: Column(
                            children: [Text('Main Bal',textAlign: TextAlign.center),
                              Text('${snapshot.data![index].status}',textAlign: TextAlign.center,
                                                                                                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                                                                                                    ],
                                                                                                  ),
                          subtitle: Padding(
                                                                                                    padding: const EdgeInsets.only(top: 18.0),
                            child: Column(

                              children: [Text('${snapshot.data![index].amount}',),
                                Text('${snapshot.data![index].updated_at}'),
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
                  height: 500,
                ),
              ),
              Text('No data found',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
            ],
          ),);
        }
    );
  }
}



Future<List<AddM>> add() async{
  final prefs = await SharedPreferences.getInstance();
  final key = 'user_id';
  final value = prefs.getInt(key) ?? "0";
  final prefs2 = await SharedPreferences.getInstance();
  final key2 = 'apptoken';
  final value2 = prefs2.getString(key2) ?? "0";
  final response = await http.post(
    Uri.parse(Apiconst.baseurl2+'api/fundlisttt.php?user_id=4'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    // body: jsonEncode(<String, String>{
    //   "user_id":"$valu"
    // }),

  );
  print("https://deshampay.co.in/api/fundlist.php?user_id=4");
  var jsond = json.decode(response.body)["data"];
  print(jsond);
  print('pppppppppppppppppppppp');
  List<AddM> allround = [];
  for (var o in jsond)  {
    AddM al = AddM(
      o["paymode"],
      o["amount"],
      o["credited_to"],
      o["usermo"],
      o["updated_at"],
      o["status"],
      o["id"],
    );



    allround.add(al);
  }
  return allround;
}
class AddM {
  String paymode;
  String amount;
  String credited_to;
  String usermo;
  String updated_at;
  String status;
  String id;



  AddM(
      this.paymode,
      this.amount,
      this.credited_to,
      this.updated_at,
      this.status,
      this.usermo,
      this.id,
      );
}