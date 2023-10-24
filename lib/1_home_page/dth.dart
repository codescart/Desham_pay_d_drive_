import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mp_pay/1_home_page/wallet.dart';
import 'package:mp_pay/app_constant.dart';
import 'package:mp_pay/curved_painty.dart';
import 'package:mp_pay/wigets/back_button.dart';
import 'package:shared_preferences/shared_preferences.dart';


class dth_page extends StatefulWidget {
  const dth_page({Key? key}) : super(key: key);

  @override
  State<dth_page> createState() => _dth_pageState();
}

class _dth_pageState extends State<dth_page> {

  @override
  void initState() {
    this.country();
    super.initState();
  }

  List country_data = [];
  String ?id ;

  Future<String> country() async {
    final res = await http.get(
        Uri.parse(Apiconst.baseurl+"android/recharge/providers"+Apiconst.token+'type=dth'));
    final resBody = json.decode(res.body)['data'];
    //print("gggggggggggggggg");
    // print(resBody);
    setState(() {
      country_data = resBody;
    });



    return "Sucess";
  }

  final _cardController = TextEditingController();
  final _AmountController = TextEditingController();
  final _TpinController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
    Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        leading: back(),
        title: Text(
          "DTH",
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
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      // child: Wallet(),
                    ),
                    const SizedBox(height: 100),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 17.0, bottom: 5.0),
                        child: Text(
                          'Card Number',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    TextField(
                      maxLength: 10,
                      maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds,
                      controller: _cardController,
                      keyboardType: TextInputType.phone,
                      decoration: new InputDecoration(

                        counter: Offstage(),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: kTabBarBg, width: 4.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color:kTabBarBg, width: 4.0),
                        ),
                        hintText: 'Card Number',
                        suffixIcon: Icon(Icons.keyboard_alt_outlined),
                      ),
                    ),

                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 17.0, bottom: 5.0),
                        child: Text(
                          'Select your operator',
                           style: TextStyle(fontFamily: "Windsor",
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 60,
                      child: Container(
                        height: 90,width: 360,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: kTabBarBg,
                            width: 4,
                          ), //Border.all
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              dropdownColor: Colors.amberAccent,
                              hint: Text('Select your operator'),
                              items: country_data.map((item) {
                                return DropdownMenuItem(
                                    child:  Text(
                                      item['name'].toString()
                                      , overflow: TextOverflow.clip,
                                      maxLines: 1,
                                      softWrap: false,
                                       style: TextStyle(fontFamily: "Windsor",
                                          fontSize: 12,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.black
                                      ),
                                      textAlign: TextAlign.justify,
                                    ),
                                    value: item['id'].toString()
                                );
                              }).toList(),
                              onChanged: (value) async {
                                setState(() {
                                  id = value as String ;

                                }
                                );

                              },
                              value: id,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,
                    ),

                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 17.0, bottom: 5.0),
                        child: Text(
                          ' Amount',
                           style: TextStyle(fontFamily: "Windsor",
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    harsh==null?
                    TextField(
                      maxLength: 20,
                      maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds,
                      controller: _AmountController,

                      keyboardType: TextInputType.emailAddress,
                      decoration: new InputDecoration(
                        counter: Offstage(),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: kTabBarBg, width: 4.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color:kTabBarBg, width: 4.0),
                        ),
                        hintText: 'Amount ',
                        suffixIcon: Icon(Icons.money),
                      ),
                    )
                        : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 55,width: 360,
                        padding: const EdgeInsets.only(left: 10.0,top: 8),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: kTabBarBg,
                            width: 4,
                          ), //Border.all
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(harsh, textAlign: TextAlign.start,
                          style: TextStyle(
                              fontFamily: "Windsor",fontSize: 20,fontWeight: FontWeight.bold),),
                      ),
                    ),
                    Row(
                      children:[
                        RaisedButton(
                          elevation: 5,
                          padding: EdgeInsets.all(10),

                          child: Text('Get Plans', style: TextStyle(fontFamily: "Windsor",color: kBlueColor),),
                          color:kTimeBackColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0))),
                          onPressed: () {
                            _settingModalBottomSheet(context);
                          },
                        ),

                      ],
                    ),
                    SizedBox(height: 20,),
                    SizedBox(height: 30,),
                    ButtonTheme(
                      minWidth: 300.0,
                      child: RaisedButton(

                        elevation: 10,
                        padding: EdgeInsets.all(20),

                        child: Text('Reacharge Now', style: TextStyle(fontFamily: "Windsor",fontSize: 18,
                            fontWeight: FontWeight.w600,color: Colors.white),),
                        color: kRedColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0))),
                        onPressed: () {
                          dth( _cardController.text, _AmountController.text, _TpinController.text);
                        },
                      ),
                    ),

                  ],
                ),
              ),

            )

        ),
      ),
    )
    );

  }
  var harsh;

  Future<List<AddM>> add() async{
    final prefs = await SharedPreferences.getInstance();
    final key = 'user_id';
    final value = prefs.getInt(key) ?? "0";
    final prefs2 = await SharedPreferences.getInstance();
    final key2 = 'apptoken';
    final value2 = prefs2.getString(key2) ?? "0";


    final response = await http.post(
      Uri.parse(Apiconst.baseurl2+'api/plan_api.php?provider_id=$id'),

    );
    var jsond = json.decode(response.body)["data"];
    print(jsond);
    print('pppppppppppppppppppppp');



    List<AddM> allround = [];
    for (var o in jsond)  {
      AddM al = AddM(
        o["planamount"],
        o["discription"],
        o["validity"],
        o["id"],
      );



      allround.add(al);
    }
    return allround;
  }
  void _settingModalBottomSheet(context){
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        context: context,
        builder: (BuildContext bc){
          return Stack(
            overflow: Overflow.visible,
            children: [
              Positioned(
                right: -40.0,
                top: -40.0,
                child: InkResponse(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child:Icon(Icons.login ,
                    color: kTextLowBlackColor,
                    size: 30,
                  ),
                ),
              ),
              Container(
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
                            return InkWell(
                              onTap: ()async{
                                setState(() {
                                  harsh = snapshot.data![index].planamount;
                                });
                                Navigator.pop(context);
                                // showDialog(
                                //
                                //     context: context,
                                //     builder: (BuildContext context) {
                                //       return AlertDialog(
                                //         shape:RoundedRectangleBorder(
                                //           borderRadius: BorderRadius.circular(15.0),
                                //         ),
                                //         content: Container(
                                //           height: 200,
                                //           child:  Column(
                                //             mainAxisAlignment: MainAxisAlignment.center,
                                //             children: [
                                //               Container(
                                //                 height:100,
                                //                 child: Image.asset('assets/recharge_pay.gif'),
                                //               ),
                                //               Center(
                                //                 child: Container(
                                //                   // height: 50,
                                //                   child: ButtonTheme(
                                //                     // minWidth: 300.0,
                                //                     child: RaisedButton(
                                //
                                //                       elevation: 10,
                                //                       padding: EdgeInsets.all(20),
                                //
                                //                       child: Text('Reacharge Now',style: TextStyle(fontSize: 18,
                                //                           fontWeight: FontWeight.w600,color: Colors.white),),
                                //                       color: kRedColor,
                                //                       shape: RoundedRectangleBorder(
                                //                           borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                //                       onPressed: () {
                                //                         recharge(_phoneController.text, _rechargeController.text,_txnController.text);
                                //                       },
                                //                     ),
                                //                   ),
                                //                 ),
                                //               ),
                                //             ],
                                //           ),
                                //         ),
                                //       );
                                //     });
                              },
                              child: Padding(
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
                                            // BoxShadow(
                                            //   color: Colors.black,
                                            //   offset: const Offset(
                                            //     5.0,
                                            //     5.0,
                                            //   ), //Offset
                                            //   blurRadius: 10.0,
                                            //   spreadRadius: 2.0,
                                            // ), //BoxShadow
                                            BoxShadow(
                                              color: Colors.white,
                                              offset: const Offset(0.0, 0.0),
                                              blurRadius: 0.0,
                                              spreadRadius: 0.0,
                                            ), //BoxShadow
                                          ],
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(top: 18.0),
                                          child: ListTile(
                                            leading: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text('Amount',textAlign: TextAlign.center,),

                                                Text('₹'+'${snapshot.data![index].planamount}',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily: "Windsor",fontWeight: FontWeight.bold,fontSize: 15,)),

                                              ],
                                            ),
                                            title: Text('${snapshot.data![index].discription}',
                                              textAlign: TextAlign.center,),
                                            trailing: Column(
                                              children: [
                                                Text('Validity',textAlign: TextAlign.center),
                                                Text('${snapshot.data![index].validity}',textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontFamily: "Windsor",fontWeight: FontWeight.bold,fontSize: 15),),
                                              ],
                                            ),

                                          ),
                                        )
                                    ),
                                  ],
                                ),
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
                  )
              )],
          );
        }
    );
  }

  dth(String phone, String recharge,String txn)async {
    print('qqqqqqqqqqqqqqqqqqqqqqqq');
    final prefs = await SharedPreferences.getInstance();
    final key = 'user_id';
    final value = prefs.getInt(key) ?? "0";
    final prefs2 = await SharedPreferences.getInstance();
    final key2 = 'apptoken';
    final value2 = prefs2.getString(key2) ?? "0";

    final response = await http.post(
      Uri.parse(
          Apiconst.baseurl+"android/recharge/pay?"+
              Apiconst.token+'apptoken=$value2&user_id=$value&provider_id=$id&amount=$recharge&number=$phone'),
    );
    final data = jsonDecode(response.body);
    print('qqqqqqqqqqqqqqqqqqqqqqqqlllllllllllllllllll');
    print(data);
    print(data);

    if (data['status'] == "TXN") {

      Fluttertoast.showToast(
          msg: "recharge SucessFully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      print("Recharge SucessFully");

      _rechargesucessBottomSheet(context);
      // Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));


    } else {
      Fluttertoast.showToast(
          msg: data['message'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      _rechargeFaildBottomSheet(context);
    }
  }
}
void _rechargesucessBottomSheet(context){
  showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      context: context,
      builder: (BuildContext bc){
        return Container(
            width: MediaQuery.of(context).size.width,
            height:MediaQuery.of(context).size.height,
            child:  Column(
              children:[
                Align(
                    alignment: Alignment.topRight,
                    child: IconButton(onPressed: (){
                      Navigator.pop(context);
                    }, icon: Icon(Icons.close))),
                Padding(
                  padding: const EdgeInsets.only(top: 2.0),
                  child: Center(
                    child: Column(
                      children: [
                        Container(
                          child:
                          Image.asset(
                            'assets/success.gif',
                            height: 320,
                            width: 260,
                          ),
                        ),
                        Text('Recharge Successful', style: TextStyle(fontFamily: "Windsor",fontSize: 25,fontWeight: FontWeight.bold),),
                      ],
                    ),

                  ),
                ),
              ],
            )

        );
      }
  );
}

void _rechargeFaildBottomSheet(context){
  showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      context: context,
      builder: (BuildContext bc){
        return Container(
            width: MediaQuery.of(context).size.width,
            height:MediaQuery.of(context).size.height,
            child:  Column(
              children:[
                Align(
                    alignment: Alignment.topRight,
                    child: IconButton(onPressed: (){
                      Navigator.pop(context);
                    }, icon: Icon(Icons.close))),
                Padding(
                  padding: const EdgeInsets.only(top: 2.0),
                  child: Center(
                    child: Column(
                      children: [
                        Container(
                          child:
                          Image.asset(
                            'assets/error.gif',
                            height: 320,
                            width: 260,
                          ),
                        ),
                        Text('Somthing went wrong', style: TextStyle(fontFamily: "Windsor",fontSize: 25,fontWeight: FontWeight.bold),),
                      ],
                    ),

                  ),
                ),
              ],
            )

        );
      }
  );
}

class AddM {
  String planamount;
  String discription;
  String validity;
  String id;



  AddM(
      this.planamount,
      this.discription,
      this.validity,
      this.id,
      );
}