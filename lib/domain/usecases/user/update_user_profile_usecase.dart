import 'package:bazarche/core/error/failures.dart';
import 'package:bazarche/core/usecase/usecase.dart';
import 'package:bazarche/core/usecase/usecase_with_call_back.dart';
import 'package:bazarche/domain/repository/bazarche_app_repository.dart';
import 'package:either_type/src/either.dart';

class UpdateUserProfileUseCase implements UseCaseWithCallBack<bool,Params>{
  final BazarcheAppRepository repository;

  UpdateUserProfileUseCase({this.repository});

  @override
  Future<Either<Failure, bool>> call(Params params, callBack) {
   return repository.updateUserProfile(params.formData, callBack);
  }
}