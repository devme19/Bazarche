import 'package:bazarche/domain/usecases/user/get_following_usecase.dart';
import 'package:bazarche/domain/usecases/user/get_user_profile_usecase.dart';
import 'package:bazarche/presentation/controllers/user_profile_page_controller.dart';
import 'package:get/get.dart';

class UserProfilePageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<UserProfilePageController>(() => UserProfilePageController());
    Get.lazyPut<GetUserProfileUseCase>(() => GetUserProfileUseCase(
      repository: Get.find()
    ));
    Get.lazyPut<GetFollowingUseCase>(() => GetFollowingUseCase(
      repository: Get.find()
    ));
  }

}