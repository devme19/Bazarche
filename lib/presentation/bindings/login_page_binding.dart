import 'package:bazarche/domain/usecases/user/login_usecase.dart';
import 'package:bazarche/presentation/controllers/login_page_controller.dart';
import 'package:get/get.dart';

class LoginPageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<LoginPageController>(() => LoginPageController());
  }

}