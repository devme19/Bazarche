import 'dart:io';

import 'package:bazarche/core/config/config.dart';
import 'package:bazarche/core/error/failures.dart';
import 'package:bazarche/core/usecase/usecase.dart';
import 'package:bazarche/data/datasources/remote/client.dart';
import 'package:bazarche/data/model/image_model.dart' as ImageModel;
import 'package:bazarche/data/model/job_profile_model.dart';
import 'package:bazarche/data/model/following_model.dart' as followingModel;
import 'package:bazarche/domain/usecases/job/add_checkin_usecase.dart';
import 'package:bazarche/domain/usecases/job/follow_job_usecase.dart';
import 'package:bazarche/domain/usecases/job/get_count_of_checkin_usecase.dart';
import 'package:bazarche/domain/usecases/job/get_images_usecase.dart';
import 'package:bazarche/domain/usecases/job/get_job_profile_usecase.dart';
import 'package:bazarche/domain/usecases/job/unfollow_job_usecase.dart';
import 'package:bazarche/domain/usecases/job/upload_job_images_usecase.dart';
import 'package:bazarche/presentation/navigations/bazarche_app.dart';
import 'package:bazarche/presentation/utils/bazarche.dart';
import 'package:bazarche/presentation/utils/image.dart';
import 'package:bazarche/presentation/utils/state_status.dart';
import 'package:bazarche/presentation/widgets/my_button_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart' as getStorage;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as dio;
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:bazarche/data/model/image_model.dart' as imageModel;
import 'map_widget_controller.dart';
import 'package:latlong/latlong.dart' as latLng;
import 'package:http/http.dart' as http;
class JobProfilePageController extends GetxController with SingleGetTickerProviderMixin{
  var getJobProfileStatus = StateStatus.INITIAL.obs;
  var followJobStatus = StateStatus.INITIAL.obs;
  var getCountOfCheckInsStatus = StateStatus.INITIAL.obs;
  var uploadImageStatus = StateStatus.INITIAL.obs;
  var getImageStatus = StateStatus.INITIAL.obs;
  var addCheckInStatus = StateStatus.INITIAL.obs;
  RxBool isFollowing = false.obs;
  Rx<Data> jobProfile = Data().obs;
  RxInt countOfCheckIns = 0.obs;
  RxBool commentsTaped = false.obs;
  RxBool checkInsTaped = false.obs;
  RxBool imageTaped = false.obs;
  RxBool galleryTaped = false.obs;
  RxBool cameraTaped = false.obs;
  RxInt checkInsCount = 0.obs;
  var unFollowJobStatus = StateStatus.INITIAL.obs;
  RxDouble uploadedValue=0.0.obs;
  RxBool hasImages = false.obs;
  ImagePicker _picker = ImagePicker();
  XFile image;
  String imagePath;
  RxList images = [].obs;
  MapWidgetController mapWidgetController = Get.put(MapWidgetController());
  RxInt imagesPageIndex = 1.obs;
  AnimationController animation;
  Animation<double> fadeInFadeOut;
  int pageIndex =1;

  @override
  void onInit() {
    super.onInit();
    animation = AnimationController(vsync: this, duration: Duration(seconds: 3),);
    fadeInFadeOut = Tween<double>(begin: 0.0, end: 1).animate(animation);

    animation.addStatusListener((status){
      if(status == AnimationStatus.completed){
        animation.reverse();
      }
      else if(status == AnimationStatus.dismissed){
        animation.forward();
      }
    });
  }

  getJobProfile(String id){
    getJobProfileStatus.value = StateStatus.LOADING;
    GetJobProfileUseCase getJobProfileUseCase = Get.find();
    getJobProfileUseCase.call(Params(id: id,body: Map<String, dynamic>())).then((response) {
      if(response.isRight){
        getJobProfileStatus.value = StateStatus.SUCCESS;
        jobProfile.value = response.right.data;
        checkInsCount.value = jobProfile.value.checkIns;
        // mapWidgetController.setDesirePositionMarker(latLng.LatLng(jobProfile.value.location.coordinates[1]
        //     ,jobProfile.value.location.coordinates[0]));
      }else if(response.isLeft){
        getJobProfileStatus.value = StateStatus.ERROR;
      }
    });
  }
  navigate()=>
    MapsLauncher.launchCoordinates(jobProfile.value.location.coordinates[1], jobProfile.value.location.coordinates[0]);
  call(String phoneNumber) async {
    String url = 'tel:' + phoneNumber;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  followJob(String id){
    Map<String, dynamic> jsonMap = {
      'jobId': id,
    };
    followJobStatus.value = StateStatus.LOADING;
    FollowJobUseCase followJobUseCase = Get.find();
    followJobUseCase.call(Params(body: jsonMap)).then((response) {
      if(response.isRight){
        followJobStatus.value = StateStatus.SUCCESS;
        Bazarche().followings.add(followingModel.Data(profileImage: jobProfile.value.profileImage,sId: id,title:jobProfile.value.title,bio:  jobProfile.value.bio));
        isFollowing.value = true;
      }
      else if(response.isLeft){
        followJobStatus.value = StateStatus.ERROR;
      }
    });
  }
  isFollow(){
    for(int i =0; i<Bazarche().followings.length;i++){
      if(jobProfile.value.sId == Bazarche().followings[i].sId) {
        isFollowing.value = true;
        break;
      }
    }
  }
  unFollowJob(String id){
    unFollowJobStatus.value = StateStatus.LOADING;
    UnFollowJobUseCase unFollowJobUseCase = Get.find();
    unFollowJobUseCase.call(Params(id: id)).then((response) {
      if(response.isRight){
        unFollowJobStatus.value = StateStatus.SUCCESS;
        for(int i=0;i<Bazarche().followings.length;i++)
          if(id == Bazarche().followings[i].sId)
          {
            Bazarche().followings.removeAt(i);
            isFollowing.value = false;
            break;
          }

      }
      else if(response.isLeft){
        unFollowJobStatus.value = StateStatus.ERROR;
      }
    });
  }
  getCountOfCheckIns(String id){
    getCountOfCheckInsStatus.value = StateStatus.LOADING;
    GetCountOfCheckInsUseCase getCountOfCheckInsUseCase = Get.find();
    getCountOfCheckInsUseCase.call(Params(id: id)).then((response) {
      if(response.isRight){
        getCountOfCheckInsStatus.value = StateStatus.SUCCESS;
        countOfCheckIns.value = response.right.data;
      }else if(response.isLeft){
        getCountOfCheckInsStatus.value = StateStatus.ERROR;
      }
    });
  }
  onGalleryTap(int index) async{

    if(index == 0){
      galleryTaped.value = true;
      cameraTaped.value = false;
      update();
      image = await _picker.pickImage(source: ImageSource.gallery);
    }
    else
      {
        galleryTaped.value = false;
        cameraTaped.value = true;
        update();
        image = await _picker.pickImage(source: ImageSource.camera);
      }
    hasImages.value = true;
    images.insert(0,ImageModel.Data(image: image.path));
    Get.back();
    uploadImageStatus.value = StateStatus.LOADING;
    File img = await MyImage().compress(image);
    print('ImageLength22222:'+img.lengthSync().toString());
    sendImage(img, jobProfile.value.sId);
    // compressImage(image).then((img){
    //   sendImage(img, jobProfile.value.sId);
    // });
    // File compressedImage = await compressImage(image);


  }
  onCheckInsTapped(String id){
    addCheckInStatus.value = StateStatus.LOADING;
    commentsTaped.value = false;
    checkInsTaped.value = true;
    imageTaped.value = false;
    Map<String, dynamic> jsonMap = {
      'jobId': id,
    };
    AddCheckInUseCase addCheckInUseCase = Get.find();
    addCheckInUseCase.call(Params(body: jsonMap)).then((response) {
      if(response.isRight){
        addCheckInStatus.value = StateStatus.SUCCESS;
        if(response.right)
          checkInsCount.value++;
      }else if(response.isLeft){
        ServerFailure serverFailure = response.left;
        if(serverFailure.errorCode == 409) {
          Get.snackbar('', 'شما قبلا اینجا اعلام حضور کردید');
          addCheckInStatus.value = StateStatus.SUCCESS;
        } else
          addCheckInStatus.value = StateStatus.ERROR;
      }
    });
  }
  onSendImageTapped(){
    commentsTaped.value = false;
    checkInsTaped.value = false;
    imageTaped.value = true;
    Get.bottomSheet(GetBuilder<JobProfilePageController>(
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
  onCommentsTapped(){
    commentsTaped.value = true;
    checkInsTaped.value = false;
    imageTaped.value = false;
    Get.toNamed(BazarcheAppRoutes.commentsPage,arguments: jobProfile.value);
  }
  getImages(String id){
    Map<String, dynamic> jsonMap = {
      'count':7,
      'page':pageIndex
    };
    getImageStatus.value = StateStatus.LOADING;
    GetImagesUseCase getImagesUseCase = Get.find();
    getImagesUseCase.call(Params(body: jsonMap,id: id)).then((response) {
      if(response.isRight){
        pageIndex++;
        getImageStatus.value = StateStatus.SUCCESS;
        images.addAll(response.right.data);
      }
      else if(response.isLeft){
        getImageStatus.value = StateStatus.ERROR;
      }


    });
  }
  // Future<File> compressImage(XFile file)async{
  //   int quality = 100;
  //   File compressedFile = await FlutterNativeImage.compressImage(file.path,
  //       quality: quality, percentage: 100);
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
  sendImage(File image,String id)async{
    String fileName = image.path.split('/').last;
    dio.FormData formData = new dio.FormData.fromMap({
      "image": await dio.MultipartFile.fromFile(image.path,filename: fileName,contentType: new MediaType("image", "jpg")),
      "jobId":id,
      "description":"qweqweq",
    });
    UploadJobImagesUseCase uploadJobImagesUseCase = Get.find();
    uploadJobImagesUseCase.call(Params(formData: formData), (value) {
      uploadedValue.value = value;

    }).then((response){
      if(response.isRight){
        images[0].sId = '';
        uploadImageStatus.value = StateStatus.SUCCESS;
        animation.forward();
      }
      else if(response.isLeft)
        {
          ServerFailure serverFailure = response.left;
          print(serverFailure.errorMessage);
          uploadImageStatus.value = StateStatus.ERROR;
          images.removeAt(0);
        }
    });
   // try{
   //   dio.Response resp = await Client().dio.post(
   //     'user/jobs/images',
   //     data: formData,
   //     // options: Options(headers: headers,),
   //     onSendProgress: (int sent, int total) {
   //       uploadedValue.value = sent/total;
   //       print('Uploaded:'+uploadedValue.toString());
   //       print('$sent/$total');
   //       print('id=${jobProfile.value.sId}');
   //     },
   //   );
   //   if(resp.statusCode == 200) {
   //     print("============= Print Resp data: ");
   //     print(resp.data);
   //     animation.forward();
   //     uploadImageStatus.value = StateStatus.SUCCESS;
   //     print('id=${jobProfile.value.sId}');
   //   }
   //   else
   //   {
   //     uploadImageStatus.value = StateStatus.ERROR;
   //     Get.defaultDialog(
   //         // title: 'خطا در برقراری ارتباط',
   //         content: Text('خطا در برقراری ارتباط'),
   //         confirm: Text('تایید'),
   //         onConfirm:()=> Get.back()
   //     );
   //     images.removeAt(0);
   //   }
   // }on dio.DioError catch(e){
   //   uploadImageStatus.value = StateStatus.ERROR;
   //   Get.defaultDialog(
   //     // title: 'خطا در برقراری ارتباط',
   //     content: Text('خطا در برقراری ارتباط'),
   //     confirm: Text('تایید'),
   //     onConfirm:()=> Get.back()
   //   );
   //   images.removeAt(0);
   // }

  }
}