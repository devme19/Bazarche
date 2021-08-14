import 'package:bazarche/domain/usecases/job/get_best_jobs_usecase.dart';
import 'package:bazarche/domain/usecases/job/get_jobs_by_search_usecase.dart';
import 'package:bazarche/domain/usecases/job/get_near_locations_usecase.dart';
import 'package:bazarche/presentation/controllers/home_page_controller.dart';
import 'package:bazarche/presentation/controllers/map_widget_controller.dart';
import 'package:get/get.dart';

class HomePageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<GetBestJobsUseCase>(() => GetBestJobsUseCase(
      repository: Get.find()
    ));

    Get.lazyPut<HomePageController>(() => HomePageController());
    Get.lazyPut<GetJobsBySearchUseCase>(() => GetJobsBySearchUseCase(
      repository: Get.find()
    ));
    Get.lazyPut<GetNearLocationsUseCase>(() => GetNearLocationsUseCase(
      repository: Get.find()
    ));
  }

}