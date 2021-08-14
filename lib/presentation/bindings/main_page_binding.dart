import 'package:bazarche/data/datasources/local/bazarche_app_local_data_source.dart';
import 'package:bazarche/data/datasources/remote/bazarche_app_remote_data_source.dart';
import 'package:bazarche/data/repository/bazarche_app_repository_impl.dart';
import 'package:bazarche/domain/repository/bazarche_app_repository.dart';
import 'package:bazarche/domain/usecases/user/login_usecase.dart';
import 'package:bazarche/presentation/controllers/home_page_controller.dart';
import 'package:bazarche/presentation/controllers/map_widget_controller.dart';
import 'package:get/get.dart';

class MainPageBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<BazarcheAppRemoteDataSource>(BazarcheAppRemoteDatasourceImpl());
    Get.put<BazarcheAppLocalDataSource>(BazarcheAppLocalDataSourceImpl());
    Get.put<BazarcheAppRepository>(BazarcheAppRepositoryImpl(
      remoteDataSource: Get.find(),
      localDataSource: Get.find()
    ));
    Get.put<LoginUseCase>(LoginUseCase(
        repository: Get.find()
    ));
  }

}