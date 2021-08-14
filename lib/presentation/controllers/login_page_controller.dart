import 'package:bazarche/core/usecase/usecase.dart';
import 'package:bazarche/domain/usecases/user/login_usecase.dart';
import 'package:bazarche/presentation/navigations/bazarche_app.dart';
import 'package:bazarche/presentation/utils/state_status.dart';
import 'package:get/get.dart';

class LoginPageController extends GetxController{
  var loginStatus = StateStatus.INITIAL.obs;
  login(Map body,String phoneNumber){
    loginStatus.value = StateStatus.LOADING;
    LoginUseCase loginUseCase = Get.find();
    loginUseCase.call(Params(body: body)).then((response){
      if(response.isRight){
        Get.offAndToNamed(BazarcheAppRoutes.phoneVerificationPage,arguments: phoneNumber);
      }else if(response.isLeft){

      }
    });
  }
}