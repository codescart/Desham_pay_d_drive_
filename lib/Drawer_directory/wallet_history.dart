import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mp_pay/app_constant.dart';
import 'package:mp_pay/curved_painty.dart';
import 'package:http/http.dart' as http;
import 'package:mp_pay/wigets/back_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Wallet_history_page extends StatefulWidget {
  const Wallet_history_page({Key? key}) : super(key: key);

  @override
  State<Wallet_history_page> createState() => _Wallet_history_pageState();
}

class _Wallet_history_pageState extends State<Wallet_history_page> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        appBar: AppBar(
          backgroundColor: kBackgroundColor,
          leading: back(),
          title: Text(
            "WALLET HISTORY",
            style: TextStyle(
              fontFamily: "Windsor",
              color: kTextLowBlackColor,
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
         body:
         FutureBuilder<List<AddM>>(
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
                     padding: const EdgeInsets.all(2.0),
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
                               // boxShadow: [
                               //   BoxShadow(
                               //     color: Colors.black,
                               //     offset: const Offset(
                               //       5.0,
                               //       5.0,
                               //     ), //Offset
                               //     blurRadius: 10.0,
                               //     spreadRadius: 2.0,
                               //   ), //BoxShadow
                               //   BoxShadow(
                               //     color: Colors.white,
                               //     offset: const Offset(0.0, 0.0),
                               //     blurRadius: 0.0,
                               //     spreadRadius: 0.0,
                               //   ), //BoxShadow
                               // ],
                             ),
                             child: ListTile(
                               leading: Column(
                                 children: [
                                   Text('Amount',textAlign: TextAlign.center,
                                       style: TextStyle(fontFamily: "Windsor",fontWeight: FontWeight.bold,fontSize: 15,)),

                                    Text('₹ '+'${snapshot.data![index].amount}',textAlign: TextAlign.center,
                                        style: TextStyle(fontFamily: "Windsor",fontWeight: FontWeight.bold,fontSize: 12,)),
                                   Container(

                                     padding: EdgeInsets.all(2),
                                     decoration: BoxDecoration(
                                       color: snapshot.data![index].status=='success'?Colors.green:

                                       snapshot.data![index].status=='failed'?Colors.red:Colors.yellow,
                                       borderRadius: BorderRadius.circular(6),
                                     ),

                                     child: Text('${snapshot.data![index].status}',textAlign: TextAlign.center,
                                         style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,
                                           color: Colors.white,


                                         )),
                                   ),

                                 ],
                               ),
                               title: Text('DATE : '+'${snapshot.data![index].paydate}',textAlign: TextAlign.center,
                                   style: TextStyle(fontFamily: "Windsor",fontWeight: FontWeight.bold,fontSize: 15,)),
                               // trailing: Column(
                               //   children: [
                               //     Text('Main Bal',textAlign: TextAlign.center),
                               //     Text('${snapshot.data![index].balance}'.toStringAsFixed(3);,textAlign: TextAlign.center,
                               //       style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                               //   ],
                               // ),
                               subtitle: Padding(
                                 padding: const EdgeInsets.only(top: 18.0),
                                 child: Column(

                                   children: [
                                     // Text('Balance : '+balraj, ),
                                     Text('Shop Name: '+'${snapshot.data![index].shopname}',
                                         style: TextStyle(fontFamily: "Windsor",fontWeight: FontWeight.bold,fontSize: 15,)),

                                     Text('Payment Mod: '+'${snapshot.data![index].paymode}',
                                         style: TextStyle(fontFamily: "Windsor",fontWeight: FontWeight.bold,fontSize: 15,)),
                                     // Text('${snapshot.data![index].updated_at}'),
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
                   Text('No data found',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                 ],
               ),);
             }
         ),
      ),
    );
  }
  Future<List<AddM>> add() async{
    final prefs = await SharedPreferences.getInstance();
    final key = 'user_id';
    final value = prefs.getInt(key) ?? "0";
    final prefs2 = await SharedPreferences.getInstance();
    final key2 = 'apptoken';
    final value2 = prefs2.getString(key2) ?? "0";
    final response = await http.post(
      Uri.parse(Apiconst.baseurl+'android/transaction?'+"apptoken=$value2&user_id=$value&type=fundrequest"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },

    );
    print(Apiconst.baseurl+'android/transaction?'+"apptoken=$value2&user_id=$value&type=fundrequest");
    var jsond = json.decode(response.body)["data"];

    print(jsond);
    print('jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj');
    // setState(() {
    //   balraj = jsond['balance'].toStringAsFixed(3);
    // });
    List<AddM> allround = [];
    for (var o in jsond)  {
      AddM al = AddM(
        o["type"],
        o["paymode"],
        o["amount"],
        o["paydate"],
        o["status"],
        o['user']["shopname"],
      );



      allround.add(al);
    }
    return allround;
  }
}



class AddM {
  String type;
  String paymode;
  int amount;
  String paydate;
  String status;
  String shopname;



  AddM(
      this.type,
      this.paymode,
      this.amount,
      this.paydate,
      this.status,
      this.shopname
      );
}