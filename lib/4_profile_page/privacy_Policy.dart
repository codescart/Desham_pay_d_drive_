import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mp_pay/app_constant.dart';
import 'package:mp_pay/curved_painty.dart';
import 'package:mp_pay/wigets/back_button.dart';


class Privacy extends StatefulWidget {
  const Privacy({Key? key}) : super(key: key);

  @override
  State<Privacy> createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {
  var data;
  Future<void> termsCondition() async {
    print('aaaaaaa');
    final response = await http.get(Uri.parse(
        Apiconst.baseurl+"privacy.php"));
    final datas = jsonDecode(response.body);
    print('aaaaaaaaaaaa');
    print(datas);
    if (datas['status'] == '200') {
      setState(() {
        data = datas['data'];
      });
      print(data);
    } else {}
  }

  @override
  void initState() {
    termsCondition();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).cardColor,
        appBar: AppBar(
          backgroundColor: kBackgroundColor,
          leading: back(),
          title: Text(
            "Privacy Policies ",
            style: TextStyle(
              fontFamily: "Windsor",
              color: kTextLowBlackColor,
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                  padding: const EdgeInsets.all(8.0),
                  physics: const BouncingScrollPhysics(),
                  child: data == null
                      ? Container()
                      : Text(
                    data[0]['privacy_policy'].toString(),
                    textAlign: TextAlign.justify,style: TextStyle(fontFamily: "Windsor"),
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
