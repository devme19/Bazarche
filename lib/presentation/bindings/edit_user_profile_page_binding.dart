import 'package:bazarche/domain/usecases/user/update_user_profile_usecase.dart';
import 'package:bazarche/presentation/controllers/edit_user_profile_page_controller.dart';
import 'package:get/get.dart';

class EditUserProfilePageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<EditUserProfilePageController>(() => EditUserProfilePageController());
    Get.lazyPut<UpdateUserProfileUseCase>(() => UpdateUserProfileUseCase(
      repository: Get.find()
    ));
  }

}