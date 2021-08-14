import 'package:bazarche/core/config/config.dart';
import 'package:bazarche/presentation/utils/state_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class MyBoxWidget extends StatelessWidget {
  String title;
  String value;
  IconData icon;
  bool isTaped;
  StateStatus state;

  MyBoxWidget({this.title,this.value,this.icon,this.isTaped,this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 100,
      // height: 100,,
      decoration: BoxDecoration(
        color: isTaped?primaryColor:Colors.white,
        border: Border.all(color: Colors.grey.withOpacity(0.2),width: 1),
        borderRadius: BorderRadius.circular(25),
      ),
      child:
      state == StateStatus.ERROR?
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.wifi_off,color: Colors.red,),
            SizedBox(height: 6.0,),
            Text('خطا در برقراری ارتباط',style: TextStyle(color: Colors.white),textAlign: TextAlign.center,)
          ],),
      ):
      Column(children: [
        Expanded(child: Icon(icon,color:isTaped?Colors.white:Colors.grey,)),
        state == StateStatus.LOADING?
        Expanded(
          child: Container(
              width: 20.w,
              height: 20.h,
              child: SpinKitRing(
                color: Colors.white,
                lineWidth: 1,
              )
          ),
        ):
        Expanded(child: Text(value,style: TextStyle(color: isTaped?Colors.white:Colors.grey))),
        Expanded(child: Text(title,style: TextStyle(color: isTaped?Colors.white:Colors.grey),)),
      ],),
    );
  }
}
