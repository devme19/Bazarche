import 'package:bazarche/core/error/failures.dart';
import 'package:bazarche/core/usecase/usecase.dart';
import 'package:bazarche/domain/entities/job_entity.dart';
import 'package:bazarche/domain/repository/bazarche_app_repository.dart';
import 'package:either_type/src/either.dart';

class GetBestJobsUseCase implements UseCase<JobEntity,Params>{
  final BazarcheAppRepository repository;

  GetBestJobsUseCase({this.repository});

  @override
  Future<Either<Failure, JobEntity>> call(Params params) {
    return repository.getBestJobs(params.body,params.value);
  }
}