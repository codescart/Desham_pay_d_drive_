import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mp_pay/2_report_page/dmt_history_recharge.dart';
import 'package:mp_pay/2_report_page/dth_recharge_history.dart';
import 'package:mp_pay/2_report_page/electrycity_recharge_history.dart';
import 'package:mp_pay/2_report_page/fundtransfer_history.dart';
import 'package:mp_pay/2_report_page/recharge_history_page.dart';
import 'package:mp_pay/Drawer_directory/wallet_history.dart';


class report_page extends StatefulWidget {
  // final amount;
  // const report_page({Key? key, required this.amount}) : super(key: key);
  @override
  _report_pageState createState() => _report_pageState();
}

class _report_pageState extends State<report_page> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(right: 10,left: 10,),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children:[

              DefaultTabController(
                  length: 5, // length of tabs
                  initialIndex: 0,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
                    Container(
                      child: TabBar(
                          unselectedLabelColor: Colors.redAccent,
                          indicatorSize: TabBarIndicatorSize.label,
                          indicatorColor: Colors.transparent,
                          indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.redAccent),
                          tabs: [
                            Tab(
                              child: Container(
                                // decoration: BoxDecoration(
                                //     borderRadius: BorderRadius.circular(15),
                                //     border: Border.all(color: Colors.redAccent, width: 1)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text("Recharge", style: TextStyle(fontFamily: "Windsor",fontSize: 8,fontWeight: FontWeight.bold)),
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text("History", style: TextStyle(fontFamily: "Windsor",fontSize: 8,fontWeight: FontWeight.bold)),
                                    ),

                                  ],
                                ),
                              ),
                            ),
                            Tab(
                              child: Container(
                                // decoration: BoxDecoration(
                                //     borderRadius: BorderRadius.circular(15),
                                //     border: Border.all(color: Colors.redAccent, width: 1)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text("DTH", style: TextStyle(fontFamily: "Windsor",fontSize: 8,fontWeight: FontWeight.bold)),
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text("History", style: TextStyle(fontFamily: "Windsor",fontSize: 8,fontWeight: FontWeight.bold)),
                                    ),

                                  ],
                                ),
                              ),
                            ),
                            Tab(
                              child: Container(
                                // decoration: BoxDecoration(
                                //     borderRadius: BorderRadius.circular(15),
                                //     border: Border.all(color: Colors.redAccent, width: 1)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text("Electricity", style: TextStyle(fontFamily: "Windsor",fontSize: 8,fontWeight: FontWeight.bold)),
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text("History", style: TextStyle(fontFamily: "Windsor",fontSize: 8,fontWeight: FontWeight.bold)),
                                    ),

                                  ],
                                ),
                              ),
                            ),
                            Tab(
                              child: Container(
                                // decoration: BoxDecoration(
                                //     borderRadius: BorderRadius.circular(50),
                                //     border: Border.all(color: Colors.redAccent, width: 1)),
                                child:Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text("DMT", style: TextStyle(fontFamily: "Windsor",fontSize: 8,fontWeight: FontWeight.bold)),
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text("History", style: TextStyle(fontFamily: "Windsor",fontSize: 8,fontWeight: FontWeight.bold)),
                                    ),

                                  ],
                                ),
                              ),
                            ),
                            Tab(
                              child: Container(
                                // decoration: BoxDecoration(
                                //     borderRadius: BorderRadius.circular(50),
                                //     border: Border.all(color: Colors.redAccent, width: 1)),
                                child:Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text("FUND", style: TextStyle(fontFamily: "Windsor",fontSize: 8,fontWeight: FontWeight.bold)),
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text("Recieve", style: TextStyle(fontFamily: "Windsor",fontSize: 8,fontWeight: FontWeight.bold)),
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          ]),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height*0.71,
                        decoration: BoxDecoration(
                            border: Border(top: BorderSide(color: Colors.grey, width: 0.5))
                        ),
                        child: TabBarView(
                            children:[


                              Container(
                                child: Recharge_history(),
                              ),
                              Container(
                                  child: DTHrechargehistory(),
                              ),
                              Container(
                                  child: electrycity_history(),
                              ),
                              Container(
                                  child: dmt_history(),
                              ),
                              Container(
                                child: fund_transfer(),
                              ),
                            ])
                    )
                  ])
              ),
            ]),
      ),
    );
  }
}
