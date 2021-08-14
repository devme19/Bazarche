import 'package:bazarche/core/error/failures.dart';
import 'package:bazarche/core/usecase/usecase.dart';
import 'package:bazarche/domain/entities/login_entity.dart';
import 'package:bazarche/domain/repository/bazarche_app_repository.dart';
import 'package:either_type/src/either.dart';

class LoginUseCase implements UseCase<bool,Params>{
  final BazarcheAppRepository repository;

  LoginUseCase({this.repository});

  @override
  Future<Either<Failure, bool>> call(Params params) {
    return repository.login(params.body);
  }
}