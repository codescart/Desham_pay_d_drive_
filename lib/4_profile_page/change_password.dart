import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mp_pay/app_constant.dart';
import 'package:mp_pay/curved_painty.dart';
import 'package:mp_pay/home%20Directory/bottam_navigation_bar.dart';
import 'package:mp_pay/wigets/back_button.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class change extends StatefulWidget {
  const change({Key? key}) : super(key: key);

  @override
  State<change> createState() => _changeState();
}

class _changeState extends State<change> {

  bool hidePassword = true;
  bool hidePassword1= true;
  bool hidePassword2 = true;

  final _oldpassController = TextEditingController();
  final _newpassController = TextEditingController();
  final _confirmpassController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
    Scaffold( appBar: AppBar(
      backgroundColor: kBackgroundColor,
      leading: back(),
      title: Text(
        "Change Password",
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
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 38.0),
                  ),
                  SizedBox(height: 50,),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 17.0, bottom: 5.0),
                      child: Text(
                        'Old Password',
                         style: TextStyle(fontFamily: "Windsor",
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, top: 0.0, right: 15.0, bottom: 4.0),
                    child: TextFormField(
                      style: const TextStyle(color: Colors.black),
                      keyboardType: TextInputType.text,
                      controller: _oldpassController,
                      onSaved: (input) {
                        _oldpassController.text = input as String;
                      },
                      validator: (input) => input!.length < 3
                          ? "Password should be more than 3 characters"
                          : null,
                      obscureText: hidePassword,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(12.0)),
                          borderSide:
                          BorderSide(color: Colors.white, width: 2),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(12.0)),
                          borderSide:
                          BorderSide(color: Colors.white, width: 2),
                        ),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.all(
                            Radius.circular(12.0),
                          ),
                        ),
                        filled: true,
                        hintStyle: const TextStyle(
                            color: Colors.black54, fontSize: 14),
                        hintText: "old password",

                        fillColor: kBackgroundColor,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 18, horizontal: 15),
                        prefixIcon: const Icon(
                          Icons.lock_outlined,
                          color: kTextLowBlackColor,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              hidePassword = !hidePassword;
                            });
                          },
                          color: kTextLowBlackColor,
                          icon: Icon(hidePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined),
                        ),
                      ),
                    ),
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 17.0, bottom: 5.0),
                      child: Text(
                        ' New Password',
                         style: TextStyle(fontFamily: "Windsor",
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, top: 0.0, right: 15.0, bottom: 4.0),
                    child: TextFormField(
                      style: const TextStyle(color: Colors.black),
                      keyboardType: TextInputType.text,
                      controller: _newpassController,
                      onSaved: (input) {
                        _newpassController.text = input as String;
                      },
                      validator: (input) => input!.length < 3
                          ? "Password should be more than 3 characters"
                          : null,
                      obscureText: hidePassword1,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(12.0)),
                          borderSide:
                          BorderSide(color: Colors.white, width: 2),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(12.0)),
                          borderSide:
                          BorderSide(color: Colors.white, width: 2),
                        ),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.all(
                            Radius.circular(12.0),
                          ),
                        ),
                        filled: true,
                        hintStyle: const TextStyle(
                            color: Colors.black54, fontSize: 14),
                        hintText: "new password",

                        fillColor: kBackgroundColor,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 18, horizontal: 15),
                        prefixIcon: const Icon(
                          Icons.lock_outlined,
                          color: kTextLowBlackColor,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              hidePassword1 = !hidePassword1;
                            });
                          },
                          color: kTextLowBlackColor,
                          icon: Icon(hidePassword1
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined),
                        ),
                      ),
                    ),
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 17.0, bottom: 5.0),
                      child: Text(
                        'Confirm Password',
                         style: TextStyle(fontFamily: "Windsor",
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, top: 0.0, right: 15.0, bottom: 4.0),
                    child: TextFormField(
                      style: const TextStyle(color: Colors.black),
                      keyboardType: TextInputType.text,
                      controller: _confirmpassController,
                      onSaved: (input) {
                        _confirmpassController.text = input as String;
                      },
                      validator: (input) => input!.length < 3
                          ? "Password should be more than 3 characters"
                          : null,
                      obscureText: hidePassword2,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(12.0)),
                          borderSide:
                          BorderSide(color: Colors.white, width: 2),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(12.0)),
                          borderSide:
                          BorderSide(color: Colors.white, width: 2),
                        ),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.all(
                            Radius.circular(12.0),
                          ),
                        ),
                        filled: true,
                        hintStyle: const TextStyle(
                            color: Colors.black54, fontSize: 14),
                        hintText: "confirm password",

                        fillColor: kBackgroundColor,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 18, horizontal: 15),
                        prefixIcon: const Icon(
                          Icons.lock_outlined,
                          color: kTextLowBlackColor,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              hidePassword2 = !hidePassword2;
                            });
                          },
                          color: kTextLowBlackColor,
                          icon: Icon(hidePassword2
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 30,),
                  ButtonTheme(
                    minWidth: 300.0,
                    child: RaisedButton(

                      elevation: 10,
                      padding: EdgeInsets.all(15),

                      child: Text('Confirm Now', style: TextStyle(fontFamily: "Windsor",fontSize: 18,
                          fontWeight: FontWeight.w600,color: Colors.white),),
                      color: kRedColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0))),
                      onPressed: () {
                        reset(_oldpassController.text,_newpassController.text,_confirmpassController.text);
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
  reset(String _oldpassController , String _newpassController,String _confirmpassController)async {
    print('rrrrrrrrr');
    final prefs = await SharedPreferences.getInstance();
    final key = 'user_id';
    final value = prefs.getInt(key) ?? "0";
    final prefs2 = await SharedPreferences.getInstance();
    final key2 = 'apptoken';
    final value2 = prefs2.getString(key2) ?? "0";
    final response = await http.post(
      Uri.parse(
          Apiconst.baseurl+"android/auth/password/change?"+
             'oldpassword=$_oldpassController&password=$_newpassController&user_id=$value&apptoken=$value2'),

    );
    final data = jsonDecode(response.body);

    if (data['status'] == "TXN") {
      Fluttertoast.showToast(
          msg: "PASSWORD SUCCESS",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));

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
