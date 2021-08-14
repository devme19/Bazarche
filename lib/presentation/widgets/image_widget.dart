import 'dart:io';

import 'package:bazarche/core/config/config.dart';
import 'package:bazarche/presentation/controllers/job_profile_page_controller.dart';
import 'package:bazarche/presentation/utils/state_status.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ImageWidget extends GetView<JobProfilePageController>{
  String imagePath;
  StateStatus status;
  String sId;
  double uploadedAmount;


  ImageWidget({this.imagePath, this.status, this.sId,this.uploadedAmount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      width: 190.w,
      height: 190.h,
      margin: EdgeInsets.all(8.0),
      child:
      buildImage()
    );
  }
  Widget buildImage(){
    if(sId == null)
     return Stack(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child:Image.file(File(imagePath),fit: BoxFit.cover,height: 150.h,width: 150.w,)
          ),
          Obx(()=>
          controller.uploadImageStatus.value == StateStatus.LOADING?
          Align(
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.withOpacity(0.4)
              ),
              child: CircularPercentIndicator(
                radius: 60.0,
                lineWidth: 5.0,
                percent: controller.uploadedValue.value,
                center: new Text(( controller.uploadedValue.value*100).round().toString()+'%',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                progressColor: Colors.green,
              ),
            ),
          ):controller.uploadImageStatus.value == StateStatus.SUCCESS?
          Padding(
            padding: const EdgeInsets.only(top:3.0,right: 3.0),
            child: FadeTransition(
              opacity: controller.fadeInFadeOut,
              child: Icon(Icons.check_circle,size: 30,color: Colors.green,),
            ),
          ):Container()
          )
        ],
      );
    else
    if(sId == ''){
     return ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child:Image.file(File(imagePath),fit: BoxFit.cover,height: 190.h,width: 190.w,)
      );
    }
    else
      return ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child:CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl:uploadBaseUrl+'job-images/'+imagePath,
            // placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          )
      );
  }
}
