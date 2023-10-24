import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mp_pay/app_constant.dart';
import 'package:mp_pay/curved_painty.dart';
import 'package:mp_pay/login_directory/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';


class signup extends StatefulWidget {
  const signup({Key? key}) : super(key: key);

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {

  @override
  void initState() {
    this.country();
    this.state();
    super.initState();
  }
  List country_data = [];
  String ?provider ;
  String ?rajya ;
  List state_data = [];


  bool hidePassword = true;
  bool _isLoading = false;
  final _UserNameController = TextEditingController();
  final _mobileNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _storeController = TextEditingController();
  final _panController = TextEditingController();
  final _adharController = TextEditingController();
  final _cityController = TextEditingController();
  final _pinController = TextEditingController();
    final _addressController = TextEditingController();


  Future<String> country() async {
    final res = await http.get(
        Uri.parse(Apiconst.baseurl2+'member_api.php'));
    final resBody = json.decode(res.body);
    print("gggggggggggggggg");
    print(resBody);
    setState(() {
      country_data = resBody;
    });



    return "Sucess";
  }

  Future<String> state() async {
    final res = await http.get(
        Uri.parse(Apiconst.baseurl2+'state_api.php')
    );
    final resBody = json.decode(res.body);
    print("hhhhhhhhhhhhh");
    print(resBody);
    setState(() {
      state_data = resBody;
    });



    return "Sucess";
  }


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
          bottomNavigationBar: BottomAppBar(

            child: Container(
              height: 100,
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: _isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0,
                          right: 15,
                          top: 10,
                          bottom: 10),
                      child: MaterialButton(
                        elevation: 0,
                        onPressed: (){
                          Register(_UserNameController.text, _mobileNameController.text,_emailController.text, _passwordController.text,
                              _storeController.text,_panController.text, _adharController.text,
                              _cityController.text,_pinController.text,_addressController.text);
                        },
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: const [
                            Text(
                              'SIGN UP',
                               style: TextStyle(fontFamily: "Windsor",
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        color: kRedColor,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadiusDirectional.circular(10),
                          // side: const BorderSide(color: kRedColor),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account?',
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
                                builder: (context) => login(),
                              ),
                            );
                          },
                          child: const Text(
                            ' Sign In',
                             style: TextStyle(fontFamily: "Windsor",
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              // width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.height,
              child:  CustomPaint(
                painter: SplashPainter(
                ),
                child: Column(
              children:[
                const SizedBox(
                  height: 75,
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
                  height: 45,
                ),
                const Text(
                  'Sign Up',
                   style: TextStyle(fontFamily: "Windsor",
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  height: 45,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 17.0, bottom: 5.0),
                    child: Text(
                      'User Name',
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
                    decoration:
                    getInputDecoration('User Name', Icons.person),
                    keyboardType: TextInputType.name,
                    controller: _UserNameController,
                    // ignore: missing_return
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'First name cannot be empty';
                      }
                    },
                    onSaved: (value) {
                      // _authData['email'] = value.toString();
                      _UserNameController.text = value as String;
                    },
                  ),
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 17.0, bottom: 5.0),
                    child: Text(
                      'Mobile Number',
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
                      'Mobile Number',
                      Icons.phone_iphone,
                    ),
                    keyboardType: TextInputType.number,
                    controller: _mobileNameController,
                    // ignore: missing_return
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Number cannot be empty';
                      }
                    },
                    onSaved: (value) {
                      // _authData['email'] = value.toString();
                      _mobileNameController.text = value as String;
                    },
                  ),
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 17.0, bottom: 5.0),
                    child: Text(
                      'Email',
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
                      'Email',
                      Icons.email_outlined,
                    ),
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (input) =>
                    !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                        .hasMatch(input!)
                        ? "Email Id should be valid"
                        : null,
                    onSaved: (value) {
                      // _authData['email'] = value.toString();
                      _emailController.text = value as String;
                    },
                  ),
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 17.0, bottom: 5.0),
                    child: Text(
                      'Store',
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
                    decoration:
                    getInputDecoration('Store Name', Icons.store_outlined),
                    keyboardType: TextInputType.name,
                    controller: _storeController,
                    // ignore: missing_return
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Store name cannot be empty';
                      }
                    },
                    onSaved: (value) {
                      // _authData['email'] = value.toString();
                      _storeController.text = value as String;
                    },
                  ),
                ),
                Align(
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
                      // _authData['password'] = input.toString();
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
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 17.0, bottom: 5.0),
                    child: Text(
                      'Pan Number',
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
                      'Pan Number',
                      Icons.credit_card,
                    ),
                    keyboardType: TextInputType.name,
                    controller: _panController,
                    // ignore: missing_return
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Pan number cannot be empty';
                      }
                    },
                    onSaved: (value) {
                      // _authData['email'] = value.toString();
                      _panController.text = value as String;
                    },
                  ),
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 17.0, bottom: 5.0),
                    child: Text(
                      'Adhar Number',
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
                      'Adhar Number',
                      Icons.credit_card,
                    ),
                    keyboardType: TextInputType.name,
                    controller: _adharController,
                    // ignore: missing_return
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'adhar number cannot be empty';
                      }
                    },
                    onSaved: (value) {
                      // _authData['email'] = value.toString();
                      _adharController.text = value as String;
                    },
                  ),
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 17.0, bottom: 5.0),
                    child: Text(
                      'Member',
                       style: TextStyle(fontFamily: "Windsor",
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 55,width: 360,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
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
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        dropdownColor: iCardColor,
                        hint: Row(
                          children: [
                            Icon(
                              Icons.people_alt_outlined,
                              color: kTextLowBlackColor,
                              size: 25,
                            ),
                            SizedBox(width: 10,),
                            Text('Select your Member'),
                          ],
                        ),
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
                              value:  item['slug'].toString()
                          );
                        }).toList(),
                        onChanged: (value) async {
                          setState(() {
                            provider = value as String ;

                          }
                          );

                        },
                        value: provider,
                      ),
                    ),
                  ),
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 17.0, bottom: 5.0),
                    child: Text(
                      'City',
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
                      'City',
                      Icons.location_city,
                    ),
                    keyboardType: TextInputType.name,
                    controller: _cityController,
                    // ignore: missing_return
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'city cannot be empty';
                      }
                    },
                    onSaved: (value) {
                      // _authData['email'] = value.toString();
                      _cityController.text = value as String;
                    },
                  ),
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 17.0, bottom: 5.0),
                    child: Text(
                      'Pin Code',
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
                      'Pin Code',
                      Icons.pin,
                    ),
                    keyboardType: TextInputType.name,
                    controller: _pinController,
                    // ignore: missing_return
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Pin cannot be empty';
                      }
                    },
                    onSaved: (value) {
                      // _authData['email'] = value.toString();
                      _pinController.text = value as String;
                    },
                  ),
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 17.0, bottom: 5.0),
                    child: Text(
                      'State',
                       style: TextStyle(fontFamily: "Windsor",
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 55,width: 360,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
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
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        dropdownColor: iCardColor,
                        hint: Row(
                          children: [
                            Icon(
                              Icons.maps_home_work_outlined,
                              color: kTextLowBlackColor,
                              size: 25,
                            ),
                            SizedBox(width: 10,),
                            Text('Select your State'),
                          ],
                        ),
                        items: state_data.map((item) {
                          return DropdownMenuItem(
                              child:  Text(
                                item['statename'].toString()
                                , overflow: TextOverflow.clip,
                                // maxLines: ,
                                softWrap: false,
                                 style: TextStyle(fontFamily: "Windsor",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              value: item['statename'].toString()
                          );
                        }).toList(),
                        onChanged: (value) async {
                          setState(() {
                            rajya = value as String ;

                          }
                          );

                        },
                        value: rajya,
                      ),
                    ),
                  ),
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 17.0, bottom: 5.0),
                    child: Text(
                      'Address',
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
                    decoration:
                    getInputDecoration('Address', Icons.map),
                    keyboardType: TextInputType.name,
                    controller: _addressController,
                    // ignore: missing_return
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Address cannot be empty';
                      }
                    },
                    onSaved: (value) {
                      // _authData['email'] = value.toString();
                      _addressController.text = value as String;
                    },
                  ),
                ),
                SizedBox(height: 30,),
              ],
           ),
          ),
            ),
          ),

        )
    );
  }
  Register(String _UserNameController, String _mobileNameController  , String _emailController, String _passwordController,
      String _storeController, String _panController, String _adharController,
      String _cityController, String _pinController,String _addressController ) async {
    print(Apiconst.baseurl+'android/auth/register?'+Apiconst.token+
        'name=$_UserNameController&mobile=$_mobileNameController'+
        '&email=$_emailController&password=$_passwordController'+
        '&shopname=$_storeController&pancard=$_panController&aadharcard=$_adharController&city=$_cityController'
        +'&pincode=$_pinController&address=$_addressController&slug=$provider&state=$rajya');
    final response = await http.post(
      Uri.parse(
          Apiconst.baseurl+'android/auth/register?'+Apiconst.token+
              'name=$_UserNameController&mobile=$_mobileNameController'+
                  '&email=$_emailController&password=$_passwordController'+
                  '&shopname=$_storeController&pancard=$_panController&aadharcard=$_adharController&city=$_cityController'
                  +'&pincode=$_pinController&address=$_addressController&slug=$provider&state=$rajya'

        ),
    );
    final data = jsonDecode(response.body);
    print(data);
    if (data['status'] == 'TXN') {

      Fluttertoast.showToast(
          msg: "Register SucessFully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      print("Register SucessFully");

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
