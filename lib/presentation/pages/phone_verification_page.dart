import 'dart:async';

import 'package:bazarche/presentation/controllers/phone_verification_page_controller.dart';
import 'package:bazarche/presentation/utils/const.dart';
import 'package:bazarche/presentation/utils/state_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// ignore: must_be_immutable
class PhoneVerificationPage extends GetView<PhoneVerificationPageController> {
  String phoneNumber;
  TextEditingController confirmDigit1 = TextEditingController();
  TextEditingController confirmDigit2 = TextEditingController();
  TextEditingController confirmDigit3 = TextEditingController();
  TextEditingController confirmDigit4 = TextEditingController();
  TextEditingController confirmDigit5 = TextEditingController();
  TextEditingController confirmDigit6 = TextEditingController();

  FocusNode confirmFocus1 = FocusNode();
  FocusNode confirmFocus2 = FocusNode();
  FocusNode confirmFocus3 = FocusNode();
  FocusNode confirmFocus4 = FocusNode();
  FocusNode confirmFocus5 = FocusNode();
  FocusNode confirmFocus6 = FocusNode();
  double spaceBetween = 5.w;
  PhoneVerificationPage(){
    phoneNumber = '0'+Get.arguments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Obx(()=>
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: (Get.height/4).h,),
              SvgPicture.asset('assets/images/confirm.svg'),
              // Image(image: AssetImage('images/login.png')),
              SizedBox(height: 20.h,),
              Text('کد به شماره $phoneNumber ارسال شد'),
              SizedBox(height: 20.h,),
              Container(
                // decoration: BoxDecoration(
                //   color: Colors.white,
                //   boxShadow: [
                //     BoxShadow(
                //       color: Colors.grey.withOpacity(0.5),
                //       spreadRadius: 2,
                //       blurRadius: 7,
                //       offset: Offset(0, 3), // changes position of shadow
                //     ),
                //   ],
                //   borderRadius: BorderRadius.only(
                //     bottomLeft: Radius.circular(15),
                //     bottomRight: Radius.circular(15),
                //   ),
                //   // border: Border.all(color: Colors.grey)
                // ),
                padding: EdgeInsets.symmetric(horizontal: 32.w,),
                child: Row(
                  children: [
                    Expanded(
                      child:
                      TextFormField(
                        onChanged: (text){
                          if(text.length == 1)
                            FocusScope.of(context).unfocus();
                        },
                        maxLength: 1,
                        focusNode: confirmFocus1,
                        textAlign: TextAlign.center,
                        controller: confirmDigit1,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        // onEditingComplete: () => node.nextFocus(),
                        // validator: (value){
                        //   if(value.isEmpty){
                        //     _scrollController.animateTo(
                        //       0.0,
                        //       curve: Curves.easeOut,
                        //       duration: const Duration(milliseconds: 300),
                        //     );
                        //     return 'first name is required'.tr;
                        //
                        //   }
                        //   else return null;
                        // },
                        // onEditingComplete: () => node.nextFocus(),
                        decoration: InputDecoration(
                            counter: Offstage(),
                            filled: true,
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                                // borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                                borderSide: BorderSide(color: Colors.grey.withOpacity(0.8))

                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                                borderSide: BorderSide(color: Colors.grey.withOpacity(0.5))

                            )
                        ),
                      ),
                    ),
                    SizedBox(width: spaceBetween,),
                    Expanded(
                      child: TextFormField(
                        onChanged: (text){
                          if(text.length == 1)
                            FocusScope.of(context).requestFocus(confirmFocus1);
                        },
                        maxLength: 1,
                        focusNode: confirmFocus2,
                        textAlign: TextAlign.center,
                        controller: confirmDigit2,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () => FocusScope.of(context).requestFocus(confirmFocus1),
                        // validator: (value){
                        //   if(value.isEmpty){
                        //     _scrollController.animateTo(
                        //       0.0,
                        //       curve: Curves.easeOut,
                        //       duration: const Duration(milliseconds: 300),
                        //     );
                        //     return 'first name is required'.tr;
                        //
                        //   }
                        //   else return null;
                        // },
                        // onEditingComplete: () => node.nextFocus(),
                        decoration: InputDecoration(
                            counter: Offstage(),
                            filled: true,
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                                // borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                                borderSide: BorderSide(color: Colors.grey.withOpacity(0.8))

                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                                borderSide: BorderSide(color: Colors.grey.withOpacity(0.5))

                            )
                        ),
                      ),
                    ),
                    SizedBox(width: spaceBetween,),
                    Expanded(
                      child: TextFormField(
                        onChanged: (text){
                          if(text.length == 1)
                            FocusScope.of(context).requestFocus(confirmFocus2);
                        },
                        maxLength: 1,
                        focusNode: confirmFocus3,
                        textAlign: TextAlign.center,
                        controller: confirmDigit3,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () => FocusScope.of(context).requestFocus(confirmFocus2),
                        // validator: (value){
                        //   if(value.isEmpty){
                        //     _scrollController.animateTo(
                        //       0.0,
                        //       curve: Curves.easeOut,
                        //       duration: const Duration(milliseconds: 300),
                        //     );
                        //     return 'first name is required'.tr;
                        //
                        //   }
                        //   else return null;
                        // },
                        // onEditingComplete: () => node.nextFocus(),
                        decoration: InputDecoration(
                            counter: Offstage(),
                            filled: true,
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                                // borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                                borderSide: BorderSide(color: Colors.grey.withOpacity(0.8))

                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                                borderSide: BorderSide(color: Colors.grey.withOpacity(0.5))

                            )
                        ),
                      ),
                    ),
                    SizedBox(width: spaceBetween,),
                    Expanded(
                      child: TextFormField(
                        onChanged: (text){
                          if(text.length == 1)
                            FocusScope.of(context).requestFocus(confirmFocus3);
                        },
                        maxLength: 1,
                        focusNode: confirmFocus4,
                        textAlign: TextAlign.center,
                        controller: confirmDigit4,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () => FocusScope.of(context).requestFocus(confirmFocus3),
                        // validator: (value){
                        //   if(value.isEmpty){
                        //     _scrollController.animateTo(
                        //       0.0,
                        //       curve: Curves.easeOut,
                        //       duration: const Duration(milliseconds: 300),
                        //     );
                        //     return 'first name is required'.tr;
                        //
                        //   }
                        //   else return null;
                        // },
                        // onEditingComplete: () => node.nextFocus(),
                        decoration: InputDecoration(
                            counter: Offstage(),
                            filled: true,
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                                // borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                                borderSide: BorderSide(color: Colors.grey.withOpacity(0.8))

                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                                borderSide: BorderSide(color: Colors.grey.withOpacity(0.5))

                            )
                        ),
                      ),
                    ),
                    SizedBox(width: spaceBetween,),
                    Expanded(
                      child: TextFormField(
                        onChanged: (text){
                          if(text.length == 1)
                            FocusScope.of(context).requestFocus(confirmFocus4);
                        },
                        maxLength: 1,
                        focusNode: confirmFocus5,
                        textAlign: TextAlign.center,
                        controller: confirmDigit5,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () => FocusScope.of(context).requestFocus(confirmFocus4),
                        // validator: (value){
                        //   if(value.isEmpty){
                        //     _scrollController.animateTo(
                        //       0.0,
                        //       curve: Curves.easeOut,
                        //       duration: const Duration(milliseconds: 300),
                        //     );
                        //     return 'first name is required'.tr;
                        //
                        //   }
                        //   else return null;
                        // },
                        // onEditingComplete: () => node.nextFocus(),
                        decoration: InputDecoration(
                            counter: Offstage(),
                            filled: true,
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                                // borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                                borderSide: BorderSide(color: Colors.grey.withOpacity(0.8))

                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                                borderSide: BorderSide(color: Colors.grey.withOpacity(0.5))

                            )
                        ),
                      ),
                    ),
                    SizedBox(width: spaceBetween,),
                    Expanded(
                      child: TextFormField(
                        onChanged: (text){
                          if(text.length == 1)
                            FocusScope.of(context).requestFocus(confirmFocus5);
                        },
                        maxLength: 1,
                        focusNode: confirmFocus6,
                        textAlign: TextAlign.center,
                        controller: confirmDigit6,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () => FocusScope.of(context).requestFocus(confirmFocus5),
                        // validator: (value){
                        //   if(value.isEmpty){
                        //     _scrollController.animateTo(
                        //       0.0,
                        //       curve: Curves.easeOut,
                        //       duration: const Duration(milliseconds: 300),
                        //     );
                        //     return 'first name is required'.tr;
                        //
                        //   }
                        //   else return null;
                        // },
                        // onEditingComplete: () => node.nextFocus(),
                        decoration: InputDecoration(
                            counter: Offstage(),
                            filled: true,
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                                // borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                                borderSide: BorderSide(color: Colors.grey.withOpacity(0.8))

                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                                borderSide: BorderSide(color: Colors.grey.withOpacity(0.5))

                            )
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 80.h,),
              Container(
                height: 70.h,
                margin: EdgeInsets.symmetric(horizontal: 32.w),
                decoration: BoxDecoration(
                  color:controller.start.value ==0 ? primaryColor:Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  // border: Border.all(color: Colors.grey)
                ),
                child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    controller.start.value == 0 ?
                    Expanded(
                      child: InkWell(
                          onTap: (){
                            controller.startTimer();
                            controller.login(phoneNumber);
                          },
                          child: Text('ارسال مجدد کد',textAlign: TextAlign.center,style: TextStyle(color: Colors.white),)),
                    ):Text('${controller.start.value}')
                  ],
                ),
              ),
              SizedBox(height: 60.h,),
              Container(
                width: 230.w,
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: primaryColor,
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(10.0),
                              )),
                          onPressed:(){
                            Map<String, dynamic> jsonMap = {
                              'phone': phoneNumber,
                              'token':confirmDigit6.text+confirmDigit5.text+confirmDigit4.text+confirmDigit3.text+confirmDigit2.text+confirmDigit1.text
                            };
                            controller.phoneVerification(jsonMap);
                            // Get.offAndToNamed(BazarcheAppRoutes.loginPage,arguments: phoneNumberController.text);
                          },
                          child:
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.h,),
                            child: controller.phoneVerificationStatus.value == StateStatus.LOADING?
                            Container(
                              height: 15,
                              width: 15,
                              child: SpinKitRing(
                                color: Colors.white,
                                lineWidth: 2,
                                // backgroundColor: Colors.white,
                              ),
                            ):
                            Text('ورود'),
                          )),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 60.h,),
            ],),
          )),
    );
  }
}