import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mp_pay/app_constant.dart';
import 'package:mp_pay/curved_painty.dart';
import 'package:http/http.dart' as http;
import 'package:mp_pay/wigets/back_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class agent_comminition extends StatefulWidget {
  final String type;
   agent_comminition({Key? key, required this.type}) : super(key: key);

  @override
  State<agent_comminition> createState() => _agent_comminitionState();
}

class _agent_comminitionState extends State<agent_comminition> {
  void initState() {

    super.initState();
    Future<void> _selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(2015, 8),
          lastDate: DateTime(2101));
      if (picked != null && picked != selectedDate) {
        setState(() {
          selectedDate = picked;
        });
      }
    }
    Future<void> _selecteeDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selecteeedDate,
          firstDate: DateTime(2015, 8),
          lastDate: DateTime(2101));
      if (picked != null && picked != selecteeedDate) {
        setState(() {
          selecteeedDate = picked;
        });
      }
    }
  }

  DateTime selectedDate = DateTime.now();
  DateTime selecteeedDate = DateTime.now();
  final TextEditingController date = TextEditingController();
  final TextEditingController dateee = TextEditingController();
  InputDecoration getInputDecoration(String hintext, IconData iconData) {
    return InputDecoration(
      counter: Offstage(),

      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        borderSide: BorderSide(color: Colors.white, width: 2),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        borderSide: BorderSide(color: Colors.white, width: 2),
      ),
      border: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        borderSide: BorderSide(color: Color(0xFFF65054)),
      ),
      errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        borderSide: BorderSide(color: Color(0xFFF65054)),
      ),
      filled: true,
      prefixIcon: Icon(
        iconData,
        // color: kTextLowBlackColor,
      ),
      hintStyle: const TextStyle(color: Colors.black54, fontSize: 14),
      hintText: hintext,
      // fillColor: kBackgroundColor,
      contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).cardColor,
        appBar: AppBar(
          backgroundColor: kBackgroundColor,
          leading: back(),
          title: Text(
            "Agent Commission",
            style: TextStyle(
              fontFamily: "Windsor",
              color: kTextLowBlackColor,
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        body:SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 25,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 160,
                    child: TextFormField(
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickeddate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101))
                            .then((pickeddate) {
                          if (pickeddate != null) {
                            setState(() {
                              selectedDate = pickeddate;
                              date.text =
                              "${selectedDate.toLocal()}".split(' ')[0];
                            });
                          }
                          return null;
                        });
                      },
                      controller: date,
                      // keyboardType: TextInputType.number,
                      style: const TextStyle(fontSize: 14),
                      decoration: getInputDecoration(
                        'Date',
                        Icons.calendar_today_outlined,
                      ),
                    ),
                  ),
                  Text('TO'),
                  Container(
                    width: 160,
                    child: TextFormField(
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickeddate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2022),
                            lastDate: DateTime(2101))
                            .then((pickeddate) {
                          if (pickeddate != null) {
                            setState(() {
                              selecteeedDate = pickeddate;
                              print(pickeddate);
                              dateee.text =
                              "${selecteeedDate.toLocal()}".split(' ')[0];
                              fid=date.text;
                              tid=dateee.text;
                            });
                          }
                          return null;
                        });
                        add();
                      },
                      controller: dateee,
                      // keyboardType: TextInputType.number,
                      style: const TextStyle(fontSize: 14),
                      decoration: getInputDecoration(
                        'Date',
                        Icons.calendar_today_outlined,
                      ),
                    ),
                  ),

                ],
              ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset('assets/chart.gif',
                      height: 25,width: 30,),
                    Text('Total Profit : '+fsond,textAlign: TextAlign.center,
                        style: TextStyle(fontFamily: "Windsor",fontWeight: FontWeight.bold,fontSize: 15,)),
                  ],
                ),
                SizedBox(height: 20,),
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
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Flexible(
                                              child: Text('Name: '+'${snapshot.data![index].name}',textAlign: TextAlign.center,
                                                  style: TextStyle(fontFamily: "Windsor",fontWeight: FontWeight.bold,fontSize: 15,)),
                                            ),
                                            Text('Number:'+'${snapshot.data![index].phone}',
                                                style: TextStyle(fontFamily: "Windsor",fontWeight: FontWeight.bold,fontSize: 15)),

                                            SizedBox(height: 10,),
                                            Flexible(child: Text('TXN ID: '+'${snapshot.data![index].txnid}',textAlign: TextAlign.justify,style: TextStyle(fontSize: 12),)),
                                            Flexible(child: Text('${snapshot.data![index].updated_at}',textAlign: TextAlign.justify,style: TextStyle(fontSize: 12),),
                                            )

                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text('Amount: ',textAlign: TextAlign.center,
                                              style: TextStyle(fontFamily: "Windsor",fontWeight: FontWeight.bold,fontSize: 10),),

                                            Text('${snapshot.data![index].amount}',textAlign: TextAlign.center,
                                              style: TextStyle(fontFamily: "Windsor",fontWeight: FontWeight.bold,fontSize: 15),),
                                            SizedBox(height: 10,),


                                            Text('Profit: '+'${snapshot.data![index].profit}' !=null?'${snapshot.data![index].profit}':'${snapshot.data![index].disprofit}',textAlign: TextAlign.center,
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
        )
      ),
    );
  }
  var tid;
  var fid;
  var fsond= '00';
  var jsond;
  Future<List<AddM>> add() async{
    final prefs = await SharedPreferences.getInstance();
    final key = 'user_id';
    final value = prefs.getInt(key) ?? "0";

    final response =
    widget.type!= 'md'?
    fid ==null?

    await http.post(
      Uri.parse(Apiconst.baseurl+'getbonusby_disid.php?md_id=$value'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    ):
    await http.post(
      Uri.parse(Apiconst.baseurl+'getbonusby_disid.php?md_id=$value&from_date=$fid&to_date=$tid'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    )

        :

    fid ==null?

    await http.post(
      Uri.parse(Apiconst.baseurl+'getbonus.php?md_id=$value'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    ):
    await http.post(
      Uri.parse(Apiconst.baseurl+'getbonus.php?md_id=$value&from_date=$fid&to_date=$tid'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print('gggggggggggggggg');
    print(Apiconst.baseurl+'getbonus.php?md_id=$value&from_date=$fid&to_date=$tid');

   var jd=json.decode(response.body);
    var jsond = jd["data"];
    setState(() {
      fsond = jd['Total_profit'];
    });
     print('ddddddddddddddd');
    print(fsond);
    List<AddM> allround = [];
    for (var o in jsond)  {
      AddM al = AddM(
        o["name"],
        o["phone"],
          o["disprofit"],
        o["mdprofit"],
        o["txnid"],
        o["amount"],
        o["updated_at"]
      );
      allround.add(al);
    }
    return allround;
  }
}



class AddM {
  String name;
  String phone;
  String disprofit;
  String profit;
  String txnid;
  String amount;
  String updated_at;




  AddM(
      this.name,
      this.phone,
     this.disprofit,
      this.profit,
      this.txnid,
      this.amount,
      this.updated_at,

      );
}