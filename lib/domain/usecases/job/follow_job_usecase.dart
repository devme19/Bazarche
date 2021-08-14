import 'package:bazarche/core/error/failures.dart';
import 'package:bazarche/core/usecase/usecase.dart';
import 'package:bazarche/domain/repository/bazarche_app_repository.dart';
import 'package:either_type/src/either.dart';

class FollowJobUseCase implements UseCase<bool,Params>{
  final BazarcheAppRepository repository;

  FollowJobUseCase({this.repository});

  @override
  Future<Either<Failure, bool>> call(Params params) {
   return repository.followJob(params.body);
  }
}