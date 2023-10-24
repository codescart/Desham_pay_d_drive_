import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mp_pay/agentComminition.dart';
import 'package:mp_pay/app_constant.dart';
import 'package:mp_pay/curved_painty.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Recharge_history extends StatefulWidget {
  const Recharge_history({Key? key}) : super(key: key);

  @override
  State<Recharge_history> createState() => _Recharge_historyState();
}

class _Recharge_historyState extends State<Recharge_history> {

  @override
  void initState() {
    rstatus();
    // TODO: implement initState
    super.initState();
  }
  var datasl;
  rstatus() async{
    final prefs = await SharedPreferences.getInstance();
    final key = 'role';
    final value = prefs.getInt(key) ?? "0";

    setState(() {
      datasl=value;
    });
    print(value);
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          datasl==2?
          ElevatedButton.icon(
            icon: Icon(Icons.person, color: Colors.white ),
            label:Text('Agent Commission',textAlign: TextAlign.center,
                style: TextStyle(fontFamily: "Windsor",fontWeight: FontWeight.bold,fontSize: 12,
                  color: Colors.white,


                )),
            onPressed: (){
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      agent_comminition(type:'md'),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              side: BorderSide(color: Colors.black45,
                  width: 1),
              primary: Colors.redAccent,
              onPrimary: Colors.black,
              shadowColor: Colors.red,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ):datasl==3?ElevatedButton.icon(
            icon: Icon(Icons.person, color: Colors.white ),
            label:Text('Agent Commission',textAlign: TextAlign.center,
                style: TextStyle(fontFamily: "Windsor",fontWeight: FontWeight.bold,fontSize: 12,
                  color: Colors.white,


                )),
            onPressed: (){
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      agent_comminition(type:'dis'),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              side: BorderSide(color: Colors.black45,
                  width: 1),
              primary: Colors.redAccent,
              onPrimary: Colors.black,
              shadowColor: Colors.red,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ):
          Container(),


          FutureBuilder<List<AddM>>(
              future: add(),
              builder: (context, snapshot) {
                if (snapshot.hasError) print(snapshot.error);

                return snapshot.hasData
                    ? ListView.builder(
                  physics: BouncingScrollPhysics(),
                 // scrollDirection: Axis.vertical,
                  itemCount: snapshot.data!.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Column(
                        children: [
                          Container(

                              height: 120,
                              width: 360,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: kTabBarBg,
                                  width: 4,
                                ), //Border.all
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child:Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [

                                        Text('Amount',textAlign: TextAlign.center, style: TextStyle(fontFamily: "Windsor",),),

                                        Text('₹ '+'${snapshot.data![index].amount}',textAlign: TextAlign.center,
                                            style: TextStyle(fontFamily: "Windsor",fontWeight: FontWeight.bold,fontSize: 15,)),
                                        Container(

                                          padding: EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                            color: snapshot.data![index].profit=='success'?Colors.green:

                                            snapshot.data![index].profit=='failed'?Colors.red:Colors.yellow,
                                            borderRadius: BorderRadius.circular(6),
                                          ),

                                          child: Text('${snapshot.data![index].profit}',textAlign: TextAlign.center,
                                              style: TextStyle(fontFamily: "Windsor",fontWeight: FontWeight.bold,fontSize: 12,
                                                color: Colors.white,


                                              )),
                                        ),

                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text('${snapshot.data![index].number}',
                                            style: TextStyle(fontFamily: "Windsor",fontWeight: FontWeight.bold,fontSize: 15)),
                                        Padding(
                                          padding: const EdgeInsets.only(),
                                          child: Text('${snapshot.data![index].provider_id}',
                                              style: TextStyle(fontFamily: "Windsor",fontWeight: FontWeight.bold,fontSize: 15)),
                                        ),
                                        SizedBox(height: 10,),
                                        Flexible(child: Text('TXN ID: '+'${snapshot.data![index].txnid}',textAlign: TextAlign.justify,style: TextStyle(fontSize: 12),)),
                                        Flexible(child: Text('${snapshot.data![index].updated_at}',textAlign: TextAlign.justify,style: TextStyle(fontSize: 12),),
                                        )

                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text('MainBalance: ',textAlign: TextAlign.center,
                                          style: TextStyle(fontFamily: "Windsor",fontWeight: FontWeight.bold,fontSize: 10),),

                                        Text('${snapshot.data![index].balance}',textAlign: TextAlign.center,
                                          style: TextStyle(fontFamily: "Windsor",fontWeight: FontWeight.bold,fontSize: 15),),
                                        SizedBox(height: 10,),
                                        Text('Profit: '+'${snapshot.data![index].status}',textAlign: TextAlign.center,
                                          style: TextStyle(fontFamily: "Windsor",fontWeight: FontWeight.bold,fontSize: 12),),
                                        SizedBox(
                                          height: 15,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
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
        ],
      ),
    );
  }
  // var balraj;
  Future<List<AddM>> add() async{
    final prefs = await SharedPreferences.getInstance();
    final key = 'user_id';
    final value = prefs.getInt(key) ?? "0";
    final prefs2 = await SharedPreferences.getInstance();
    final key2 = 'apptoken';
    final value2 = prefs2.getString(key2) ?? "0";
    final response = await http.post(
      Uri.parse(Apiconst.baseurl+'get_transaction.php?'+"apptoken=$value2&user_id=$value&type=recharge"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },

    );
    print(Apiconst.baseurl+'get_transaction.php?'+"apptoken=$value2&user_id=$value&type=recharge");
    var jsond = json.decode(response.body)["data"];

    print(jsond);
    print('hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh');
    // setState(() {
    //   balraj = jsond['balance'].toStringAsFixed(3);
    // });
    List<AddM> allround = [];
    for (var o in jsond)  {
      AddM al = AddM(
        o["number"],
        o["amount"],
         o["balance"],
        o["provider_id"],
        o["updated_at"],
        o["txnid"],
        o["id"],
        o["status"],
        o["profit"],
      );



      allround.add(al);
    }
    return allround;
  }
}



class AddM {
  String number;
  String amount;
  String balance;
  String provider_id;
  String updated_at;
  String txnid;
  String id;
  String profit;
  String status;



  AddM(
      this.number,
      this.amount,
       this.balance,
      this.provider_id,
      this.updated_at,
      this.txnid,
      this.id,
      this.profit,
      this.status,
      );
}