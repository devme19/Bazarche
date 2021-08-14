import 'package:bazarche/core/config/config.dart';
import 'package:bazarche/data/model/job_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BestListItemWidget extends StatelessWidget {
  Data data;
  BestListItemWidget({Key key,this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      height: 120,
      margin: EdgeInsets.symmetric(horizontal: 16.0,vertical: 3),
      padding: EdgeInsets.symmetric(horizontal: 8.0,vertical: 8),
      child:
      Row(children: [
        Expanded(
          flex: 1,
            child:
            Column(
              children: [
                Expanded(
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    child: data.job.profileImage!=null && data.job.profileImage!=''?
                    Image.network(uploadBaseUrl+'profileImages/'+data.job.profileImage,fit: BoxFit.cover,):

                    Opacity(
                      opacity: 0.3,
                        child: Image.asset('assets/icons/shop_Icon.png')),
        ),
                ),
              ],
            )),
        SizedBox(width: 20,),
        Expanded(flex:3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Row(children: [
                  Expanded(child: Text(data.job.title)),

                ],),
                Row(children: [

                  Expanded(child: Text(data.job.address,style: TextStyle(color: Colors.grey),)),

                ],),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        // width: 200,
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                child: Row(
                                  children: [
                                    SvgPicture.asset('assets/icons/star.svg'),
                                    SizedBox(width: 6.0,),

                                    Expanded(child: Text(double.parse(data.averageRate.toString()).toStringAsFixed(1)
                                        ,style: TextStyle(fontSize: 15))),
                                  ],
                                ),
                              ),
                            ),

                            Expanded(
                              child: Container(
                                child: Row(
                                  children: [
                                    SvgPicture.asset('assets/icons/checkin.svg'),
                                    SizedBox(width: 6.0,),

                                    Expanded(child: Text(data.job.checkIns.toString(),style: TextStyle(fontSize: 15))),
                                  ],
                                ),
                              ),
                            ),

                            Expanded(
                              child: Container(
                                child: Row(
                                  children: [
                                    SvgPicture.asset('assets/icons/comment.svg'),
                                    SizedBox(width: 6.0,),

                                    Expanded(child: Text(data.job.comments.toString(),style: TextStyle(fontSize: 15),)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],),
            )
        ),

      ],),
    );
  }
}
