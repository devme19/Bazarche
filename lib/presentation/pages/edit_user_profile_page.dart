import 'dart:io';

import 'package:bazarche/core/config/config.dart';
import 'package:bazarche/domain/entities/profile_entity.dart';
import 'package:bazarche/presentation/controllers/edit_user_profile_page_controller.dart';
import 'package:bazarche/presentation/utils/state_status.dart';
import 'package:bazarche/presentation/widgets/connection_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class EditUserProfilePage extends GetView<EditUserProfilePageController> {

  ProfileEntity profileEntity;
  TextEditingController fullNameTxtController = TextEditingController();
  TextEditingController bioTxtController = TextEditingController();
  TextEditingController emailTxtController = TextEditingController();
  FocusNode bioFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  EditUserProfilePage(){
    if(Get.arguments != null){
      profileEntity = Get.arguments;
      if(profileEntity != null){
        if(profileEntity.data.fullname!= null)
          fullNameTxtController.text = profileEntity.data.fullname;
        if(profileEntity.data.bio!= null)
          bioTxtController.text = profileEntity.data.bio;
        if(profileEntity.data.email!= null)
          emailTxtController.text = profileEntity.data.email;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusNode();
    return
      Scaffold(
        appBar: AppBar(),
          body:
          Obx(()=>
              Container(
                color: Colors.white,
                child: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16.0,vertical: 16.0),
                      padding: EdgeInsets.all(16.0),
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
                      child:
                      Row(
                        children: [
                          Container(
                            width: 180,
                            height: 180,
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
                            child:

                            InkWell(
                              onTap: (){
                                controller.onProfileImageTapped();
                              },
                              child:
                              Stack(
                                children: [
                                  Align(
                                    alignment:Alignment.center,
                                    child:
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            width: 180,
                                            height: 180,
                                            // padding: EdgeInsets.all(6.0),
                                            child: ClipRRect(
                                                borderRadius: BorderRadius.all(Radius.circular(200)),
                                                child:
                                                controller.image.value.path !=''?
                                                Image.file(File(controller.image.value.path),fit: BoxFit.cover):
                                                profileEntity.data.profileImage == null || profileEntity.data.profileImage == ''?
                                                Opacity(
                                                    opacity: 0.3,
                                                    child: SvgPicture.asset('assets/icons/person.svg',width: 100,height: 100,)):
                                                Image.network(uploadBaseUrl+'profileImages/${profileEntity.data.profileImage}',fit: BoxFit.cover,)
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Align(
                                      alignment:Alignment.bottomRight,
                                      child:
                                      Container(
                                        margin: EdgeInsets.only(bottom: 8.0,right: 26.0),
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                        ),
                                          child: Icon(Icons.camera_alt,color: Colors.grey,size: 30,))
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(right: 32.0),
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(child: Text(profileEntity.data.fullname)),
                                    ],
                                  ),
                                  SizedBox(height: 20,),
                                  Row(
                                    children: [
                                      Expanded(child: Text(profileEntity.data.bio)),
                                    ],
                                  ),
                                  SizedBox(height: 16.0,)
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      height: Get.height-360,
                      padding: EdgeInsets.all(32.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: Offset(0, -1), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(70),topRight: Radius.circular(70))
                      ),
                      child:
                      Column(
                        children: [
                          SizedBox(height: 20,),
                          Row(
                            children: [
                              Text('نام و نام خانوادگی'),
                            ],
                          ),
                          SizedBox(height: 20,),

                          TextFormField(

                            // maxLength: 10,
                            // textAlign: TextAlign.end,
                            // autovalidateMode: AutovalidateMode.onUserInteraction,
                            style: TextStyle(color: primaryColor),
                            controller: fullNameTxtController,
                            textInputAction: TextInputAction.next,

                            onEditingComplete: () => Get.focusScope.nextFocus(),
                            decoration: InputDecoration(
                                icon: SvgPicture.asset('assets/icons/person.svg'),
                                counter: Offstage(),
                                filled: true,
                                fillColor: Colors.white,
                                hintText: profileEntity.data.fullname,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                                  // borderSide: BorderSide.none

                                ),
                                border:OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                                  // borderSide:BorderSide.none
                                )
                            ),
                          ),
                          SizedBox(height: 20,),
                          Row(
                            children: [
                              Text('بیوگرافی'),
                            ],
                          ),
                          SizedBox(height: 20,),
                          TextFormField(
                            maxLines: null,
                            // maxLength: 10,
                            // textAlign: TextAlign.end,
                            // autovalidateMode: AutovalidateMode.onUserInteraction,
                            style: TextStyle(color: primaryColor),
                            controller: bioTxtController,
                            textInputAction: TextInputAction.next,

                            onEditingComplete: () => Get.focusScope.nextFocus(),
                            decoration: InputDecoration(
                                icon: Icon(Icons.error,color: Colors.black,),
                                counter: Offstage(),
                                filled: true,
                                fillColor: Colors.white,
                                hintText: profileEntity.data.bio,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                                  // borderSide: BorderSide.none

                                ),
                                border:OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                                  // borderSide:BorderSide.none
                                )
                            ),
                          ),
                          SizedBox(height: 20,),

                          Row(
                            children: [
                              Text('ایمیل'),
                            ],
                          ),
                          SizedBox(height: 20,),
                          TextFormField(

                            // maxLength: 10,
                            // textAlign: TextAlign.end,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            style: TextStyle(color: primaryColor),
                            controller: emailTxtController,
                            textInputAction: TextInputAction.next,

                            onEditingComplete: () => Get.focusScope.nextFocus(),
                            decoration: InputDecoration(
                                icon: Icon(Icons.alternate_email,color: Colors.black,),
                                counter: Offstage(),
                                filled: true,
                                fillColor: Colors.white,
                                hintText: profileEntity.data.email,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                                  // borderSide: BorderSide.none

                                ),
                                border:OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                                  // borderSide:BorderSide.none
                                )
                            ),
                          ),
                          SizedBox(height: 80,),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: primaryColor,
                                        shape: new RoundedRectangleBorder(
                                          borderRadius: new BorderRadius.circular(10.0),
                                        )),
                                    onPressed:(){
                                      controller.updateProfile(fullNameTxtController.text,emailTxtController.text, bioTxtController.text);
                                    },
                                    child:
                                    Container(
                                      height: 65,
                                        child: controller.saveUserProfileState.value == StateStatus.LOADING?
                                          CircularPercentIndicator(
                                            radius: 60.0,
                                            lineWidth: 5.0,
                                            percent: controller.uploadedValue.value,
                                            center: new Text(( controller.uploadedValue.value*100).round().toString()+'%',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                            progressColor: Colors.white,
                                            ):
                                            controller.saveUserProfileState.value == StateStatus.SUCCESS?
                                                Icon(Icons.check,color: Colors.white,)
                                        // CircularPercentIndicator(
                                        //   radius: 60.0,
                                        //   lineWidth: 5.0,
                                        //   percent: controller.uploadedValue.value,
                                        //   center: new Text(( controller.uploadedValue.value*100).round().toString()+'%',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
                                        //   progressColor: Colors.green,
                                        // )
                                            :
                                        controller.saveUserProfileState.value == StateStatus.ERROR?

                                        Center(child: Text('خطا در برقراری ارتباط')):
                                        Center(child: Text('ویرایش'))
                                    )
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ))
      );
  }
}
