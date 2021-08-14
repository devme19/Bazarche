import 'package:bazarche/core/config/config.dart';
import 'package:bazarche/presentation/controllers/user_profile_page_controller.dart';
import 'package:bazarche/presentation/navigations/bazarche_app.dart';
import 'package:bazarche/presentation/utils/state_status.dart';
import 'package:bazarche/presentation/widgets/connection_error.dart';
import 'package:bazarche/presentation/widgets/user_profile_item_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class UserProfilePage extends GetView<UserProfilePageController> {
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(),
        body: Obx(()=>
            controller.getUserProfileState.value == StateStatus.LOADING?
            Center(
              child:
              SpinKitRing(
                color: primaryColor,
                lineWidth: 2,
              ),
            ):
            controller.getUserProfileState.value == StateStatus.ERROR?
            Center(child: ConnectionError(),):
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 16.0),
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      spreadRadius: 1,
                                      blurRadius: 3,
                                      offset: Offset(0, 1), // changes position of shadow
                                    ),
                                  ],
                                  borderRadius: BorderRadius.all(Radius.circular(16))
                              ),
                              height: 200,
                              child:
                              Row(
                                children: [
                                  Container(
                                    width: 180,
                                    height: 180,
                                    margin: EdgeInsets.all(10.0),
                                    padding: EdgeInsets.all(6.0),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.3),
                                            spreadRadius: 1,
                                            blurRadius: 3,
                                            offset: Offset(0, 1), // changes position of shadow
                                          ),
                                        ],
                                        borderRadius: BorderRadius.all(Radius.circular(100))
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.all(Radius.circular(100)),
                                      child:controller.userProfile.value.data.profileImage == null || controller.userProfile.value.data.profileImage == ''?
                                      Opacity(
                                          opacity: 0.3,
                                          child: SvgPicture.asset('assets/icons/person.svg')):
                                      Image.network(uploadBaseUrl+'profileImages/${controller.userProfile.value.data.profileImage}',fit: BoxFit.contain,),
                                    ),
                                  ),

                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(right: 32.0),
                                      child: Column(
                                        // mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child:
                                            Row(
                                              children: [
                                                Expanded(child:
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        
                                                        Expanded(child: Text(controller.userProfile.value.data.fullname)),
                                                      ],
                                                    ),
                                                    SizedBox(height: 20,),
                                                    Row(
                                                      children: [
                                                        Expanded(child: Text(controller.userProfile.value.data.bio)),
                                                      ],
                                                    )
                                                  ],
                                                )),
                                              ],
                                            ),
                                          ),
                                          InkWell(
                                            onTap: (){
                                              Get.toNamed(BazarcheAppRoutes.editUserProfilePage,
                                                  arguments: controller.userProfile.value
                                              ).then((value) =>controller.onInit());
                                            },
                                            child: Row(
                                              children: [
                                                Text('ویرایش'),
                                                SizedBox(width: 10.0,),
                                                SvgPicture.asset('assets/icons/edit.svg')
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 16.0,)
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 25.0,),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      spreadRadius: 1,
                                      blurRadius: 3,
                                      offset: Offset(0, 1), // changes position of shadow
                                    ),
                                  ],
                                  borderRadius: BorderRadius.all(Radius.circular(16))
                              ),
                              padding: EdgeInsets.all(16.0),
                              height: 150,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: UserProfileItemWidget(
                                      icon: SvgPicture.asset('assets/icons/comment1.svg',width: 30,height: 30,),
                                      value: '0',
                                      title: 'نظرات داده شده',
                                    ),
                                  ),
                                  
                                  Expanded(
                                    child: UserProfileItemWidget(
                                      icon: SvgPicture.asset('assets/icons/group.svg',width: 30,height: 30,),
                                      value: controller.userProfile.value.data.following.toString(),
                                      title: 'در حال دنبال کردن',
                                    ),
                                  ),
                                  
                                  Expanded(
                                    child: UserProfileItemWidget(
                                      icon: SvgPicture.asset('assets/icons/checkin.svg',width: 30,height: 30,),
                                      value: controller.userProfile.value.data.checkIns.toString(),
                                      title: 'اعلام حضور',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 25.0,),
                            Divider(),
                            SizedBox(height: 20.0,),
                            Row(
                              children: [
                                Text('در حال دنبال کردن'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SliverToBoxAdapter(child:  SizedBox(height: 25.0,),),
                      controller.getFollowingState.value == StateStatus.LOADING?
                          SliverToBoxAdapter(
                            child: SpinKitRing(
                              color: primaryColor,
                              lineWidth: 2,
                            ),
                          ):
                          controller.getFollowingState.value == StateStatus.ERROR?
                              SliverToBoxAdapter(
                                child: ConnectionError(),
                              ):
                              controller.getFollowingState.value == StateStatus.SUCCESS?
                              SliverPadding(
                                padding: EdgeInsets.all(4),
                                sliver: SliverGrid(
                                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 200.0,
                                    mainAxisSpacing: 20.0,
                                    crossAxisSpacing: 20.0,
                                    childAspectRatio: 0.9,
                                  ),
                                  delegate: SliverChildBuilderDelegate(
                                        (BuildContext context, int index) {
                                      return
                                        InkWell(
                                          onTap: ()=>Get.toNamed(BazarcheAppRoutes.jobProfilePage,arguments: controller.followingList[index].sId),
                                          child: Column(
                                          children: [
                                            Expanded(
                                              flex:5,
                                              child: Container(
                                                padding: EdgeInsets.all(3.0),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey.withOpacity(0.6),
                                                        spreadRadius: 1,
                                                        blurRadius: 3,
                                                        offset: Offset(0, 1), // changes position of shadow
                                                      ),
                                                    ],
                                                    borderRadius: BorderRadius.all(Radius.circular(15))
                                                ),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                                  child:
                                                  controller.followingList[index].profileImage =='' ||
                                                      controller.followingList[index].profileImage == null?
                                                    Image.asset('assets/icons/shop_Icon.png'):
                                                  Padding(
                                                    padding: const EdgeInsets.all(0.0),
                                                    child: CachedNetworkImage(imageUrl: uploadBaseUrl+'profileImages/'+controller.followingList[index].profileImage,fit: BoxFit.cover,),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 16.0,),
                                            Expanded(flex:2,child: Text(controller.followingList[index].title,textAlign: TextAlign.center,style: TextStyle(fontSize: 12),)),
                                          ],
                                      ),
                                        );
                                    },
                                    childCount: controller.followingList.length,
                                  ),
                                ),
                              ):
                                  SliverToBoxAdapter(child: Container(),)

                    ],
                  ),
                )

        )
      );
  }
}
