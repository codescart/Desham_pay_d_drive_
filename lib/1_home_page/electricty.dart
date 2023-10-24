import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mp_pay/app_constant.dart';
import 'package:mp_pay/curved_painty.dart';
import 'package:mp_pay/wigets/back_button.dart';


class electricty_page extends StatefulWidget {
  const electricty_page({Key? key}) : super(key: key);

  @override
  State<electricty_page> createState() => _electricty_pageState();
}

class _electricty_pageState extends State<electricty_page> {

  final _billController = TextEditingController();
  final _contactController = TextEditingController();

  void initState() {
    this.country();
    super.initState();
  }

  List country_data = [];
  String ?id ;

  Future<String> country() async {
    final res = await http.get(
        Uri.parse(Apiconst.baseurl+"android/recharge/providers"+Apiconst.token+'type=electricity'));
    final resBody = json.decode(res.body)['data'];
    //print("gggggggggggggggg");
    // print(resBody);
    setState(() {
      country_data = resBody;
    });



    return "Sucess";
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
    Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        leading: back(),
        title: Text(
          "Electricty",
           style: TextStyle(fontFamily: "Windsor",
           // fontFamily: "Windsor",
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
                padding: const EdgeInsets.only(top: 50.0),
                child: Column(
                  mainAxisAlignment:MainAxisAlignment.start,
                  children: [
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
                                       style: TextStyle(
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
                    SizedBox(height: 20,),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 17.0, bottom: 5.0),
                        child: Text(
                          'Bill Number',
                           style: TextStyle(fontFamily: "Windsor",
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    TextField(
                      maxLength: 10,
                      maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds,
                      controller: _billController,
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
                        hintText: 'bill Number',
                        suffixIcon: Icon(Icons.keyboard_alt_outlined),
                      ),
                    ),
                    SizedBox(height: 20,),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 17.0, bottom: 5.0),
                        child: Text(
                          'Contact Number',
                           style: TextStyle(fontFamily: "Windsor",
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    TextField(
                      maxLength: 10,
                      maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds,
                      controller: _contactController,
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
                        hintText: 'Contact Number',
                        suffixIcon: Icon(Icons.keyboard_alt_outlined),
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
}
