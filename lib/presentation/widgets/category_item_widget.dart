import 'package:bazarche/core/config/config.dart';
import 'package:bazarche/presentation/controllers/home_page_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryItemWidget extends GetView<HomePageController> {
  String title;
  String imageUrl;
  String color;
  int index;
  double width;
  CategoryItemWidget({Key key,this.title,this.imageUrl,this.color,this.index,this.width}) : super(key: key);

  Color createBgColor(){
    Color defBgColor = Colors.white;
    if(controller.selectedCategory.value == index){
      defBgColor = Color(int.parse('0xff$color'));
    }
    return defBgColor;
  }
  @override
  Widget build(BuildContext context) {
    return
      Obx(()=>
          Container(
            margin: EdgeInsets.only(left: 16,bottom: 6),
            width: width,
            decoration: BoxDecoration(
                boxShadow:  [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 0.1,
                    blurRadius: 1,
                    offset: Offset(0, 1), // changes position of shadow
                  )
                ],
                color: createBgColor(),
                borderRadius: BorderRadius.all(Radius.circular(15))
            ),
            child: Column(children: [
              // SizedBox(height: 30,),
              Expanded(
                // flex: 2,
                  child:
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: imageUrl!=null?
                SvgPicture.network(uploadBaseUrl+'categories/'+imageUrl,height: 0.18.sw,
                  color: controller.selectedCategory.value == index?
                      Colors.white:
                  Color(int.parse('0xff$color'))
                  // Colors.purple
                ):SvgPicture.asset('assets/icons/all.svg',height: 0.18.sw,
                    color: controller.selectedCategory.value == index?
                    Colors.white:
                    Color(int.parse('0xff$color'))
                  // Colors.purple
                ),
              )),
              SizedBox(height: 16.w,),
              Text(title,style:TextStyle(
                color: controller.selectedCategory.value == index?Colors.white:
                    Colors.black87,fontSize: 14.sp,
              ),),
              SizedBox(height: 16.w,)
            ],),
          ));
  }
}
