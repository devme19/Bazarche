import 'package:bazarche/presentation/controllers/login_page_controller.dart';
import 'package:bazarche/presentation/navigations/bazarche_app.dart';
import 'package:bazarche/presentation/utils/const.dart';
import 'package:bazarche/presentation/utils/state_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends GetView<LoginPageController> {
  LoginPage({Key key}) : super(key: key);
  TextEditingController phoneNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: (Get.height/3).h,),
            SvgPicture.asset('assets/images/login.svg'),
            // Image(image: AssetImage('images/login.png')),
            SizedBox(height: 20.h,),
            Text('کدی ۴ رقمی برای شما ارسال خواهد شد'),
            SizedBox(height: 20.h,),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 32.w),
              decoration: BoxDecoration(
                color: Colors.white,
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
                children: [
                  Expanded(
                    child:
                    Container(
                      // height: 100,
                      // color:Colors.red,
                      margin: EdgeInsets.only(right: 16),
                      child:
                      TextFormField(

                        maxLength: 10,
                        textAlign: TextAlign.end,
                        autovalidateMode: AutovalidateMode.onUserInteraction,

                        controller: phoneNumberController,
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.done,
                        validator: (value){
                          if(value.isEmpty){
                            return 'لطفا شماره همراه را وارد کنید'.tr;

                          }
                          // else if(value.length != 10)
                          //   return 'شماره وارد شده صحیح نمی باشد';
                          else return null;
                        },
                        // onEditingComplete: () => node.nextFocus(),
                        decoration: InputDecoration(
                          suffix: SizedBox(
                            width: 50,
                            child: Row(
                              children: [
                                SizedBox(width: 8,),
                                Container(height: 15,width: 1,color: Colors.black12,),
                                SizedBox(width: 8,),
                                Text('98+')
                              ],
                            ),
                          ),
                            counter: Offstage(),
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'شماره همراه را وارد کنید',
                            focusedBorder: OutlineInputBorder(
                              // borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                                borderSide: BorderSide.none

                            ),
                            border:OutlineInputBorder(
                              // borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                                borderSide:BorderSide.none
                            )
                        ),
                      ),
                    ),
                  ),
                  // Container(
                  //   margin: EdgeInsets.symmetric(horizontal: 8.0),
                  //   width: 2,height:20,color: Colors.black54,),
                  // Text('98+'),
                  // SizedBox(width: 20,)

                ],
              ),
            ),
            SizedBox(height: 100.h,),
            Container(
              width: 230.w,
              child: Row(
                children: [
                  Expanded(
                    child:
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: primaryColor,
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                            )),
                        onPressed:(){
                          if(_formKey.currentState.validate()){
                            Map<String, dynamic> jsonMap = {
                              'phone': '0'+phoneNumberController.text,
                            };
                            controller.login(jsonMap, phoneNumberController.text);
                          }
                        },
                        child:
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.h,),
                          child:
                          Obx(()=>
                          controller.loginStatus.value == StateStatus.LOADING?
                              Container(
                                height: 15,
                                width: 15,
                                child: SpinKitRing(
                                  color: Colors.white,
                                  lineWidth: 2,
                                  // backgroundColor: Colors.white,
                                ),
                              ):Text('ثبت و ورود')),
                        )),
                  ),
                ],
              ),
            )
          ],),
        ),
      ),
    );
  }
}
