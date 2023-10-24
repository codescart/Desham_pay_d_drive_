import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mp_pay/app_constant.dart';
import 'package:mp_pay/curved_painty.dart';
import 'package:mp_pay/login_directory/login_screen.dart';

class verify_forget_email extends StatefulWidget {
  const verify_forget_email({Key? key}) : super(key: key);

  @override
  State<verify_forget_email> createState() => _verify_forget_emailState();
}
final _emailController = TextEditingController();
final _pinController = TextEditingController();
final _newpasswordController = TextEditingController();
class _verify_forget_emailState extends State<verify_forget_email> {
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
    return SafeArea(child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            // width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child:  CustomPaint(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: kBackgroundColor,
                      child:
                      Image.asset(
                        'assets/logo.png',
                        height: 120,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      'Verify Email Password',
                      style: TextStyle(fontFamily: "Windsor",
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 80),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 17.0, bottom: 5.0, top: 0),
                        child: Text(
                          'Email *',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontFamily: "Windsor",
                            fontSize: 20,

                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    Padding (
                      padding:  EdgeInsets.only(
                          left: 15.0, top: 0, right: 15.0, bottom: 8.0),
                      child: TextFormField(
                        style: const TextStyle(fontSize: 14),
                        decoration: getInputDecoration(
                          'Email ID',
                          Icons.email_outlined,
                        ),
                        // maxLength: 10,


                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,

                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 17.0, bottom: 5.0, top: 0),
                        child: Text(
                          'Verification Code *',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontFamily: "Windsor",
                            fontSize: 20,

                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(
                          left: 15.0, top: 0, right: 15.0, bottom: 8.0),
                      child: TextFormField(
                        style: const TextStyle(fontSize: 14),
                        decoration: getInputDecoration(
                          'Verification Code',
                          Icons.pin,
                        ),
                         maxLength: 8,


                        controller: _pinController,
                        keyboardType: TextInputType.number,

                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 17.0, bottom: 5.0, top: 0),
                        child: Text(
                          'New Password *',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontFamily: "Windsor",
                            fontSize: 20,

                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(
                          left: 15.0, top: 0, right: 15.0, bottom: 8.0),
                      child: TextFormField(
                        style: const TextStyle(fontSize: 14),
                        decoration: getInputDecoration(
                          'New Password',
                          Icons.password,
                        ),
                        controller: _newpasswordController,
                        keyboardType: TextInputType.visiblePassword,

                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child:
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: MaterialButton(
                          elevation: 0,
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: const [
                              Text(
                                'Change Password',
                                style: TextStyle(fontFamily: "Windsor",
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          color: kRedColor,
                          onPressed: (){
                            verify(_emailController.text,_pinController.text,_newpasswordController.text);
                            //   Navigator.of(context).push(
                            //   MaterialPageRoute(
                            //     builder: (context) => HomePage(),
                            //   ),
                            // );
                          },
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadiusDirectional.circular(10),
                            // side: const BorderSide(color: kRedColor),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),


                  ],
                ),
                painter: SplashPainter()
            ),
          ),
        )
    ));
  }
  verify(String userEmail,String _pinController,String _newpasswordController)async {
    print('rrrrrrrrr');
    final response = await http.post(
      Uri.parse(
          Apiconst.baseurl+'android/auth/reset?email=$userEmail&token=$_pinController&password=$_newpasswordController'),
    );
    final data = jsonDecode(response.body);

    if (data['status'] == "TXN") {
      final raja=data['userdata'];
      print(raja);
      Fluttertoast.showToast(
          msg: data['message'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      print(data);
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => login()));

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
