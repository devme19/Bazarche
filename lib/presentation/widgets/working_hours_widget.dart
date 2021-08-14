import 'package:bazarche/core/config/config.dart';
import 'package:bazarche/data/model/job_profile_model.dart';
import 'package:flutter/material.dart';

class WorkingHoursWidget extends StatelessWidget {

  String days,startTime,endTime;
  List<WorkingTime> workingTime;
  WorkingHoursWidget({this.workingTime});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex:1,child: Text('ساعات کاری')),
        Expanded(
          flex: 4,
          child: Column(children: hours(),),
        )
      ],
    );
  }
  List<Widget> hours(){
    List<Widget> rows =[];
    for(int i=0;i<workingTime.length;i++){
      rows.add(Container(
        height: 50,
        child: Row(
          children: [
            Expanded(flex:3,child: Text(workingTime[i].day,textAlign: TextAlign.center)),
            // SizedBox(width: 16,),
            Expanded(flex:1,child: Text(workingTime[i].opens.hour.toString()+':'+workingTime[i].opens.minute.toString(),style: TextStyle(color: primaryColor),textAlign: TextAlign.center,)),
            Expanded(child: Text('تا',textAlign: TextAlign.center,)),
            Expanded(flex:1,child:
            Container(
              // color: Colors.red,
                child: Text(workingTime[i].closes.hour.toString()+':'+workingTime[i].closes.minute.toString(),style: TextStyle(color: primaryColor),textAlign: TextAlign.center,))),
          ],
        ),
      ));
    }
    return
      rows;
  }
}
