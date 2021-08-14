import 'dart:async';

import 'package:bazarche/core/usecase/usecase.dart';
import 'package:bazarche/domain/usecases/user/login_usecase.dart';
import 'package:bazarche/domain/usecases/user/phone_verification_usecase.dart';
import 'package:bazarche/presentation/navigations/bazarche_app.dart';
import 'package:bazarche/presentation/utils/state_status.dart';
import 'package:get/get.dart';

class PhoneVerificationPageController extends GetxController{

  RxInt start = 60.obs;
  Timer _timer;

  var phoneVerificationStatus = StateStatus.INITIAL.obs;
  @override
  void onInit() {
    super.onInit();
    startTimer();
  }


  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  void startTimer() {
    start.value = 60;
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        if (start.value == 0) {
          _timer.cancel();
        } else {
          start.value--;
        }
      },
    );
  }
  login(String phoneNumber){
    Map<String, dynamic> jsonMap = {
      'phone': phoneNumber,
    };
    LoginUseCase loginUseCase = Get.find();
    loginUseCase.call(Params(body: jsonMap)).then((response){
      if(response.isRight){
      }else if(response.isLeft){

      }
    });
  }
  phoneVerification(Map queryParameters){
    phoneVerificationStatus.value = StateStatus.LOADING;
    PhoneVerificationUseCase phoneVerificationUseCase = Get.find();
    phoneVerificationUseCase.call(Params(body: queryParameters)).then((response) {
      if(response.isRight){
        phoneVerificationStatus.value = StateStatus.SUCCESS;
        Get.offAndToNamed(BazarcheAppRoutes.homePage);
      }else if(response.isLeft){
        phoneVerificationStatus.value = StateStatus.ERROR;
      }
    });
  }
}