import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mp_pay/app_constant.dart';
import 'package:mp_pay/curved_painty.dart';
import 'package:mp_pay/wigets/back_button.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Fund extends StatefulWidget {
  const Fund({Key? key}) : super(key: key);

  @override
  State<Fund> createState() => _FundState();
}

class _FundState extends State<Fund> {

  final _amountController  = TextEditingController();
  final _acouController  = TextEditingController();

  void initState() {
    this.country();
    super.initState();
  }

  List country_data = [];
  String ?id ;

  Future<String> country() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'user_id';
    final value = prefs.getInt(key) ?? "0";
    final res = await http.get(
        Uri.parse(Apiconst.baseurl2+'api/roloelist_api.php?id=$value'));
    final resBody = json.decode(res.body)['data'];
    print("gggggggggggggggg");
    print(resBody);
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
          "Fund Transfer",
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
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(height: 150),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 17.0, bottom: 5.0),
                      child: Text(
                        'Select your Retailer',
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
                            dropdownColor: kLessonBackColor,
                            hint: Text('Select your Retailer'),
                            items: country_data.map((item) {
                              return DropdownMenuItem(
                                  child:  Row(
                                    children: [
                                      Container(
                                        width:200,
                                        child: Text(
                                          item['name'].toString(),
                                          overflow: TextOverflow.clip,
                                          maxLines: 1,
                                          softWrap: false,
                                           style: TextStyle(fontFamily: "Windsor",
                                              fontSize: 12,
                                              fontWeight: FontWeight.w800,
                                              color: Colors.black
                                          ),
                                          textAlign: TextAlign.justify,
                                        ),
                                      ),
                                      Container(
                                        width:100,
                                        child: Text(
                                          item['mobile'].toString(),
                                          overflow: TextOverflow.clip,
                                          maxLines: 1,
                                          softWrap: false,
                                           style: TextStyle(fontFamily: "Windsor",
                                              fontSize: 12,
                                              fontWeight: FontWeight.w800,
                                              color: Colors.black
                                          ),
                                          textAlign: TextAlign.justify,
                                        ),
                                      ),

                                    ],
                                  ),
                                  value: item['id'].toString(),

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
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextField(
                      maxLength: 20,
                      maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds,
                      controller: _amountController,

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
                    ),
                  ),
                  SizedBox(height: 20,),
                  SizedBox(height: 30,),
                  ButtonTheme(
                    minWidth: 300.0,
                    child: RaisedButton(

                      elevation: 10,
                      padding: EdgeInsets.all(20),

                      child: Text('Fund Transfer', style: TextStyle(fontFamily: "Windsor",fontSize: 18,
                          fontWeight: FontWeight.w600,color: Colors.white),),
                      color: kRedColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0))),
                      onPressed: () {
                        fund(_amountController.text);
                      },
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
  fund(String _amountController)async {
    print('qqqqqqqqqqqqqqqqqqqqqqqq');
    final prefs = await SharedPreferences.getInstance();
    final key = 'user_id';
    final value = prefs.getInt(key) ?? "0";
    final prefs2 = await SharedPreferences.getInstance();
    final key2 = 'apptoken';
    final value2 = prefs2.getString(key2) ?? "0";

    final response = await http.post(
      Uri.parse(
          Apiconst.baseurl+'android/loadwallet?&apptoken=$value2&user_id=$id&sender_id=$value&amount=$_amountController&respmsg=$_acouController'),
    );
    final data = jsonDecode(response.body);
    print('wertyuiooooiuytrew');
    print(data);
    print(data);

    if (data['status'] != "TXN") {

      Fluttertoast.showToast(
          msg: "Successfully Transfered",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      print("Recharge SucessFully");
    } else {
      Fluttertoast.showToast(
          msg: data['message'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);

    }
  }

}

