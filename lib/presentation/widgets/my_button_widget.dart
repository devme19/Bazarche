import 'package:bazarche/core/config/config.dart';
import 'package:flutter/material.dart';
class MyButtonWidget extends StatelessWidget {
  String title;
  IconData icon;
  bool isTaped;
  MyButtonWidget({this.title,this.icon,this.isTaped});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: isTaped?primaryColor:Colors.white,
        border: Border.all(color: primaryColor,width: 3),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(children: [
        Expanded(flex:2,child: Icon(icon,color:isTaped?Colors.white:primaryColor,size: 50,)),
        Expanded(child: Text(title,style: TextStyle(color: isTaped?Colors.white:primaryColor),)),
      ],),
    );
  }
}
