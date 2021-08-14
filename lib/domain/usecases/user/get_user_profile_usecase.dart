import 'package:bazarche/core/error/failures.dart';
import 'package:bazarche/core/usecase/usecase.dart';
import 'package:bazarche/domain/entities/profile_entity.dart';
import 'package:bazarche/domain/repository/bazarche_app_repository.dart';
import 'package:either_type/src/either.dart';

class GetUserProfileUseCase implements UseCase<ProfileEntity,NoParams>{
  final BazarcheAppRepository repository;

  GetUserProfileUseCase({this.repository});

  @override
  Future<Either<Failure, ProfileEntity>> call(NoParams params) {
    return repository.getUserProfile();
  }
}