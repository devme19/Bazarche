import 'package:bazarche/domain/usecases/job/add_checkin_usecase.dart';
import 'package:bazarche/domain/usecases/job/follow_job_usecase.dart';
import 'package:bazarche/domain/usecases/job/get_count_of_checkin_usecase.dart';
import 'package:bazarche/domain/usecases/job/get_images_usecase.dart';
import 'package:bazarche/domain/usecases/job/get_job_profile_usecase.dart';
import 'package:bazarche/domain/usecases/job/unfollow_job_usecase.dart';
import 'package:bazarche/domain/usecases/job/upload_job_images_usecase.dart';
import 'package:bazarche/presentation/controllers/job_profile_page_controller.dart';
import 'package:get/get.dart';

class JobProfilePageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<JobProfilePageController>(() => JobProfilePageController());
    Get.lazyPut<GetJobProfileUseCase>(() => GetJobProfileUseCase(
      repository: Get.find()
    ));
    Get.lazyPut<FollowJobUseCase>(() => FollowJobUseCase(
      repository: Get.find()
    ));
    Get.lazyPut<UnFollowJobUseCase>(() => UnFollowJobUseCase(
        repository: Get.find()
    ));
    Get.lazyPut<GetCountOfCheckInsUseCase>(() => GetCountOfCheckInsUseCase(
      repository: Get.find()
    ));
    Get.lazyPut<AddCheckInUseCase>(() => AddCheckInUseCase(
      repository: Get.find()
    ));
    Get.lazyPut<GetImagesUseCase>(() => GetImagesUseCase(
        repository: Get.find()
    ));
    Get.lazyPut<UploadJobImagesUseCase>(() => UploadJobImagesUseCase(
      repository: Get.find()
    ));
  }

}