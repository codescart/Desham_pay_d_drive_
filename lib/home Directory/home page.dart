
import 'dart:convert';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mp_pay/1_home_page/add_money.dart';
import 'package:mp_pay/1_home_page/aesp.dart';
import 'package:mp_pay/1_home_page/brodband.dart';
import 'package:mp_pay/1_home_page/dmt.dart';
import 'package:mp_pay/1_home_page/dth.dart';
import 'package:mp_pay/1_home_page/electricty.dart';
import 'package:mp_pay/1_home_page/fast_tage_page.dart';
import 'package:mp_pay/1_home_page/housing.dart';
import 'package:mp_pay/1_home_page/insurance_page.dart';
import 'package:mp_pay/1_home_page/landline.dart';
import 'package:mp_pay/1_home_page/lpg_gas.dart';
import 'package:mp_pay/1_home_page/m_atm.dart';
import 'package:mp_pay/1_home_page/mobile_page.dart';
import 'package:http/http.dart' as http;
import 'package:mp_pay/1_home_page/qr_code_page.dart';
import 'package:mp_pay/1_home_page/upi_payment_page.dart';
import 'package:mp_pay/1_home_page/water.dart';
import 'package:mp_pay/Drawer_directory/upi_test.dart';
import 'package:mp_pay/app_constant.dart';
import 'package:mp_pay/curved_painty.dart';
import 'package:mp_pay/finger_print_page/Fingerprint_mobile.dart';
import 'package:mp_pay/finger_print_page/finger_print_dth.dart';
import '../app_constant.dart';



class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {


  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
        Scaffold(
          body: SingleChildScrollView(
            child: Container(
             // width: MediaQuery.of(context).size.width*0.99,
                height: MediaQuery.of(context).size.height,              child:  CustomPaint(
               painter: SplashPainter(),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Container(
                            height: 200,
                            width: MediaQuery.of(context).size.width*0.99,
                            child: FutureBuilder<List<Alb>>(
                                future: bowe(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) print(snapshot.error);

                                  return snapshot.hasData
                                      ? CarouselSlider.builder(
                                    itemCount:snapshot.data!.length,
                                    // itemCount: carouselimages.length,
                                    itemBuilder: (BuildContext context, int index) =>
                                        Container(
                                          width: MediaQuery.of(context).size.width*0.99,
                                          decoration: BoxDecoration(
                                            // color:AppConstant.primaryColor,
                                            image: DecorationImage(
                                              image: NetworkImage('https://'+snapshot.data![index].image),
                                              fit: BoxFit.fill
                                            ),
                                          ),
                                        ),
                                    options: CarouselOptions(
                                      autoPlay: true,
                                       enlargeCenterPage: true,
                                      viewportFraction: 1.0,
                                      aspectRatio: 0.1,

                                      initialPage: 0,


                                    ),

                                  ) :Center(child:Image.asset(
                                    'assets/no data slider.png',
                                    height: 150,
                                  ),);
                                }
                            )
                        ),
                      ),
                      // Wallet(),//wallet page
                      SizedBox(height: 15,),
                      Divider(
                        thickness: 2,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => qrcode_page(),
                                  ),
                                );
                              },
                              child: Container(
                                height: 80,width: 80,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: kBlueColor,
                                    width: 4,
                                  ), //Border.all
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black,
                                      offset: const Offset(
                                        2.0,
                                        2.0,
                                      ), //Offset
                                      blurRadius: 5.0,
                                      spreadRadius: 1.0,
                                    ), //BoxShadow
                                    BoxShadow(
                                      color: Colors.white,
                                      offset: const Offset(0.0, 0.0),
                                      blurRadius: 0.0,
                                      spreadRadius: 0.0,
                                    ), //BoxShadow
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.qr_code_2_rounded,
                                      color: kRedColor,
                                      size: 30,
                                    ),
                                    Text('QR Code',style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: "Windsor",
                                      fontWeight: FontWeight.w400,
                                    ),),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        pay(),
                                  ),
                                );

                              },
                              child: Container(
                                height: 80,width: 80,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: kBlueColor,
                                    width: 4,
                                  ), //Border.all
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black,
                                      offset: const Offset(
                                        2.0,
                                        2.0,
                                      ), //Offset
                                      blurRadius: 5.0,
                                      spreadRadius: 1.0,
                                    ), //BoxShadow
                                    BoxShadow(
                                      color: Colors.white,
                                      offset: const Offset(0.0, 0.0),
                                      blurRadius: 0.0,
                                      spreadRadius: 0.0,
                                    ), //BoxShadow
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.account_balance_wallet_outlined,
                                      color: kRedColor,
                                      size: 30,
                                    ),
                                    Text('Add Money',style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: "Windsor",
                                      fontWeight: FontWeight.w400,
                                    ),),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => dmt_page(),
                                  ),
                                );

                              },
                              child: Container(
                                height: 80,width: 80,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: kBlueColor,
                                    width: 4,
                                  ), //Border.all
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black,
                                      offset: const Offset(
                                        2.0,
                                        2.0,
                                      ), //Offset
                                      blurRadius: 5.0,
                                      spreadRadius: 1.0,
                                    ), //BoxShadow
                                    BoxShadow(
                                      color: Colors.white,
                                      offset: const Offset(0.0, 0.0),
                                      blurRadius: 0.0,
                                      spreadRadius: 0.0,
                                    ), //BoxShadow
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset('assets/mony_bag.png',
                                      height: 30,width: 30,color:kRedColor ,),
                                    Text('DMT',style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: "Windsor",
                                      fontWeight: FontWeight.w400,
                                    ),),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => upipayment(),
                                  ),
                                );

                              },
                              child: Container(
                                height: 80,width: 80,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: kBlueColor,
                                    width: 4,
                                  ), //Border.all
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black,
                                      offset: const Offset(
                                        2.0,
                                        2.0,
                                      ), //Offset
                                      blurRadius: 5.0,
                                      spreadRadius: 1.0,
                                    ), //BoxShadow
                                    BoxShadow(
                                      color: Colors.white,
                                      offset: const Offset(0.0, 0.0),
                                      blurRadius: 0.0,
                                      spreadRadius: 0.0,
                                    ), //BoxShadow
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset('assets/upi.png',
                                      height: 30,width: 30,color:kRedColor ,),
                                    Text('UPI Pay',style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: "Windsor",
                                      fontWeight: FontWeight.w400,
                                    ),),
                                  ],
                                ),
                              ),
                            ),


                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => Testa(),
                                  ),
                                );
                              },
                              child: Container(
                               height: 80,width: 80,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: kBlueColor,
                                    width: 4,
                                  ), //Border.all
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black,
                                      offset: const Offset(
                                        2.0,
                                        2.0,
                                      ), //Offset
                                      blurRadius: 5.0,
                                      spreadRadius: 1.0,
                                    ), //BoxShadow
                                    BoxShadow(
                                      color: Colors.white,
                                      offset: const Offset(0.0, 0.0),
                                      blurRadius: 0.0,
                                      spreadRadius: 0.0,
                                    ), //BoxShadow
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.phone_iphone_outlined,
                                      color: kRedColor,
                                      size: 30,
                                    ),
                                    Text('Mobile',style: TextStyle(
                                     fontSize: 12,
                                      fontFamily: "Windsor",
                                      fontWeight: FontWeight.w400,
                                    ),),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>  fingerdth(),
                                  ),
                                );
                              },
                              child: Container(
                               height: 80,width: 80,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: kBlueColor,
                                    width: 4,
                                  ), //Border.all
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black,
                                      offset: const Offset(
                                        2.0,
                                        2.0,
                                      ), //Offset
                                      blurRadius: 5.0,
                                      spreadRadius: 1.0,
                                    ), //BoxShadow
                                    BoxShadow(
                                      color: Colors.white,
                                      offset: const Offset(0.0, 0.0),
                                      blurRadius: 0.0,
                                      spreadRadius: 0.0,
                                    ), //BoxShadow
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset('assets/antina.png',
                                     height: 30,width: 30,color:kRedColor ,),
                                    Text('DTH',style: TextStyle(
                                     fontSize: 12,
                                       fontFamily: "Windsor",
                                      fontWeight: FontWeight.w400,
                                    ),),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => landline_page(),
                                  ),
                                );

                              },
                              child: Container(
                                height: 80,width: 80,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: kBlueColor,
                                    width: 4,
                                  ), //Border.all
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black,
                                      offset: const Offset(
                                        2.0,
                                        2.0,
                                      ), //Offset
                                      blurRadius: 5.0,
                                      spreadRadius: 1.0,
                                    ), //BoxShadow
                                    BoxShadow(
                                      color: Colors.white,
                                      offset: const Offset(0.0, 0.0),
                                      blurRadius: 0.0,
                                      spreadRadius: 0.0,
                                    ), //BoxShadow
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset('assets/landline.png',height: 30,width: 30,
                                      color:kRedColor ,),
                                    Text('landline',style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: "Windsor",
                                      fontWeight: FontWeight.w400,
                                    ),),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => broad(),
                                  ),
                                );

                              },
                              child: Container(
                                height: 80,width: 80,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: kBlueColor,
                                    width: 4,
                                  ), //Border.all
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black,
                                      offset: const Offset(
                                        2.0,
                                        2.0,
                                      ), //Offset
                                      blurRadius: 5.0,
                                      spreadRadius: 1.0,
                                    ), //BoxShadow
                                    BoxShadow(
                                      color: Colors.white,
                                      offset: const Offset(0.0, 0.0),
                                      blurRadius: 0.0,
                                      spreadRadius: 0.0,
                                    ), //BoxShadow
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset('assets/brodband.png',height: 30,width: 30,
                                      color:kRedColor ,),
                                    Text('Brodband',style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: "Windsor",
                                      fontWeight: FontWeight.w400,
                                    ),),
                                  ],
                                ),
                              ),
                            ),


                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [


                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>  electricty_page(),
                                  ),
                                );

                              },
                              child: Container(
                               height: 80,width: 80,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: kBlueColor,
                                    width: 4,
                                  ), //Border.all
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black,
                                      offset: const Offset(
                                        2.0,
                                        2.0,
                                      ), //Offset
                                      blurRadius: 5.0,
                                      spreadRadius: 1.0,
                                    ), //BoxShadow
                                    BoxShadow(
                                      color: Colors.white,
                                      offset: const Offset(0.0, 0.0),
                                      blurRadius: 0.0,
                                      spreadRadius: 0.0,
                                    ), //BoxShadow
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.lightbulb_outline_sharp,
                                      color: kRedColor,
                                      size: 30,
                                    ),
                                    Text('Electricty',style: TextStyle(
                                     fontSize: 12,
                                      fontFamily: "Windsor",
                                      fontWeight: FontWeight.w400,
                                    ),),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => housing_page(),
                                  ),
                                );

                              },
                              child: Container(
                                height: 80,width: 80,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: kBlueColor,
                                    width: 4,
                                  ), //Border.all
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black,
                                      offset: const Offset(
                                        2.0,
                                        2.0,
                                      ), //Offset
                                      blurRadius: 5.0,
                                      spreadRadius: 1.0,
                                    ), //BoxShadow
                                    BoxShadow(
                                      color: Colors.white,
                                      offset: const Offset(0.0, 0.0),
                                      blurRadius: 0.0,
                                      spreadRadius: 0.0,
                                    ), //BoxShadow
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.house_outlined,
                                      color: kRedColor,
                                      size: 30,
                                    ),
                                    Text('Housing ',style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: "Windsor",
                                      fontWeight: FontWeight.w400,
                                    ),),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => lpg_page(),
                                  ),
                                );

                              },
                              child: Container(
                                height: 80,width: 80,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: kBlueColor,
                                    width: 4,
                                  ), //Border.all
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black,
                                      offset: const Offset(
                                        2.0,
                                        2.0,
                                      ), //Offset
                                      blurRadius: 5.0,
                                      spreadRadius: 1.0,
                                    ), //BoxShadow
                                    BoxShadow(
                                      color: Colors.white,
                                      offset: const Offset(0.0, 0.0),
                                      blurRadius: 0.0,
                                      spreadRadius: 0.0,
                                    ), //BoxShadow
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset('assets/gas_cylinder.png',height: 30,width: 30,
                                      color:kRedColor ,),
                                    Text('LPG GAS',style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: "Windsor",
                                      fontWeight: FontWeight.w400,
                                    ),),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => water_page(),
                                  ),
                                );

                              },
                              child: Container(
                                height: 80,width: 80,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: kBlueColor,
                                    width: 4,
                                  ), //Border.all
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black,
                                      offset: const Offset(
                                        2.0,
                                        2.0,
                                      ), //Offset
                                      blurRadius: 5.0,
                                      spreadRadius: 1.0,
                                    ), //BoxShadow
                                    BoxShadow(
                                      color: Colors.white,
                                      offset: const Offset(0.0, 0.0),
                                      blurRadius: 0.0,
                                      spreadRadius: 0.0,
                                    ), //BoxShadow
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset('assets/water.png',height: 30,width: 30,
                                      color:kRedColor ,),
                                    Text('water',style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: "Windsor",
                                      fontWeight: FontWeight.w400,
                                    ),),
                                  ],
                                ),
                              ),
                            ),


                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => atm(),
                                  ),
                                );

                              },
                              child: Container(
                                height: 80,width: 80,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: kBlueColor,
                                    width: 4,
                                  ), //Border.all
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black,
                                      offset: const Offset(
                                        2.0,
                                        2.0,
                                      ), //Offset
                                      blurRadius: 5.0,
                                      spreadRadius: 1.0,
                                    ), //BoxShadow
                                    BoxShadow(
                                      color: Colors.white,
                                      offset: const Offset(0.0, 0.0),
                                      blurRadius: 0.0,
                                      spreadRadius: 0.0,
                                    ), //BoxShadow
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset('assets/billing.png',height: 30,width: 30,
                                      color:kRedColor ,),
                                    Text('mATM',style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: "Windsor",
                                      fontWeight: FontWeight.w400,
                                    ),),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => Aesp_page(),
                                  ),
                                );

                              },
                              child: Container(
                               height: 80,width: 80,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: kBlueColor,
                                    width: 4,
                                  ), //Border.all
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black,
                                      offset: const Offset(
                                        2.0,
                                        2.0,
                                      ), //Offset
                                      blurRadius: 5.0,
                                      spreadRadius: 1.0,
                                    ), //BoxShadow
                                    BoxShadow(
                                      color: Colors.white,
                                      offset: const Offset(0.0, 0.0),
                                      blurRadius: 0.0,
                                      spreadRadius: 0.0,
                                    ), //BoxShadow
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.fingerprint_sharp,
                                      color: kRedColor,
                                      size: 30,
                                    ),
                                    Text('AEPS',style: TextStyle(
                                     fontSize: 12,
                                      fontFamily: "Windsor",
                                      fontWeight: FontWeight.w400,
                                    ),),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => INSURANCE(),
                                  ),
                                );

                              },
                              child: Container(
                               height: 80,width: 80,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: kBlueColor,
                                    width: 4,
                                  ), //Border.all
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black,
                                      offset: const Offset(
                                        2.0, 2.0,
                                      ), //Offset
                                      blurRadius: 5.0,
                                      spreadRadius: 1.0,
                                    ), //BoxShadow
                                    BoxShadow(
                                      color: Colors.white,
                                      offset: const Offset(0.0, 0.0),
                                      blurRadius: 0.0,
                                      spreadRadius: 0.0,
                                    ), //BoxShadow
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset('assets/life_insurance.png',height: 30,width: 30,
                                      color:kRedColor ,),
                                    Text('Insurance',style: TextStyle(
                                     fontSize: 12,
                                      fontFamily: "Windsor",
                                      fontWeight: FontWeight.w400,
                                    ),),
                                  ],
                                ),
                              ),
                            ),

                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => fasttag(),
                                  ),
                                );

                              },
                              child: Container(
                               height: 80,width: 80,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: kBlueColor,
                                    width: 4,
                                  ), //Border.all
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black,
                                      offset: const Offset(
                                        2.0,
                                        2.0,
                                      ), //Offset
                                      blurRadius: 5.0,
                                      spreadRadius: 1.0,
                                    ), //BoxShadow
                                    BoxShadow(
                                      color: Colors.white,
                                      offset: const Offset(0.0, 0.0),
                                      blurRadius: 0.0,
                                      spreadRadius: 0.0,
                                    ), //BoxShadow
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset('assets/toll_road.png',height: 30,width: 30,
                                      color:kRedColor ,),
                                    Text('FasTag',style: TextStyle(
                                     fontSize: 12,
                                      fontFamily: "Windsor",
                                      fontWeight: FontWeight.w400,
                                    ),),
                                  ],
                                ),
                              ),
                            ),
                          ],
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

  Future<List<Alb>> bowe() async{
  final response = await http.get(
  Uri.parse(Apiconst.baseurl2+'api/getslider_list.php'),

  );

  var jsond = json.decode(response.body)["data"];
  print(jsond);
  List<Alb> allround = [];
  for (var o in jsond)  {
  Alb al = Alb(
  o["image"],


  );

  allround.add(al);
  }
  return allround;
  }
}
class Alb {
  String image;


  Alb(this.image);

}