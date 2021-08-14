import 'package:bazarche/core/error/failures.dart';
import 'package:bazarche/core/usecase/usecase.dart';
import 'package:bazarche/domain/entities/login_entity.dart';
import 'package:bazarche/domain/repository/bazarche_app_repository.dart';
import 'package:either_type/src/either.dart';

class PhoneVerificationUseCase implements UseCase<LoginEntity,Params>{
  final BazarcheAppRepository repository;

  PhoneVerificationUseCase({this.repository});

  @override
  Future<Either<Failure, LoginEntity>> call(Params params) {
    return repository.phoneVerification(params.body);
  }
}