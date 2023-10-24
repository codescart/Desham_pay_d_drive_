import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mp_pay/app_constant.dart';
import 'package:mp_pay/curved_painty.dart';
import 'package:mp_pay/wigets/back_button.dart';


class TermCondition extends StatefulWidget {
  const TermCondition({Key? key}) : super(key: key);

  @override
  State<TermCondition> createState() => _TermConditionState();
}

class _TermConditionState extends State<TermCondition> {
  var data;
  Future<void> termsCondition() async {
    print('aaaaaaa');
    final response = await http.get(Uri.parse(
        Apiconst.baseurl+"term_condition.php"));
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
            "Terms & Condition",
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
                    data[0]['term'].toString(),
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
