import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserProfileItemWidget extends StatelessWidget {
  SvgPicture icon;
  String value;
  String title;


  UserProfileItemWidget({this.icon, this.value, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(

        children: [
        Expanded(child: Container(
            child: Center(child: icon))),
        Expanded(child: Container(
            child: Center(child: Text(value)))),
        Expanded(child: Container(
            child: Center(child: Text(title)))),
      ],),
    );
  }
}
