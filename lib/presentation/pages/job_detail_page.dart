import 'package:bazarche/core/config/config.dart';
import 'package:bazarche/data/model/all_services_model.dart' as serviceModel;
import 'package:bazarche/data/model/all_facilities_model.dart' as facilityModel;
import 'package:bazarche/presentation/utils/bazarche.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:bazarche/data/model/job_profile_model.dart';
class JobDetailPage extends StatelessWidget {
  Data job;
  List<String> facilities=[];
  JobDetailPage(){
    if(Get.arguments != null){
      job = Get.arguments;
      String title;
      for(String item in job.facilities) {
        title = Bazarche()
            .allFacilitiesEntity
            .data
            .firstWhere((e) => e.sId == item)
            .name;
        facilities.add(title);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(),
        body: Container(
          child:
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child:
                Column(
                  children: [
                    Container(
                      height: Get.height/3,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(60),bottomLeft: Radius.circular(60)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: Offset(0, 1), // changes position of shadow
                          ),
                        ],
                      ),
                      child:
                      Stack(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(60),bottomLeft: Radius.circular(60)),
                                  child:
                                  job.profileImage!=null && job.profileImage!=''?
                                  Image.network(uploadBaseUrl+'profileImages/'+job.profileImage,fit: BoxFit.cover,):
                                  Opacity(
                                      opacity: 0.3,
                                      child: Image.asset('assets/icons/shop_Icon.png')),
                                ),
                              ),

                            ],
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child:
                            Container(
                              // color: Colors.red,
                              width: 80,
                              height: 80,
                              padding: EdgeInsets.only(left:16.0,top: 16.0),
                              child:
                              InkWell(
                                onTap: () {
                                  // mapWidgetController.getCurrentPosition();
                                  Get.back();
                                },
                                child: Container(

                                  // padding: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(
                                          0.3),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))
                                  ),
                                  // margin: EdgeInsets.only(
                                  //     bottom: 16.0),
// color: Colors.grey.withOpacity(0.5),
//                                     width: 45,
//                                     height: 45,
                                  child:Icon(Icons.arrow_forward_sharp),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 30,),
                    Container(
                      padding: EdgeInsets.all(16.0),
                      child: Column(children: [
                        Text(job.title,style: TextStyle(fontWeight: FontWeight.bold),),
                        SizedBox(height: 30,),
                        Text(job.description,),
                        SizedBox(height: 30),
                        Divider(),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Text('خدمات',style: TextStyle(fontWeight: FontWeight.bold))
                          ],
                        ),
                        SizedBox(height: 20,),
                        Container(
                          height: 100,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: services(),
                          ),
                        ),
                        SizedBox(height: 30),
                        Divider(),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Text('امکانات',style: TextStyle(fontWeight: FontWeight.bold))
                          ],
                        ),
                        // SizedBox(height: 20,),
                      ],),
                    ),

                  ],
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 16.0),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200.0,
                    mainAxisSpacing: 5.0,
                    crossAxisSpacing: 5.0,
                    childAspectRatio: 2.5,
                  ),
                  delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      return Container(

                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey.withOpacity(0.2),width: 2),
                            // boxShadow: [
                            //   BoxShadow(
                            //     color: Colors.grey,
                            //     spreadRadius: 0.5,
                            //     blurRadius: 0.1,
                            //     offset: Offset(0, 1), // changes position of shadow
                            //   ),
                            // ],
                            borderRadius: BorderRadius.circular(20)
                        ),

                        child: 
                        Center(child: Text(facilities[index],textAlign: TextAlign.center,style: TextStyle(color: Colors.grey),)),
                      );
                    },
                    childCount: facilities.length,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  List<Widget> services(){
    List<Widget> list =[];
    serviceModel.Data service;
    for(String item in job.services) {
      service = Bazarche().allServicesEntity.data.firstWhere((e) => e.sId == item);
      list.add(Container(
        padding: EdgeInsets.all(16.0),
        margin: EdgeInsets.only(right: 6.0),
        decoration: BoxDecoration(
          color: Colors.white,
            border: Border.all(color: Colors.grey.withOpacity(0.2),width: 2),
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.grey,
            //     spreadRadius: 0.2,
            //     blurRadius: 1,
            //     offset: Offset(0, 1), // changes position of shadow
            //   ),
            // ],
          borderRadius: BorderRadius.circular(16)
        ),
        width: 100,
        // height: 100,
        child: SvgPicture.network(uploadBaseUrl+'services/${service.icon}',color: Color(int.parse('0xff${service.color}')),),
      ));
    }
    return list;
  }
}
