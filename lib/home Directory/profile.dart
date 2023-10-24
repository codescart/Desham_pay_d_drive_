import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mp_pay/1_home_page/add_distributer.dart';
import 'package:mp_pay/1_home_page/add_md.dart';
import 'package:mp_pay/1_home_page/add_retailer.dart';
import 'package:mp_pay/1_home_page/edit_profile.dart';
import 'package:mp_pay/1_home_page/wallet.dart';
import 'package:mp_pay/4_profile_page/fund_transfer.dart';
import 'package:mp_pay/4_profile_page/privacy_Policy.dart';
import 'package:mp_pay/4_profile_page/quik_link.dart';
import 'package:mp_pay/4_profile_page/t&c.dart';
import 'package:mp_pay/app_constant.dart';
import 'package:mp_pay/curved_painty.dart';
import 'package:mp_pay/4_profile_page/change_password.dart';
import 'package:mp_pay/login_directory/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';



class profile_page extends StatefulWidget {
  const profile_page({Key? key}) : super(key: key);

  @override
  State<profile_page> createState() => _profile_pageState();
}

class _profile_pageState extends State<profile_page> {

  void initState() {
    profile();
    rstatus();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
    Scaffold(
      body: SingleChildScrollView(
        child: Container(

            child:  CustomPaint(
              painter: SplashPainter(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children:[
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Container(
                      height: 200,width: 320,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: kBlueColor,
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
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                Text('Name :',style: TextStyle(
                                  fontFamily: "Windsor",fontSize: 15,)),
                                datas==null?Text(''):
                                datas[0]['name']==null?Text('User Name'):Text(datas[0]['name'].toString(),style: TextStyle(
                                  fontFamily: "Windsor",fontSize: 15,)),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Text('Number : ',style: TextStyle(
                                    fontFamily: "Windsor",fontSize: 15),),
                                datas==null?Text(''):
                                datas[0]['mobile']==null?Text('Mobile Number'):Text(datas[0]['mobile'].toString(),style: TextStyle(
                                  fontFamily: "Windsor",fontSize: 15,)),

                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Text('Account : ',style: TextStyle(
                                  fontFamily: "Windsor",fontSize: 15,)),
                                datas==null?Text(''):
                                datas[0]['account']==null?Text('Enter A/c number'):Text(datas[0]['account'].toString(),style: TextStyle(
                                  fontFamily: "Windsor",fontSize: 15,)),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Text('Bank : ',style: TextStyle(
                                    fontFamily: "Windsor",fontSize: 15),),
                                datas==null?Text(''):
                                datas[0]['bank']==null?Text('Enter Bank Name'):Text(datas[0]['bank'].toString(),style: TextStyle(
                                  fontFamily: "Windsor",fontSize: 15,)),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Text('IFSC : ',style: TextStyle(
                                    fontFamily: "Windsor",fontSize: 15)),
                                datas==null?Text(''):
                                datas[0]['ifsc']==null?Text('Enter IFSC'):Text(datas[0]['ifsc'].toString(),
                                    style: TextStyle(
                                      fontFamily: "Windsor",fontSize: 15,)),
                                Spacer(),
                                IconButton(onPressed: (){
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => EditPro(),
                                    ),
                                  );
                                }, icon: Icon(Icons.edit,))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 2,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Fund(),
                        ),
                      );
                    },
                    child: Container(
                        height: 70
                        ,width: 320,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: kBlueColor,
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
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(

                            children: [
                              Image.asset('assets/fund_transfer.png',
                                height: 30,width: 30,color:kRedColor ,),
                              SizedBox(width: 50,),
                              Center(
                                child: Text('Fund Transfer',style: TextStyle(
                                  fontFamily: "Windsor",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),),
                              ),

                              Spacer(),
                              Icon(Icons.login ,
                                color: kGreenPurchaseColor,
                                size: 30,
                              ),
                            ],
                          ),
                        )
                    ),
                  ),
                  SizedBox(height: 30,),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => quik(),
                        ),
                      );

                    },
                    child: Container(
                        height: 70
                        ,width: 320,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: kBlueColor,
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
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(

                            children: [
                              Icon(Icons.link_outlined ,
                                color: kRedColor,
                                size: 30,
                              ),
                              SizedBox(width: 50,),
                              Center(
                                child: Text('Members',style: TextStyle(
                                  fontFamily: "Windsor",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),),
                              ),

                              Spacer(),
                              Icon(Icons.login ,
                                color: kGreenPurchaseColor,
                                size: 30,
                              ),
                            ],
                          ),
                        )
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  datasl!=3&& datasl!=4?
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => distributer(),
                            ),
                          );

                        },
                        child: Container(
                            height: 70
                            ,width: 320,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: kBlueColor,
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
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(

                                children: [
                                  Icon(Icons.phonelink_lock ,
                                    color: kRedColor,
                                    size: 30,
                                  ),
                                  SizedBox(width: 50,),
                                  Center(
                                    child: Text('Add Distributor',style: TextStyle(
                                      fontFamily: "Windsor",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),),
                                  ),

                                  Spacer(),
                                  Icon(Icons.login ,
                                    color: kGreenPurchaseColor,
                                    size: 30,
                                  ),
                                ],
                              ),
                            )
                        ),

                      ),

                      SizedBox(height: 30,),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => retailer(),
                            ),
                          );

                        },
                        child: Container(
                            height: 70
                            ,width: 320,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: kBlueColor,
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
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(

                                children: [
                                  Icon(Icons.phonelink_lock ,
                                    color: kRedColor,
                                    size: 30,
                                  ),
                                  SizedBox(width: 50,),
                                  Center(
                                    child: Text('Add Retailer',style: TextStyle(
                                      fontFamily: "Windsor",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),),
                                  ),

                                  Spacer(),
                                  Icon(Icons.login ,
                                    color:kGreenPurchaseColor,
                                    size: 30,
                                  ),
                                ],
                              ),
                            )
                        ),

                      ),
                      SizedBox(height: 30,),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => md(),
                            ),
                          );

                        },
                        child: Container(
                            height: 70
                            ,width: 320,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: kBlueColor,
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
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(

                                children: [
                                  Icon(Icons.phonelink_lock ,
                                    color: kRedColor,
                                    size: 30,
                                  ),
                                  SizedBox(width: 30,),
                                  Center(
                                    child: Text('Add Master Distributor',style: TextStyle(
                                      fontFamily: "Windsor",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),),
                                  ),

                                  Spacer(),
                                  Icon(Icons.login ,
                                    color: kGreenPurchaseColor,
                                    size: 30,
                                  ),
                                ],
                              ),
                            )
                        ),

                      ),
                    ],
                  )
                      :datasl !=4?Column(
                    children: [

                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => retailer(),
                            ),
                          );

                        },
                        child: Container(
                            height: 70
                            ,width: 320,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: kBlueColor,
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
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(

                                children: [
                                  Icon(Icons.phonelink_lock ,
                                    color: kRedColor,
                                    size: 30,
                                  ),
                                  SizedBox(width: 50,),
                                  Center(
                                    child: Text('Add Retailer',style: TextStyle(
                                      fontFamily: "Windsor",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),),
                                  ),

                                  Spacer(),
                                  Icon(Icons.login ,
                                    color: kGreenPurchaseColor,
                                    size: 30,
                                  ),
                                ],
                              ),
                            )
                        ),

                      ),

                    ],
                  ):Container(),


                  SizedBox(height: 30,),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => change(),
                        ),
                      );

                    },
                    child: Container(
                        height: 70
                        ,width: 320,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: kBlueColor,
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
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(

                            children: [
                              Icon(Icons.phonelink_lock ,
                                color: kRedColor,
                                size: 30,
                              ),
                              SizedBox(width: 50,),
                              Center(
                                child: Text('Change Password',style: TextStyle(
                                  fontFamily: "Windsor",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),),
                              ),

                              Spacer(),
                              Icon(Icons.login ,
                                color: kGreenPurchaseColor,
                                size: 30,
                              ),
                            ],
                          ),
                        )
                    ),

                  ),

                  SizedBox(height: 30,),
                  InkWell(
                    onTap: () async {
                      SharedPreferences preferences = await SharedPreferences.getInstance();
                      await preferences.remove('user_id');
                      final prefs1 = await SharedPreferences
                          .getInstance();
                      final key1 = 'user_id';
                      final mobile = 0;
                      prefs1.setInt(key1, mobile);
                      await preferences.clear();
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>login()));

                    },
                    child: Container(
                        height: 70
                        ,width: 320,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: kBlueColor,
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
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(

                            children: [
                              Icon(Icons.logout ,
                                color: kRedColor,
                                size: 30,
                              ),
                              SizedBox(width: 50,),
                              Center(
                                child: Text('Logout',style: TextStyle(
                                  fontFamily: "Windsor",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),),
                              ),

                              Spacer(),
                              Icon(Icons.login ,
                                color: kGreenPurchaseColor,
                                size: 30,
                              ),
                            ],
                          ),
                        )
                    ),

                  ),
                ],
              ),
            )
        ),
      ),
    )
    );
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
  var datas;
  profile() async{
    final prefs = await SharedPreferences.getInstance();
    final key = 'mobile';
    final value = prefs.getString(key) ?? "0";
    print(Apiconst.baseurl+'android/userbank?mobile=');
    final response = await http.post(
      Uri.parse(Apiconst.baseurl+'android/userbank?mobile=$value'),


    );
    var data = jsonDecode(response.body);
    print(data);
    print('llllllllllllllssssssssssssssssssssssssssssss');
    if (data['statuscode'] == 'TXN') {
      setState(() {
        datas=data['data'];
      });
    }
  }
}