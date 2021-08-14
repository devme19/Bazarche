import 'package:bazarche/core/error/failures.dart';
import 'package:bazarche/core/usecase/usecase.dart';
import 'package:bazarche/domain/entities/job_profile_entity.dart';
import 'package:bazarche/domain/repository/bazarche_app_repository.dart';
import 'package:either_type/src/either.dart';

class GetJobProfileUseCase implements UseCase<JobProfileEntity,Params>{
  final BazarcheAppRepository repository;

  GetJobProfileUseCase({this.repository});

  @override
  Future<Either<Failure, JobProfileEntity>> call(Params params) {
    return repository.getJobProfile(params.id, params.body);
  }
}