import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mp_pay/app_constant.dart';
import 'package:mp_pay/curved_painty.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DTHrechargehistory extends StatefulWidget {
  const DTHrechargehistory({Key? key}) : super(key: key);

  @override
  State<DTHrechargehistory> createState() => _DTHrechargehistoryState();
}

class _DTHrechargehistoryState extends State<DTHrechargehistory> {
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
                          title: Text('${snapshot.data![index].number}',textAlign: TextAlign.center,),
                          trailing: Column(
                            children: [
                              Text('Main Bal',textAlign: TextAlign.center),
                              Text('${snapshot.data![index].balance}',textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                            ],
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 18.0),
                            child: Column(

                              children: [
                                Text('${snapshot.data![index].txnid}',),
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
    Uri.parse(Apiconst.baseurl+'android/transaction?'+"apptoken=$value2&user_id=$value&type=rechargestatement"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    // body: jsonEncode(<String, String>{
    //   "user_id":"$valu"
    // }),

  );
  print(Apiconst.baseurl+'android/transaction?'+"apptoken=$value2&user_id=$value&type=rechargestatement");
  var jsond = json.decode(response.body)["data"];
  print(jsond);
  print('pppppppppppppppppppppp');
  List<AddM> allround = [];
  for (var o in jsond)  {
    AddM al = AddM(
      o["number"],
      o["amount"],
      o["providername"],
      o["updated_at"],
      o["balance"],
      o["txnid"],
      o["id"],
    );



    allround.add(al);
  }
  return allround;
}
class AddM {
  String number;
  int amount;
  String providername;
  String updated_at;
  double balance;
  String txnid;
  int id;



  AddM(
      this.number,
      this.amount,
      this.providername,
      this.updated_at,
      this.balance,
      this.txnid,
      this.id,
      );
}