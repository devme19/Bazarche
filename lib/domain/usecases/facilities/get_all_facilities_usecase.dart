import 'package:bazarche/core/error/failures.dart';
import 'package:bazarche/core/usecase/usecase.dart';
import 'package:bazarche/domain/entities/all_facilities_entity.dart';
import 'package:bazarche/domain/repository/bazarche_app_repository.dart';
import 'package:either_type/src/either.dart';

class GetAllFacilitiesUseCase implements UseCase<AllFacilitiesEntity,NoParams>{
  final BazarcheAppRepository repository;


  GetAllFacilitiesUseCase({this.repository});

  @override
  Future<Either<Failure, AllFacilitiesEntity>> call(NoParams params) {
    return repository.getAllFacilities();
  }

}