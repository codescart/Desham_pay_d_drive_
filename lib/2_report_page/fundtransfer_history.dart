import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mp_pay/app_constant.dart';
import 'package:mp_pay/curved_painty.dart';
import 'package:http/http.dart' as http;
import 'package:mp_pay/wigets/back_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
//import 'package:syncfusion_flutter_datepicker/datepicker.dart';



class fund_transfer extends StatefulWidget {
  const fund_transfer({Key? key}) : super(key: key);

  @override
  State<fund_transfer> createState() => _fund_transferState();
}


const List<Widget> fruits = <Widget>[
  Text('Send'),
  Text('Recieved'),
];


class _fund_transferState extends State<fund_transfer> {
  bool pj= false;
  var datasl;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:
        SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  InkWell(
                    onTap: (){

                      setState(() {
                        pj=false;
                      });
                      wert();
                    },
                    child: Container(
                      height: 40,width: 100,
                      decoration: BoxDecoration(
                        color: pj==false? Colors.redAccent:Colors.white,

                        border: Border.all(
                          color: kTabBarBg,
                          width: 4,
                        ),
                        borderRadius:
                        BorderRadius.only(
                          topLeft:
                          Radius.circular(15),
                          bottomLeft:
                          Radius.circular(15),
                        ),
                      ),
                      child: Center(child: Text('SEND',style: TextStyle(fontWeight: FontWeight.bold),)),
                    ),
                  ),
                  InkWell(
                    onTap: (){

                      setState(() {
                        pj=true;
                      });
                      wert();
                    },
                    child: Container(
                      height: 40,width: 100,
                      decoration: BoxDecoration(
                        color: pj==true? Colors.redAccent:Colors.white,

                        border: Border.all(
                          color: kTabBarBg,
                          width: 4,
                        ),
                            borderRadius:
                          BorderRadius.only(
                          topRight:
                          Radius.circular(15),
                      bottomRight:
                      Radius.circular(15),
                    ),
                      ),
                      child: Center(child: Text('RECIEVE',style: TextStyle(fontWeight: FontWeight.bold),)),
                    ),
                  ),
                ],
              ),

              FutureBuilder<List<AddM>>(
                  future: wert(),
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
                                    title: Text('NAME : '+'${snapshot.data![index].credited_to}',textAlign: TextAlign.center,
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
                                          Text('Number: '+'${snapshot.data![index].usermo}',
                                              style: TextStyle(fontFamily: "Windsor",fontWeight: FontWeight.bold,fontSize: 15,)),

                                          Text('Payment Mod: '+'${snapshot.data![index].paymode}',
                                              style: TextStyle(fontFamily: "Windsor",fontWeight: FontWeight.bold,fontSize: 15,)),
                                          Text('Date : '+'${snapshot.data![index].updated_at}',
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
            ],
          ),
        ),
      ),
    );
  }
  // var balraj;
  Future<List<AddM>> wert() async{
    var rj;
    pj==true? rj="recive.php":rj="send.php";

    final prefs = await SharedPreferences.getInstance();
    final key = 'user_id';
    final value = prefs.getInt(key) ?? "0";
    print('ddddddddd');

    print(Apiconst.baseurl+'fundhistory_$rj?id=$value');
    final response = await http.post(
      Uri.parse(Apiconst.baseurl+'fundhistory_$rj?id=$value'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },

    );
    //0print(Apiconst.baseurl2+'api/fundlist.php?user_id=4');
    var jsond = json.decode(response.body)["data"];

    print(jsond);
    print('rrrrrrrrrrrrrrrrrr');
     List<AddM> allround = [];
    for (var o in jsond)  {
      AddM al = AddM(
        o["paymode"],
        o["amount"],
        o["status"],
        o["updated_at"],
        o["name"],
        o["mobile"],
        o["type"],
      );



      allround.add(al);
    }
    return allround;
  }
}



class AddM {
  String paymode;
  String amount;
  String status;
  String updated_at;
  String credited_to;
  String usermo;
  String type;



  AddM(
      this.paymode,
      this.amount,
      this.status,
      this.updated_at,
      this.credited_to,
      this.usermo,
      this.type,
      );
}

