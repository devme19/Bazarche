import 'package:bazarche/core/usecase/usecase.dart';
import 'package:bazarche/domain/entities/profile_entity.dart';
import 'package:bazarche/domain/usecases/user/get_following_usecase.dart';
import 'package:bazarche/domain/usecases/user/get_user_profile_usecase.dart';
import 'package:bazarche/presentation/utils/state_status.dart';
import 'package:get/get.dart';

class UserProfilePageController extends GetxController{
  var getUserProfileState = StateStatus.INITIAL.obs;
  var getFollowingState = StateStatus.INITIAL.obs;
  Rx<ProfileEntity> userProfile = ProfileEntity().obs;
  RxList followingList = [].obs;

  @override
  void onInit() {
    super.onInit();
    getUserProfile();
    getFollowing();
  }

  getUserProfile(){
    getUserProfileState.value  = StateStatus.LOADING;
    GetUserProfileUseCase getUserProfileUseCase = Get.find();
    getUserProfileUseCase.call(NoParams()).then((response) {
      if(response.isRight){
        getUserProfileState.value = StateStatus.SUCCESS;
        userProfile.value = response.right;
      }else if(response.isLeft){
        getUserProfileState.value = StateStatus.ERROR;
      }
    });
  }
  getFollowing(){
    getFollowingState.value = StateStatus.LOADING;
    GetFollowingUseCase getFollowingUseCase = Get.find();
    getFollowingUseCase.call(NoParams()).then((response) {
      if(response.isRight){
        getFollowingState.value = StateStatus.SUCCESS;
        followingList.addAll(response.right.data);
      }else if(response.isLeft){
        getFollowingState.value = StateStatus.ERROR;
      }
    });
  }
}