import 'package:bazarche/core/config/config.dart';
import 'package:bazarche/presentation/controllers/home_page_controller.dart';
import 'package:bazarche/presentation/controllers/map_widget_controller.dart';
import 'package:bazarche/presentation/navigations/bazarche_app.dart';
import 'package:bazarche/presentation/utils/bazarche.dart';
import 'package:bazarche/presentation/utils/state_status.dart';
import 'package:bazarche/presentation/widgets/best_list_item_widget.dart';
import 'package:bazarche/presentation/widgets/category_item_widget.dart';
import 'package:bazarche/presentation/widgets/category_item_widget_map_view.dart';
import 'package:bazarche/presentation/widgets/connection_error.dart';
import 'package:bazarche/presentation/widgets/map_widget.dart';
import 'package:bazarche/presentation/widgets/user_profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import "package:latlong/latlong.dart" as latLng;
class HomePage extends GetView<HomePageController> {
  AutoScrollController menuAutoScrollController = AutoScrollController();
  AutoScrollController subMenuAutoScrollController = AutoScrollController();
  MapWidgetController mapWidgetController = Get.put(MapWidgetController());
  FocusScopeNode currentFocus;
  UnfocusDisposition disposition = UnfocusDisposition.scope;
  Map<String, dynamic> jsonMap = new Map();
  // ScrollController scrollController1 = ScrollController();
  // HomePage(){
  //   scrollController1.addListener(() {
  //     if (scrollController1.position.atEdge) {
  //       if (scrollController1.position.pixels == 0) {
  //         // You're at the top.
  //         Get.snackbar('title', 'reach top');
  //       } else {
  //         Get.snackbar('title', 'reach end');
  //       }
  //     }
  //   });
  // }
  TextEditingController searchTxtController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
          resizeToAvoidBottomInset: false,
          body:
          SafeArea(
              child:
              Stack(
                children: [
                  Container(
                    child: MapWidget(),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: 16.0, left: 16,right: 16),
                    height: 220.h,
                    child:
                    Column(
                      children: [
                        Container(
                          // color:Colors.green,
                          height: 120.w,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: TextFormField(
                                  onEditingComplete: (){
                                    controller.pageIndex = 1;
                                    controller.jobs.clear();
                                    controller.getJobsBySearch(searchTxtController.text);
                                    currentFocus = FocusScope.of(context);
                                    if (!currentFocus.hasPrimaryFocus) {
                                      currentFocus.unfocus();
                                    }
                                  },
                                  style: TextStyle(fontSize: 15.sp),
                                  autovalidateMode: AutovalidateMode
                                      .onUserInteraction,

                                  controller: searchTxtController,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.done,
// onEditingComplete: () => node.nextFocus(),
                                  decoration: InputDecoration(
                                      counter: Offstage(),
                                      filled: true,
                                      fillColor: Colors.white.withOpacity(0.9),
                                      hintText: 'جستجو در مشاغل ...',
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15.h)),
// borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                                          borderSide: BorderSide.none

                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15.h)),
// borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                                          borderSide: BorderSide.none
                                      )
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  // color: Colors.red,
                                  margin: EdgeInsets.only(left: 16,bottom: 10.0),
                                  // color: Colors.red,
                                  child: searchTxtController.text ==''?SvgPicture.asset(
                                      'assets/icons/search.svg'):InkWell(
                                    onTap: (){
                                      searchTxtController.clear();
                                      controller.getNearLocations(true);
                                    },
                                    child: Icon(Icons.close),),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                mapWidgetController.getCurrentPosition();
                              },
                              child: Container(
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                    color: primaryColor.withOpacity(0.8),
                                    shape: BoxShape.circle,
                                    // borderRadius: BorderRadius.all(
                                    //     Radius.circular(15))
                                ),
                                margin: EdgeInsets.only(
                                    bottom: 16.0),
// color: Colors.grey.withOpacity(0.5),
//                                 width: 100.w,
//                                 height: 100.h,
                                child:
                                Center(child: Icon(Icons.my_location,color: Colors.white,)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  // NotificationListener<DraggableScrollableNotification>(
                  //   onNotification: (notification) {
                  //     // if(notification is ScrollEndNotification){
                  //     //   Get.snackbar('title', 'message');
                  //     // }
                  //     // print(notification.minExtent.toString());
                  //     // if (notification.extent ==
                  //     //     notification.maxExtent)
                  //     //   Get.snackbar('title', 'message');
                  //     // else
                  //     //   controller.arrowUpVisible.value = false;
                  //     return true;
                  //   },
                  //   child:
                    DraggableScrollableSheet(
                        initialChildSize: 0.35,
                        minChildSize: 0.24,
                        maxChildSize: 1,
                        builder: (BuildContext context,scrollController){
                          return Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.withOpacity(0.12),width: 3),
                                color: Colors.grey.shade100.withOpacity(0.9),
                                // borderRadius: BorderRadius.circular(50.0),
                              ),

                              child:
                                Obx(()=>
                                    NotificationListener<ScrollNotification>(
                                      onNotification: (scrollNotification){
                                        if (scrollNotification.metrics.atEdge) {
                                          if (scrollNotification.metrics.pixels != 0)
                                            if(controller.jobs.length > 0)
                                              controller.getBestJobs();

                                        }
                                        return true;
                                      },
                                      child: CustomScrollView(
                                        controller: scrollController,
                                        slivers: [
                                          SliverToBoxAdapter(child:
                                          Column(
                                            children: [
                                              controller.arrowUpVisible.value?
                                              Container(
                                                // color: primaryColor.withOpacity(0.1),
                                                  height: 60.h,
                                                  child:
                                                  Center(
                                                    child: Opacity(
                                                        opacity: 0.6,
                                                        child: Icon(Icons.keyboard_arrow_up)),
                                                  )
                                              ):Container(),
                                              // Divider(),
                                              SizedBox(height: 10.h,),
                                              Container(
                                                padding: EdgeInsets.only(right: 16.0),
                                                height: (0.2).sw,
                                                child:
                                                buildCategory(),
                                              ),

                                              controller.getSubListStatus.value ==
                                                  StateStatus.SUCCESS ?
                                              Container(
                                                  height: 0.12.sw,
                                                  // color: Colors.yellow,
                                                  margin: EdgeInsets.only(top: 16.0,right: 16.0),
                                                  child: buildSubCategory(false)
                                              ) : Container(),
                                              Divider(),
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(
                                                        horizontal: 16.0, vertical: 16),
                                                    child: Text(
                                                      controller.title.value, style: TextStyle(fontSize: 23.sp),),
                                                  ),
                                                  Text(controller.searchTitle.value,style: TextStyle(color: Color(int.parse('0xff${controller.searchTitleColor.value}'))),)
                                                ],
                                              ),
                                              SizedBox(height: 30.h,)

                                            ],
                                          )),
                                          buildList(),
                                          controller.getJobsStatus.value == StateStatus.LOADING?
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

                          );
                        }
                    ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child:
                    UserProfileWidget(),
                  )
                ],
              )
          )
      );
  }
  Widget buildList(){
    if(controller.getJobsStatus.value == StateStatus.ERROR)
      return SliverToBoxAdapter(child: ConnectionError());
    else
      if (controller.jobs.length != 0)
        return SliverList(
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
            return InkWell(
                onTap: () {
                  Get.toNamed(BazarcheAppRoutes.jobProfilePage,
                      arguments: controller.jobs[index].sId);
                },
                child: BestListItemWidget(
                  data: controller.jobs[index],
                ));
          }, childCount: controller.jobs.length),
        );
      else  if(controller.getJobsStatus.value != StateStatus.LOADING)
        return SliverToBoxAdapter(child: Center(child: Text('موردی یافت نشد'),),);
      else return SliverToBoxAdapter(child: Container(),);
  }
  Widget buildSubCategory(bool isCategory){
    Widget widget = ListView.builder(
      // controller: subMenuAutoScrollController,
      // controller: controller.subCategoryScrollController,
        scrollDirection: Axis.horizontal,
        itemCount: controller.subCategory
            .length,
        itemBuilder: (context, index) {
          return
            InkWell(
                onTap: () {
                  controller.onSubCategoryItemTap(index);
                  // controller.autoScrollController.scrollToIndex(index, preferPosition: AutoScrollPosition.begin);
                },
                child: CategoryItemWidgetMapView(
                  title: controller
                      .subCategory[index]
                      .name,
                  imageUrl: controller
                      .subCategory[index]
                      .icon,
                  index: index,
                  bgColor: controller
                      .subCategory[index]
                      .color,
                  isCategory: isCategory,));
        });
    // subMenuAutoScrollController.scrollToIndex(controller.selectedSubCategory.value,preferPosition: AutoScrollPosition.begin);
    return widget;
  }
  Widget buildCategory(){
    Widget widget =ListView.builder(
      // controller: menuAutoScrollController,
        scrollDirection: Axis.horizontal,
        itemCount: Bazarche().category.length,
        itemBuilder: (context, index) {
          return
            InkWell(
                onTap: () {
                  if(index!= controller.selectedCategory.value) {
                    controller.selectedCategory.value = index;
                    controller.getSubList(index);
                  }
                },
                child: CategoryItemWidget(
                  title: Bazarche().category[index]
                      .name,
                  imageUrl: Bazarche().category[index]
                      .icon,
                  index: index,
                  color: Bazarche().category[index]
                      .color,
                  width: (0.2).sw,));
        });
    return widget;
  }
}


