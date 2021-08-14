import 'package:bazarche/core/error/failures.dart';
import 'package:bazarche/core/usecase/usecase.dart';
import 'package:bazarche/domain/entities/following_entity.dart';
import 'package:bazarche/domain/repository/bazarche_app_repository.dart';
import 'package:either_type/src/either.dart';

class GetFollowingUseCase implements UseCase<FollowingEntity,NoParams>{
  final BazarcheAppRepository repository;

  GetFollowingUseCase({this.repository});

  @override
  Future<Either<Failure, FollowingEntity>> call(NoParams params) {
    return repository.getFollowing();
  }
}