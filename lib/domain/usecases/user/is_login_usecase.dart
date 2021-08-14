import 'package:bazarche/core/error/failures.dart';
import 'package:bazarche/core/usecase/usecase.dart';
import 'package:bazarche/domain/repository/bazarche_app_repository.dart';
import 'package:either_type/src/either.dart';

class IsLoginUseCase implements UseCase<bool,NoParams>{
  final BazarcheAppRepository repository;

  IsLoginUseCase({this.repository});

  @override
  Future<Either<Failure, bool>> call(NoParams params) {
    return repository.isLogin();
  }


}