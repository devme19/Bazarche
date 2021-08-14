import 'package:bazarche/core/error/failures.dart';
import 'package:bazarche/core/usecase/usecase.dart';
import 'package:bazarche/domain/entities/all_category_entity.dart';
import 'package:bazarche/domain/repository/bazarche_app_repository.dart';
import 'package:either_type/src/either.dart';

class GetAllCategoryUseCase implements UseCase<AllCategoryEntity,NoParams>{

  final BazarcheAppRepository repository;

  GetAllCategoryUseCase({this.repository});

  @override
  Future<Either<Failure, AllCategoryEntity>> call(NoParams params) {
    return repository.getAllCategory();
  }
}