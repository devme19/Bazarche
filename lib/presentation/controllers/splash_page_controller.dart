import 'package:bazarche/core/error/failures.dart';
import 'package:bazarche/core/usecase/usecase.dart';
import 'package:bazarche/data/model/all_category_model.dart';
import 'package:bazarche/domain/usecases/category/get_all_category_usecase.dart';
import 'package:bazarche/domain/usecases/facilities/get_all_facilities_usecase.dart';
import 'package:bazarche/domain/usecases/user/get_following_usecase.dart';
import 'package:bazarche/domain/usecases/services/get_all_services_usecase.dart';
import 'package:bazarche/domain/usecases/user/is_login_usecase.dart';
import 'package:bazarche/presentation/navigations/bazarche_app.dart';
import 'package:bazarche/presentation/utils/bazarche.dart';
import 'package:bazarche/presentation/utils/state_status.dart';
import 'package:get/get.dart';

class SplashPageController extends GetxController{
  var splashStatus = StateStatus.INITIAL.obs;
  bool login = false;
  RxList lis=[].obs;
  isLogin(){
    // Get.offAndToNamed(BazarcheAppRoutes.homePage);
    splashStatus.value = StateStatus.LOADING;
    IsLoginUseCase isLoginUseCase = Get.find();
    isLoginUseCase.call(NoParams()).then((response) {
      getAllCategories();
      if(response.isRight){

        login = true;
      }else if(response.isLeft){

          login = false;
          if(response.left != null) {
          ServerFailure failure = response.left;
          splashStatus.value = StateStatus.ERROR;
        }
      }
    });
  }
  getAllCategories(){
    GetAllCategoryUseCase getAllCategoryUseCase = Get.find();
    getAllCategoryUseCase.call(NoParams()).then((response) {
      if(response.isRight){
        Bazarche().allCategoryEntity= response.right;
        Bazarche().category.add(Data(name: 'همه',color: '318fb5'));
        Bazarche().category.addAll(Bazarche().allCategoryEntity.data);
        getAllServices();
      }else if(response.isLeft){
        login = false;
        splashStatus.value = StateStatus.ERROR;
      }
    });
  }
  getAllServices(){
    GetAllServicesUseCase getAllServicesUseCase = Get.find();
    getAllServicesUseCase.call(NoParams()).then((response){
      if(response.isRight){
        Bazarche().allServicesEntity= response.right;
        getAllFacilities();
      }else if(response.isLeft){
        login = false;
        splashStatus.value = StateStatus.ERROR;
      }
    });
  }

  getAllFacilities(){
    GetAllFacilitiesUseCase getAllFacilitiesUseCase = Get.find();
    getAllFacilitiesUseCase.call(NoParams()).then((response){
      if(response.isRight){
        splashStatus.value = StateStatus.SUCCESS;
        Bazarche().allFacilitiesEntity= response.right;
        if(!login)
          Get.offAndToNamed(BazarcheAppRoutes.loginPage);
        else
          getFollowing();
      }else if(response.isLeft){
        login = false;
        splashStatus.value = StateStatus.ERROR;
      }
    });
  }
  getFollowing(){
    GetFollowingUseCase getFollowingUseCase = Get.find();
    getFollowingUseCase.call(NoParams()).then((response) {
      if(response.isRight){
        Bazarche().followings.addAll(response.right.data);
        Get.offAndToNamed(BazarcheAppRoutes.homePage);
      }else if(response.isLeft){
        splashStatus.value = StateStatus.ERROR;
      }
    });
  }
}