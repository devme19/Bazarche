import 'dart:io';
import 'package:bazarche/core/usecase/usecase.dart';
import 'package:bazarche/data/datasources/remote/client.dart';
import 'package:bazarche/domain/usecases/job/upload_job_images_usecase.dart';
import 'package:bazarche/domain/usecases/user/update_user_profile_usecase.dart';
import 'package:bazarche/presentation/utils/image.dart';
import 'package:dio/dio.dart' as dio;
import 'package:bazarche/presentation/utils/state_status.dart';
import 'package:bazarche/presentation/widgets/my_button_widget.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
class EditUserProfilePageController extends GetxController{

  RxBool galleryTaped = false.obs;
  RxBool cameraTaped = false.obs;
  Rx<XFile> image = XFile('').obs;
  File compressedImage;
  ImagePicker _picker = ImagePicker();
  RxDouble uploadedValue= 0.0.obs;
  var saveUserProfileState = StateStatus.INITIAL.obs;
  updateProfile(String fullName,String email,String bio) async{
    saveUserProfileState.value = StateStatus.LOADING;
    dio.FormData formData;
    if(image.value.path != "") {
      File img = await MyImage().compress(image.value);
      String fileName = img.path.split('/').last;
      formData = new dio.FormData.fromMap({
        "profileImage": await dio.MultipartFile.fromFile(img.path,filename: fileName,contentType: new MediaType("image", "jpg")),
        "fullname":fullName,
        "email":email,
        "bio":bio,
      });
    }
    else
      {
        formData = new dio.FormData.fromMap({
          "fullname":fullName,
          "email":email,
          "bio":bio,
        });
      }
    UpdateUserProfileUseCase updateUserProfileUseCase = Get.find();
    updateUserProfileUseCase.call(Params(formData: formData), (value) {
      uploadedValue.value = value;
    }).then((response) async {
      if(response.isRight) {
        saveUserProfileState.value = StateStatus.SUCCESS;
        await Future.delayed(Duration(seconds: 2));
        Get.back();
      }else if(response.isLeft){
        saveUserProfileState.value = StateStatus.ERROR;
        Get.snackbar('', 'خطا در برقراری ارتباط');
      }
    });

  }
  onProfileImageTapped(){
    Get.bottomSheet(GetBuilder<EditUserProfilePageController>(
      builder: (cont){
        return
          Container(
            height: 200,
            // padding: EdgeInsets.symmetric(horizontal: 40.0,vertical: 40),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topRight: Radius.circular(50),topLeft: Radius.circular(50)),
            ),
            child:
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                    onTap: (){
                      onGalleryTap(0);
                    },
                    child: MyButtonWidget(title: 'گالری',icon: Icons.image_outlined,isTaped: galleryTaped.value,)),
                SizedBox(width: 50,),
                InkWell(
                    onTap: (){
                      onGalleryTap(1);
                    },
                    child: MyButtonWidget(title: 'دوربین',icon: Icons.camera_alt,isTaped: cameraTaped.value,)),
              ],
            ),
          );
      },
    ));
  }
  onGalleryTap(int index) async{
    XFile file;
    if(index == 0){
      galleryTaped.value = true;
      cameraTaped.value = false;
      update();
      file = await _picker.pickImage(source: ImageSource.gallery);
      if(file!=null)
        image.value = file;
    }
    else
    {
      galleryTaped.value = false;
      cameraTaped.value = true;
      update();
      file = await _picker.pickImage(source: ImageSource.camera);
      if(file!=null)
        image.value = file;
    }
    Get.back();
    // compressedImage = await MyImage().compress(image.value);
    // File compressedImage = await compressImage(image);


  }
  setInfo(String fullName,String bio,String email,){
    fullName = fullName;
    bio = bio;
    email = email;
  }
  // Future<File> compressImage(XFile file)async{
  //   int quality = 100;
  //   File compressedFile = await FlutterNativeImage.compressImage(file.path,
  //       quality: quality, percentage: 100);
  //   FlutterNativeImage.compressImage(file.path,
  //       quality: quality, percentage: 100).then((image){
  //     if(image.lengthSync()>800000) {
  //       quality-=10;
  //       FlutterNativeImage.compressImage(
  //           file.path,
  //           quality: quality,
  //           percentage: 100).then((compressedImage){
  //
  //       });
  //       print("after:"+compressedFile.lengthSync().toString());
  //     }
  //   });
  //   do {
  //     if(compressedFile.lengthSync()>800000) {
  //       quality-=10;
  //       compressedFile =
  //       await FlutterNativeImage.compressImage(
  //           file.path,
  //           quality: quality,
  //           percentage: 100);
  //       print("after:"+compressedFile.lengthSync().toString());
  //     } else
  //       break;
  //   } while (true);
  //   return compressedFile;
  // }
  // sendImage1(File image,String id)async{
  //   String fileName = image.path.split('/').last;
  //   dio.FormData formData = new dio.FormData.fromMap({
  //     "profileImage": await dio.MultipartFile.fromFile(image.path,filename: fileName,contentType: new MediaType("image", "jpg")),
  //     "fullname":id,
  //     "email":"qweqweq",
  //     "bio":"qweqweq",
  //   });
  //   try{
  //     dio.Response resp = await Client().dio.post(
  //       'user/jobs/images',
  //       data: formData,
  //       // options: Options(headers: headers,),
  //       onSendProgress: (int sent, int total) {
  //         uploadedValue.value = sent/total;
  //       },
  //     );
  //     if(resp.statusCode == 200) {
  //       print("============= Print Resp data: ");
  //       print(resp.data);
  //       saveUserProfileState.value = StateStatus.SUCCESS;
  //     }
  //     else
  //     {
  //       saveUserProfileState.value = StateStatus.ERROR;
  //       Get.defaultDialog(
  //         // title: 'خطا در برقراری ارتباط',
  //           content: Text('خطا در برقراری ارتباط'),
  //           confirm: Text('تایید'),
  //           onConfirm:()=> Get.back()
  //       );
  //     }
  //   }on dio.DioError catch(e){
  //     saveUserProfileState.value = StateStatus.ERROR;
  //     Get.defaultDialog(
  //       // title: 'خطا در برقراری ارتباط',
  //         content: Text('خطا در برقراری ارتباط'),
  //         confirm: Text('تایید'),
  //         onConfirm:()=> Get.back()
  //     );
  //   }
  //
  // }
}