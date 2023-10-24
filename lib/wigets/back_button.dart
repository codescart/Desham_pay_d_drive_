import 'package:flutter/material.dart';

import '../app_constant.dart';

class back extends StatelessWidget {
  const back({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.pop(context);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 5,width: 5,
          decoration: BoxDecoration(
            border: Border.all(
              color: kTextLowBlackColor,
              width: 2,
            ), //Border.all
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: iCardColor,
                offset: const Offset(0.0, 0.0),
                blurRadius: 0.0,
                spreadRadius: 0.0,
              ), //BoxShadow
            ],
          ),
          child: Icon(Icons.arrow_back_ios,color: kTextLightColor,size: 14,),
        ),
      ),
    );
  }
}
