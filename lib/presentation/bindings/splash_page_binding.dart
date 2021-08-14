import 'package:bazarche/domain/usecases/category/get_all_category_usecase.dart';
import 'package:bazarche/domain/usecases/facilities/get_all_facilities_usecase.dart';
import 'package:bazarche/domain/usecases/user/get_following_usecase.dart';
import 'package:bazarche/domain/usecases/services/get_all_services_usecase.dart';
import 'package:bazarche/domain/usecases/user/is_login_usecase.dart';
import 'package:get/get.dart';

class SplashPageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<IsLoginUseCase>(() => IsLoginUseCase(
        repository: Get.find()
    ));
    Get.lazyPut<GetAllCategoryUseCase>(() => GetAllCategoryUseCase(
      repository: Get.find()
    ));
    Get.lazyPut<GetAllServicesUseCase>(() => GetAllServicesUseCase(
      repository: Get.find()
    ));
    Get.lazyPut<GetAllFacilitiesUseCase>(() => GetAllFacilitiesUseCase(
        repository: Get.find()
    ));
    Get.lazyPut<GetFollowingUseCase>(() => GetFollowingUseCase(
      repository: Get.find()
    ));
  }

}