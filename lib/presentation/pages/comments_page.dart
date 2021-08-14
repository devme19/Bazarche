import 'package:bazarche/core/config/config.dart';
import 'package:bazarche/presentation/controllers/comments_page_controller.dart';
import 'package:bazarche/presentation/utils/state_status.dart';
import 'package:bazarche/presentation/widgets/comment_item_widget.dart';
import 'package:bazarche/presentation/widgets/connection_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:bazarche/data/model/job_profile_model.dart';
class CommentsPage extends GetView<CommentsPageController> {
  Data job;
  CommentsPage(){
    if(Get.arguments != null) {
      job = Get.arguments;
      controller.getComments(job.sId);
      controller.getOwnComment(job.sId);
    }
  }
  @override
  Widget build(BuildContext context) {
    return 
      
      SafeArea(
        child: Scaffold(
          body: Container(
          child:
          Obx(()=>
              NotificationListener<ScrollNotification>(
                onNotification: (scrollNotification){
                  if (scrollNotification.metrics.atEdge) {
                    if (scrollNotification.metrics.pixels != 0)
                      if(controller.comments.length > 0)
                        controller.getComments(job.sId);
                  }
                  return true;
                },
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child:
                      Column(
                        children: [
                          Container(
                            height: Get.height/3+50,
                            child:
                            Stack(
                              children: [
                                Container(
                                  margin:EdgeInsets.only(bottom:50.0),
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
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child:
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
                                        // ClipRRect(
                                        //   borderRadius: BorderRadius.only(bottomRight: Radius.circular(60),bottomLeft: Radius.circular(60)),
                                        //   child:
                                        //   job.profileImage!=null && job.profileImage!=''?
                                        //   Image.network(uploadBaseUrl+'jobs-profile/'+job.profileImage,fit: BoxFit.cover,):
                                        //   Opacity(
                                        //       opacity: 0.3,
                                        //       child: Image.asset('assets/icons/shop_Icon.png')),
                                        // ),
                                      ),

                                    ],
                                  ),
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
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child:
                                  Container(
                                    // color: Colors.red,
                                    padding: EdgeInsets.all(6.0),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(Radius.circular(16)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey,
                                            spreadRadius: 1,
                                            blurRadius: 3,
                                            offset: Offset(0, 1), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      width: 110,
                                      height: 110,
                                      // padding: EdgeInsets.only(left:16.0,top: 16.0),
                                      child:
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Opacity(
                                                opacity: 0.4,
                                                child: Icon(Icons.star_rate)),
                                          ),
                                          SizedBox(height:8.0),
                                          
                                          Expanded(child: Opacity(opacity:0.4,child: Text(
                                              (job.rate).toStringAsFixed(1)
                                          )
                                          )
                                          ),
                                          SizedBox(height:8.0),
                                          
                                          Expanded(child: Text('نظرات'))
                                        ],)
                                  ),
                                )
                              ],
                            ),
                          ),
                          // SizedBox(height: 40,),
                          // Text('امتیاز شما'),
                          SizedBox(height: 40,),
                          myComment(),
                          SizedBox(height: 40,),
                          // Text('نظرات'),
                        ],
                      ),

                    ),
                    buildList(),
                    controller.getCommentState.value == StateStatus.LOADING?
                    SliverToBoxAdapter(
                      child:
                      SpinKitRing(
                        color: primaryColor,
                        lineWidth: 2,
                      ),
                    ):SliverToBoxAdapter(child: Container(),)
                  ],
                ),
              )),
    ),
        ),
      );
  }
  Widget buildList(){
    if(controller.getCommentState.value == StateStatus.ERROR)
      return SliverToBoxAdapter(child: ConnectionError());
    if(controller.comments.length !=0)
    return SliverList(
      delegate:
      SliverChildBuilderDelegate((BuildContext context, int index) {
        return InkWell(
            onTap: () {
            },
            child: CommentItemWidget(
              comment: controller.comments[index],
            ));
      }, childCount: controller.comments.length),
    );
    else
    if(controller.getCommentState.value != StateStatus.LOADING)
      return SliverToBoxAdapter(child: Center(child: Text('نظری ثبت نشده است'),),);
    else return SliverToBoxAdapter(child: Container(),);
  }
  Widget myComment(){
    if(controller.getOwnCommentState.value == StateStatus.SUCCESS) {
      if (controller.ownComment.value.content != null) {
        return Column(
          // mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(60)),
                    child: Opacity(
                      opacity: 0.3,
                      child: Icon(
                        Icons.person,
                        size: 50,
                      ),
                    )),
                RatingBarIndicator(
                  rating: controller.ownComment.value.rate.toDouble(),
                  itemBuilder: (context, index) => Icon(
                    Icons.star,
                    color: primaryColor,
                  ),
                  itemCount: 5,
                  itemSize: 16.0,
                  direction: Axis.horizontal,
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(right: 16, left: 16.0),
              child: Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  // border: Border.all(color: primaryColor,width: 3),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child:
                    Container(child: Text(controller.ownComment.value.content)),
              ),
            )
          ],
        );
      } else
        if(controller.ownComment.value.rate != null)
        return
          Container(
            padding: EdgeInsets.all(8.0),
            margin: EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(color: Colors.grey.withOpacity(0.2),width: 2),
            ),
            child: Column(
            children: [
              Row(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(60)),
                      child: Opacity(
                        opacity: 0.3,
                        child: Icon(
                          Icons.person,
                          size: 50,
                        ),
                      )),
                  RatingBarIndicator(
                    rating: controller.ownComment.value.rate.toDouble(),
                    itemBuilder: (context, index) => Icon(
                      Icons.star,
                      color: primaryColor,
                    ),
                    itemCount: 5,
                    itemSize: 16.0,
                    direction: Axis.horizontal,
                  )
                ],
              ),
              TextFormField(
                maxLines: null,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                    filled: true,
                    hintText: 'نظر خود را بنویسید',
                    fillColor: Colors.grey.withOpacity(0.1),
                    focusedBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(borderRadius)),
                        borderSide: BorderSide.none),
                    border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(borderRadius)),
                        borderSide: BorderSide.none)),
              ),
              SizedBox(
                height: 16.0,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: primaryColor,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                    )),
                onPressed: () {},
                child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 16.0,
                    ),
                    child: Text('ثبت نظر')),
              ),
            ],
        ),
          );
      else
        return
          Container(
            padding: EdgeInsets.all(8.0),
            margin: EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.grey,
              //     spreadRadius: 1,
              //     blurRadius: 3,
              //     offset: Offset(0, 1), // changes position of shadow
              //   ),
              // ],
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(color: Colors.grey.withOpacity(0.2),width: 2),
            ),
            child: RatingBar.builder(
            initialRating: 0,
            // itemSize: 25,
            // minRating: 1,
            direction: Axis.horizontal,
            // allowHalfRating: true,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) async {
              await Future.delayed(Duration(seconds: 1));
              showDialog(
                  context: Get.context,
                  builder: (_) {
                    return AlertDialog(
                      title: Text('امتیاز ثبت شود؟'),
                      actions: [
                        FlatButton(
                          onPressed: () {
                            controller.sendRate(rating);
                            Navigator.pop(Get.context, true);
                          }, // passing true
                          child: Text('بله'),
                        ),
                        FlatButton(
                          onPressed: () => Navigator.pop(Get.context, false),
                          // passing false
                          child: Text('انصراف'),
                        ),
                      ],
                    );
                  });
            },
        ),
          );
    }else return Container();

    // return
    // controller.getOwnCommentState.value == StateStatus.SUCCESS?
    //     controller.ownComment.value.
    //   Column(
    //   // mainAxisAlignment: MainAxisAlignment.end,
    //   children: [
    //     Row(
    //
    //       children: [
    //         ClipRRect(
    //             borderRadius: BorderRadius.all(Radius.circular(60)),
    //             child:
    //             Opacity(
    //               opacity: 0.3,
    //               child: Icon(Icons.person,size: 50,),
    //             )
    //         ),
    //         RatingBarIndicator(
    //           rating: controller.rate,
    //           itemBuilder: (context, index) => Icon(
    //             Icons.star,
    //             color: primaryColor,
    //           ),
    //           itemCount: 5,
    //           itemSize: 16.0,
    //           direction: Axis.horizontal,
    //         )
    //
    //       ],
    //     ),
    //     Column(
    //       children: [
    //         TextFormField(
    //           maxLines: null,
    //
    //           textInputAction: TextInputAction.done,
    //           decoration: InputDecoration(
    //               filled: true,
    //               hintText: 'نظر خود را بنویسید',
    //               fillColor: Colors.grey.withOpacity(0.1),
    //               focusedBorder: OutlineInputBorder(
    //                   borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
    //                   borderSide: BorderSide.none
    //
    //               ),
    //               border:OutlineInputBorder(
    //                   borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
    //                   borderSide: BorderSide.none
    //               )
    //           ),
    //         ),
    //         SizedBox(height: 16.0,),
    //         ElevatedButton(
    //             style: ElevatedButton.styleFrom(
    //                 primary: primaryColor,
    //                 shape: new RoundedRectangleBorder(
    //                   borderRadius: new BorderRadius.circular(10.0),
    //                 )),
    //             onPressed:(){
    //             },
    //             child:
    //             Padding(
    //               padding: EdgeInsets.symmetric(vertical: 16.0,),
    //               child:
    //              Text('ثبت نظر')),
    //             ),
    //       ],
    //     )
    //     // Container(
    //     //   height: 200,
    //     //   child: TextField(),
    //     // ),
    //   ],
    // ):Container();
  }
}
