import 'package:bazarche/core/error/failures.dart';
import 'package:bazarche/core/usecase/usecase.dart';
import 'package:bazarche/domain/entities/all_services_entity.dart';
import 'package:bazarche/domain/repository/bazarche_app_repository.dart';
import 'package:either_type/src/either.dart';

class GetAllServicesUseCase implements UseCase<AllServicesEntity,NoParams>{
  final BazarcheAppRepository repository;

  GetAllServicesUseCase({this.repository});

  @override
  Future<Either<Failure, AllServicesEntity>> call(NoParams params) {
    return repository.getAllServices();
  }
}