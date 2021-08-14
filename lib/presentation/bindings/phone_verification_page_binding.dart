import 'package:bazarche/domain/usecases/user/login_usecase.dart';
import 'package:bazarche/domain/usecases/user/phone_verification_usecase.dart';
import 'package:bazarche/presentation/controllers/phone_verification_page_controller.dart';
import 'package:get/get.dart';

class PhoneVerificationPageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<PhoneVerificationPageController>(() => PhoneVerificationPageController());
    Get.lazyPut<PhoneVerificationUseCase>(() => PhoneVerificationUseCase(
      repository: Get.find()
    ));
  }

}