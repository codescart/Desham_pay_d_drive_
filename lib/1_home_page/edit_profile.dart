import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mp_pay/app_constant.dart';
import 'package:mp_pay/curved_painty.dart';
import 'package:mp_pay/wigets/back_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class EditPro extends StatefulWidget {
  const EditPro({Key? key}) : super(key: key);

  @override
  State<EditPro> createState() => _EditProState();
}

class _EditProState extends State<EditPro> {
  final _nameController = TextEditingController();
  final _numberController = TextEditingController();
  final _accountController = TextEditingController();
  final _bankController = TextEditingController();
  final _ifscController = TextEditingController();

  InputDecoration getInputDecoration(String hintext, IconData iconData) {
    return InputDecoration(
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
        color: kTextLowBlackColor,
      ),
      hintStyle: const TextStyle(color: Colors.black54, fontSize: 14),
      hintText: hintext,
      fillColor: kBackgroundColor,
      contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
    );
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
    Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        leading: back(),
        title: Text(
          "Edit Profile",
           style: TextStyle(fontFamily: "Windsor",

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
                padding: const EdgeInsets.only(top: 140.0),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 17.0, bottom: 5.0),
                        child: Text(
                          'Account',
                           style: TextStyle(fontFamily: "Windsor",
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, top: 0.0, right: 15.0, bottom: 8.0),
                      child: TextFormField(
                        style: const TextStyle(fontSize: 14),
                        decoration: getInputDecoration(
                          ' Enter your Account Number',
                          Icons.account_balance_wallet_outlined,
                        ),
                        controller: _accountController,
                        keyboardType: TextInputType.number,
                        validator: (input) =>
                        !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                            .hasMatch(input!)
                            ? "Email Id should be valid"
                            : null,
                        onSaved: (value) {
                          _accountController.text = value as String;
                        },
                      ),
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 17.0, bottom: 5.0),
                        child: Text(
                          'Bank',
                           style: TextStyle(fontFamily: "Windsor",
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, top: 0.0, right: 15.0, bottom: 8.0),
                      child: TextFormField(
                        style: const TextStyle(fontSize: 14),
                        decoration: getInputDecoration(
                          ' Enter your Bank',
                          Icons.account_balance,
                        ),
                        controller: _bankController,
                        keyboardType: TextInputType.text,
                        validator: (input) =>
                        !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                            .hasMatch(input!)
                            ? "Email Id should be valid"
                            : null,
                        onSaved: (value) {
                          _bankController.text = value as String;
                        },
                      ),
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 17.0, bottom: 5.0),
                        child: Text(
                          'IFSC',
                           style: TextStyle(fontFamily: "Windsor",
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, top: 0.0, right: 15.0, bottom: 8.0),
                      child: TextFormField(
                        style: const TextStyle(fontSize: 14),
                        decoration: getInputDecoration(
                          'Enter IFSC Number',
                          Icons.pin,
                        ),
                        controller: _ifscController,
                        keyboardType: TextInputType.text,
                        validator: (input) =>
                        !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                            .hasMatch(input!)
                            ? "Email Id should be valid"
                            : null,
                        onSaved: (value) {
                          _ifscController.text = value as String;
                        },
                      ),
                    ),
                    SizedBox(height: 70,),
                    ButtonTheme(
                      minWidth: 300.0,
                      child: RaisedButton(

                        elevation: 10,
                        padding: EdgeInsets.all(15),

                        child: Text('UPDATE PROFILE', style: TextStyle(fontFamily: "Windsor",fontSize: 18,
                            fontWeight: FontWeight.w600,color: Colors.white),),
                        color: kRedColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0))),
                        onPressed: () {
                          update(_accountController.text,_bankController.text,_ifscController.text);
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
  update(String _accountController , String _bankController ,String _ifscController)async {
    print('rrrrrrrrr');
    final prefs = await SharedPreferences.getInstance();
    final key = 'mobile';
    final value = prefs.getString(key) ?? "0";
    final response = await http.post(
      Uri.parse(
          Apiconst.baseurl2+'api/update_profile.php?mobile=$value&account_no=$_accountController&bank=$_bankController&ifsc=$_ifscController')
    );
    final data = jsonDecode(response.body);

    if (data['status'] == "200") {
      Fluttertoast.showToast(
          msg: "Update Success",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.pop(context);

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
