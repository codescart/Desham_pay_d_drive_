import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mp_pay/app_constant.dart';
import 'package:mp_pay/curved_painty.dart';
import 'package:mp_pay/home%20Directory/bottam_navigation_bar.dart';
import 'package:mp_pay/login_directory/forget_passward.dart';
import 'package:mp_pay/login_directory/sign_up_screen.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  String? _id;


  void _getInfo() async {
    // Get device id
    String? result = await PlatformDeviceId.getDeviceId;

    // Update the UI
    setState(() {
      _id = result;
    });
  }

  void initState() {
    _getInfo();
    // futureAlbum = fetchAlbum();
    // TODO: implement initState
    super.initState();
  }
  bool hidePassword = true;
  bool _isLoading = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
            'Log in',
             style: TextStyle(fontFamily: "Windsor",
              fontSize: 22,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 80),
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 17.0, bottom: 5.0),
              child: Text(
                'Phone',
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
                'Phone Number',
                Icons.phone_iphone_outlined,
              ),
              maxLength: 10,


              controller: _emailController,
              keyboardType: TextInputType.number,

              validator: (input) =>
              !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                  .hasMatch(input!)
                  ? "Email Id should be valid"
                  : null,
              onSaved: (value) {
                _emailController.text = value as String;
              },
            ),
          ),
          const SizedBox(height: 10),
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 17.0, bottom: 5.0),
              child: Text(
                'Password',
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
              controller: _passwordController,
              onSaved: (input) {
                _passwordController.text = input as String;
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
                hintText: "password",

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
          InkWell(
            onTap: () {
                Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => forget_email(),
                ),
              );
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 20, vertical: 5),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Forget Password?',
                   style: TextStyle(fontFamily: "Windsor",color: kSecondaryColor),
                ),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : Padding(
              padding: const EdgeInsets.all(15.0),
              child: MaterialButton(
                elevation: 0,
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Log In',
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
                  login(_emailController.text, _passwordController.text);
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
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Do not have an account?',
                   style: TextStyle(fontFamily: "Windsor",
                    color: kTextLowBlackColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const signup(),
                      ),
                    );

                  },
                  child: const Text(
                    ' Sign up',
                     style: TextStyle(fontFamily: "Windsor",
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20,),
          Text(
            'To Contact with?',
             style: TextStyle(fontFamily: "Windsor",
              color: kTextLowBlackColor,
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 30,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: (){
                   _launchCaller();
                },
                child: Container(
                  height: 50,width: 50,
                  // color: Colors.orange,
                   decoration: BoxDecoration(

                    border: Border.all(
                      color: kTabBarBg,
                      width: 8,
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
                  child: Image.asset('assets/phone.gif',
                    height: 20,width: 20,),
                ),
              ),
              InkWell(
                onTap: (){
                  _launchEmail();
                },
                child: Container(
                  height: 50,width: 50,
                  // color: Colors.orange,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: kTabBarBg,
                      width: 8,
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
                  child: Image.asset('assets/mail.gif',
                    height: 20,width: 20,),
                ),
              ),
              InkWell(
                onTap: (){


                  openwhatsapp();
                  },
                child: Container(
                  height: 50,width: 50,
                  // color: Colors.orange,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: kTabBarBg,
                      width: 8,
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
                  child: Image.asset('assets/whatsapp.gif',
                    height: 20,width: 20,),
                  ),
                ),
             ] ),
          SizedBox(height: 30,),

        ],
      ),
    painter: SplashPainter()
    ),
        ),
      )

    ));

  }
  _launchCaller() async {
    const url = "tel:7772969533";
    if (await canLaunch(url)) {
      await launch(url);
    } else    {
      throw 'Could not launch $url';
    }
  }
  openwhatsapp() async{
    var whatsapp ="+917772969533";
    var whatsappURl_android = "whatsapp://send?phone="+whatsapp+"&text=hello";
    var whatappURL_ios ="https://wa.me/$whatsapp?text=${Uri.parse("hello")}";

      if( await canLaunch(whatsappURl_android)){
        await launch(whatsappURl_android);
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: new Text("whatsapp no installed")));
      }
    }
  String email="hr@deshampay.co.in";
  _launchEmail() async {
    if (await canLaunch("mailto:$email")) {
      await launch("mailto:$email");
    } else {
      throw 'Could not launch';
    }
  }

  login(String userEmail, String userPassword,)async {
    print('rrrrrrrrr');
    final response = await http.post(
      Uri.parse(
          Apiconst.baseurl+"android/auth"+
              Apiconst.token+'mobile=$userEmail&password=$userPassword&device_id=$_id'),

    );
    final data = jsonDecode(response.body);

    if (data['status'] == "TXN") {
final raja=data['userdata'];
print(raja);
      Fluttertoast.showToast(
          msg: "Login SucessFully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      print("Email login SucessFully");
final prefs1 = await SharedPreferences
    .getInstance();
final key1 = 'user_id';
final mobile = raja['id'];
prefs1.setInt(key1, mobile);
prefs1.setString('ema', raja['email']);
prefs1.setString('mob', raja['mobile']);

final prefs3 = await SharedPreferences
    .getInstance();
final key3 = 'role';
final mobiles = raja['role_id'];
prefs3.setInt(key3, mobiles);
final prefs = await SharedPreferences
    .getInstance();
final key = 'apptoken';
final apptok = raja['apptoken'];
prefs.setString(key, apptok);

final prefs2 = await SharedPreferences
    .getInstance();
final key2 = 'mobile';
final apptok2 = userEmail;
prefs2.setString(key2, apptok2);
print(mobile);
print(mobile);
print('rahah')
;
print(raja);
Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));

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
