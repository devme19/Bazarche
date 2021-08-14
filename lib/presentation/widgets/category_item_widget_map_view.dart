import 'package:bazarche/core/config/config.dart';
import 'package:bazarche/presentation/controllers/home_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CategoryItemWidgetMapView extends GetView<HomePageController> {
  String bgColor;
  String imageUrl;
  String title;
  bool isCategory;
  int index;
  CategoryItemWidgetMapView({Key key,this.title,this.bgColor,this.imageUrl,this.index,this.isCategory}) : super(key: key);

  Color defBgColor = Colors.grey;
  Color createBgColor(){
    Color mColor = Colors.grey.shade400;
    if(isCategory) {
      if (controller.selectedCategory.value == index)
        mColor = Color(int.parse('0xff$bgColor'));
    }
    else
    if (controller.selectedSubCategory.value == index)
      mColor = Color(int.parse('0xff$bgColor'));

    return mColor;
  }
  @override
  Widget build(BuildContext context) {

    return
      Obx(()=>
          Container(
            margin: EdgeInsets.only(left: 16.0,bottom: 8.0),
            width: (0.28).sw,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(16.sp)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Row(children: [
              Column(
                children: [
                  Expanded(
                    child: Container(
                        padding: EdgeInsets.all(16.sp),
                        width: (0.1).sw,
                        decoration: BoxDecoration(
                          color: createBgColor(),
                          borderRadius: BorderRadius.all(Radius.circular(16.0)),

                        ),
                        child:imageUrl!=null?
                        SvgPicture.network(uploadBaseUrl+'categories/'+imageUrl,color: Colors.white,)
                    :SvgPicture.asset('assets/icons/all.svg',
                            color:Colors.white
                          // Colors.purple
                        ),),
                  ),
                ],
              ),
              SizedBox(width: 16.w,),
              Expanded(flex:2,child: Text(title,style: TextStyle(fontSize: isCategory?18.sp:12.sp),))
            ],),
          ));
  }
}
