import 'package:bazarche/core/config/config.dart';
import 'package:bazarche/presentation/controllers/job_profile_page_controller.dart';
import 'package:bazarche/presentation/controllers/map_widget_controller.dart';
import 'package:bazarche/presentation/navigations/bazarche_app.dart';
import 'package:bazarche/presentation/utils/bazarche.dart';
import 'package:bazarche/presentation/utils/state_status.dart';
import 'package:bazarche/presentation/widgets/connection_error.dart';
import 'package:bazarche/presentation/widgets/image_widget.dart';
import 'package:bazarche/presentation/widgets/map_widget.dart';
import 'package:bazarche/presentation/widgets/map_widget_job_profile.dart';
import 'package:bazarche/presentation/widgets/my_box_widget.dart';
import 'package:bazarche/presentation/widgets/my_button_widget.dart';
import 'package:bazarche/presentation/widgets/working_hours_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';
import 'package:latlong/latlong.dart' as latLng;
import 'package:flutter_screenutil/flutter_screenutil.dart';



class JobProfilePage extends GetView<JobProfilePageController> {
  double spaceBetween = 20.h;
  String id;
  RxBool arrowUpVisible = false.obs;
  ScrollController scrollController = ScrollController();
  JobProfilePage(){
    id = Get.arguments;
    controller.getJobProfile(id);
    controller.getImages(id);
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels == 0) {
          // You're at the top.
          // Get.snackbar('title', 'reach top');
        } else {
          controller.getImages(id);
        }
      }
    });

  }
  @override
  Widget build(BuildContext context) {
    return
      SafeArea(
        child: Scaffold(
            body:
            Obx(()=>
            controller.getJobProfileStatus.value == StateStatus.LOADING?
            Center(child: SpinKitRing(color: primaryColor,lineWidth: 2,),):
            controller.getJobProfileStatus.value == StateStatus.SUCCESS?
            CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child:
                  Column(
                    children: [
                      Stack(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child:
                                Container(
                                  height: (Get.height/3).h,
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
                                              controller.jobProfile.value.profileImage!=null && controller.jobProfile.value.profileImage!=''?
                                              Image.network(uploadBaseUrl+'profileImages/'+controller.jobProfile.value.profileImage,fit: BoxFit.cover,):
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
                                          width: 80.w,
                                          height: 80.w,
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
                                // Container(
                                //   height: Get.height/3,
                                //   decoration: BoxDecoration(
                                //     // border: Border.all(width: 1,color: Colors.grey.withOpacity(0.3)),
                                //     borderRadius: BorderRadius.only(bottomRight: Radius.circular(65),bottomLeft: Radius.circular(65)),
                                //   ),
                                //   child: ClipRRect(
                                //     borderRadius: BorderRadius.only(bottomRight: Radius.circular(60),bottomLeft: Radius.circular(60)),
                                //     child:
                                //     controller.jobProfile.value.profileImage!=null && controller.jobProfile.value.profileImage!=''?
                                //     Image.network(uploadBaseUrl+'profileImages/'+controller.jobProfile.value.profileImage,fit: BoxFit.cover,):
                                //     Opacity(
                                //         opacity: 0.3,
                                //         child: Image.asset('assets/icons/shop_Icon.png')),
                                //   ),
                                // ),
                              ),

                            ],
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 32.0),
                        child: Column(
                          children: [
                            SizedBox(height: spaceBetween,),
                            Row(
                              children: [
                                Expanded(child: Text(controller.jobProfile.value.title,style: TextStyle(fontSize: 26.sp,),textAlign: TextAlign.center,)),
                              ],
                            ),
                            SizedBox(height: spaceBetween,),
                            Row(
                              children: [
                                Expanded(child: Text(controller.jobProfile.value.description,style: TextStyle(color: Colors.grey,height: 2),textAlign: TextAlign.center,)),
                              ],
                            ),
                            SizedBox(height: spaceBetween,),
                            WorkingHoursWidget(workingTime: controller.jobProfile.value.workingTime,),
                            SizedBox(height: spaceBetween,),
                            isFollowing(),
                            // Container(
                            //   margin: EdgeInsets.symmetric(horizontal: 32.0),
                            //   height: 70,
                            //   width: 250,
                            //   decoration: BoxDecoration(
                            //     border: Border.all(color: Colors.grey.withOpacity(0.2),width: 1),
                            //     borderRadius: BorderRadius.circular(25),
                            //   ),
                            //   child: Center(child: Text('در حال دنبال کردن',style: TextStyle(color: primaryColor),)),
                            // ),
                            Container(
                              height: 120.h,
                              margin: EdgeInsets.symmetric(horizontal: 16.0,vertical: 32.0),
                              child: Row(
                                children: [
                                  Expanded(child:
                                  InkWell(
                                      onTap:(){
                                        controller.onCommentsTapped();
                                      },
                                      child: MyBoxWidget(title: 'نظرات',value:(controller.jobProfile.value.rate).toStringAsFixed(1),icon: Icons.star,isTaped: controller.commentsTaped.value,))),
                                  SizedBox(width: 16.w,),
                                  Expanded(child:
                                  InkWell(
                                      onTap:(){
                                        controller.onCheckInsTapped(controller.jobProfile.value.sId);
                                      },
                                      child:
                                      MyBoxWidget(title: 'اعلام حضور',value: controller.checkInsCount.value.toString(),icon: Icons.check_circle,isTaped: controller.checkInsTaped.value,state: controller.addCheckInStatus.value,)
                                  )),
                                  SizedBox(width: 16.w,),
                                  Expanded(child:
                                  InkWell(
                                      onTap:(){
                                        controller.onSendImageTapped();
                                      },
                                      child: MyBoxWidget(title: 'ارسال تصویر',value: controller.images.length.toString(),icon: Icons.image,isTaped: controller.imageTaped.value,))),
                                ],
                              ),
                            ),
                            Divider(),
                            SizedBox(height: spaceBetween,),
                            Container(
                              child: Column(children: [
                                Row(children: [
                                  Text('اطلاعات'),
                                ],),
                                SizedBox(height: spaceBetween,),
                                Column(
                                  children: getInfo(),

                                )
                              ],),
                            ),
                            SizedBox(height: spaceBetween,),
                            Divider(),
                            SizedBox(height: spaceBetween,),
                            controller.images.length>0?
                            Container(
                                      height: 220.h,
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text('تصاویر'),
                                            ],
                                          ),
                                          SizedBox(height: spaceBetween,),
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: ListView.builder(
                                                    controller: scrollController,
                                                    scrollDirection:Axis.horizontal,

                                                    itemCount: controller.images.length,
                                                      itemBuilder: (context,index){
                                                    return
                                                      InkWell(
                                                        onTap: (){
                                                          Get.dialog(
                                                            Row(
                                                              children: [
                                                                Expanded(
                                                                  child:
                                                                  Container(
                                                                    padding: EdgeInsets.all(8.0),
                                                                    height:(Get.height/2).h,
                                                                    child: Swiper(
                                                                      pagination: new SwiperPagination(alignment: Alignment.bottomCenter),
                                                                      // control: new SwiperControl(),
                                                                      index: index,
                                                                      itemBuilder: (BuildContext context, int index) {
                                                                        return   ImageWidget(
                                                                          imagePath: controller.images[index].image,
                                                                            sId: controller.images[index].sId,
                                                                        );
                                                                      },
                                                                      // autoplay: true,
                                                                      itemCount: controller.images.length,
                                                                      // scrollDirection: Axis.vertical,
                                                                      // pagination: new SwiperPagination(alignment: Alignment.centerRight),
                                                                      // control: new SwiperControl(),
                                                                    ),
                                                                  ),
                                                                )

                                                              ],
                                                            )
                                                          );
                                                        },
                                                        child: controller.images[index].sId == null?
                                                    ImageWidget(
                                                        imagePath: controller.images[index].image,
                                                        sId: controller.images[index].sId,
                                                        status: controller.uploadImageStatus.value,
                                                        uploadedAmount: controller.uploadedValue.value,
                                                    ):
                                                    ImageWidget(
                                                        imagePath: controller.images[index].image,
                                                        sId: controller.images[index].sId,
                                                    ),
                                                      );
                                                    //   Container(
                                                    //     width: 180,
                                                    //     height: 180,
                                                    //     margin: EdgeInsets.only(left: spaceBetween),
                                                    //     child: ClipRRect(
                                                    //       borderRadius: BorderRadius.all(Radius.circular(20)),
                                                    //       child:Image.network(uploadBaseUrl+'job-images/'+controller.images[index].image,fit: BoxFit.cover,)
                                                    // ),
                                                    //   );
                                                  }),
                                                ),
                                                controller.getImageStatus.value == StateStatus.LOADING?
                                                    Container(
                                                      width: 25,
                                                      margin: EdgeInsets.only(right: 16.0),
                                                      child: Center(child: SpinKitRing(color: primaryColor,lineWidth: 1,),),
                                                    ):Container()
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: spaceBetween,),
                                          Divider(),
                                        ],
                                      ),
                                    ) :Container(),
                            // Divider(),
                            SizedBox(height: spaceBetween,),
                            Container(
                              height: 330.h,
                              child:
                              Stack(
                                children: [
                                  Container(
                                    height: 300.h,
                                    child: MapWidgetJobProfile(position: latLng.LatLng(
                                        controller.jobProfile.value.location.coordinates[1],
                                        controller.jobProfile.value.location.coordinates[0]
                                    ),),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: InkWell(
                                      onTap: ()=>controller.navigate(),
                                      child: Container(
                                        margin: EdgeInsets.symmetric(horizontal: 32.w),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey,
                                                spreadRadius: 0.2,
                                                blurRadius: 3,
                                                offset: Offset(0, 3), // changes position of shadow
                                              ),
                                            ],
                                            borderRadius: BorderRadius.all(Radius.circular(15))
                                        ),
                                        height: 70.h,

                                        child:
                                        Row(
                                          children: [

                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Icon(Icons.navigation),
                                            ),
                                            Expanded(child: Text(controller.jobProfile.value.address,style: TextStyle(fontSize: 12.sp),)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ),
                            SizedBox(height: spaceBetween,),
                            Divider(),
                            SizedBox(height: spaceBetween,),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: primaryColor,
                                          shape: new RoundedRectangleBorder(
                                            borderRadius: new BorderRadius.circular(15.0),
                                          )),
                                      onPressed:(){
                                        Get.toNamed(BazarcheAppRoutes.jobDetailPage,arguments: controller.jobProfile.value);
                                      },
                                      child:
                                      Container(
                                          height: 65.h,
                                          child:
                                          Center(
                                              child:
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text('اطلاعات بیشتر', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                                                  Text('(خدمات ، امکانات و ...)', style: TextStyle(fontSize: 15.sp,color: Colors.white),),
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Icon(Icons.arrow_forward_ios,color: Colors.white,),
                                                  )
                                                ],
                                              )
                                          )
                                      )
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spaceBetween,),
                          ],
                        ),
                      )


                    ],
                  ),
                )
              ],
            ):
            controller.getJobProfileStatus.value == StateStatus.ERROR?
            ConnectionError(parentAction: retry,):
            Container()
            )
        ),
      );
  }
  retry(bool value){
    controller.getJobProfile(id);
  }
  List<Widget> getInfo(){
    List<Widget> list=[];
    for(String phone in controller.jobProfile.value.phone)
      list.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Row(children: [
        Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                  )),
              onPressed:(){
               controller.call(phone);
              },
              child:
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.h,),
                  child:
                  Text('تماس')),
            ),
        ),
        SizedBox(width: 16.w,),
        Expanded(
            child: Row(
              children: [
                Text(phone),
                SizedBox(width:16.w),
                Icon(Icons.phone),
              ],
            ),
        )
      ],),
          ));
    return list;
  }
  Widget isFollowing(){
    controller.isFollow();
    // String id = Bazarche().followings.firstWhere((item) => item.sId==controller.jobProfile.value.sId).sId;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 32.w),
      height: 70.h,
      width: 250.w,
      decoration: BoxDecoration(
        color: !controller.isFollowing.value ? primaryColor: Colors.white,
        border: Border.all(color: Colors.grey.withOpacity(0.2),width: 1),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Center(child:
      controller.isFollowing.value?
      InkWell(
        onTap: (){
          controller.unFollowJob(controller.jobProfile.value.sId);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            controller.unFollowJobStatus.value == StateStatus.LOADING?
            Container(
              width: 20.w,
              height: 20.h,
               child: SpinKitRing(
                  color: primaryColor,
                 lineWidth: 1,
                )
            ):
            controller.unFollowJobStatus.value == StateStatus.ERROR?
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(children: [
                Icon(Icons.wifi_off,color: Colors.red,),
                SizedBox(height: 6.h,),
                Text('خطا در برقراری ارتباط',style: TextStyle(color: primaryColor),)
              ],),
            ):
            Row(
              children: [
                Container(
                    width: 20.w,
                    height: 20.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: primaryColor,width: 1),
                    ),
                    child: Icon(Icons.remove,color: primaryColor,size: 12.sp,)),
                SizedBox(width: 16.w,),
                Text('در حال دنبال کردن',style: TextStyle(color: primaryColor,fontWeight: FontWeight.bold),),

              ],
            ),
          ],
        ),
      ):
      InkWell(
        onTap: (){
          controller.followJob(controller.jobProfile.value.sId);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            controller.followJobStatus.value == StateStatus.LOADING?
            Container(
              width: 20.w,
              height: 20.h,
              child:SpinKitRing(
                color: Colors.white,
                lineWidth: 1,
              )
            ):
            controller.followJobStatus.value == StateStatus.ERROR?
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(children: [
                Icon(Icons.wifi_off,color: Colors.red,size: 12.sp,),
                SizedBox(height: 6.h,),
                Text('خطا در برقراری ارتباط',style: TextStyle(color: Colors.white),)
              ],),
            ):
            Row(
              children: [
                SvgPicture.asset('assets/icons/add.svg'),
                SizedBox(width: 16.w,),
                Text('دنبال کردن',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
              ],
            ),
          ],
        ),
      )
      ),
    );
  }
}
