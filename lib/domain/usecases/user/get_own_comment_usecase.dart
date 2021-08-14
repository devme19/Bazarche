import 'package:bazarche/core/error/failures.dart';
import 'package:bazarche/core/usecase/usecase.dart';
import 'package:bazarche/domain/entities/own_comment_entity.dart';
import 'package:bazarche/domain/repository/bazarche_app_repository.dart';
import 'package:either_type/src/either.dart';

class GetOwnCommentUseCase implements UseCase<OwnCommentEntity,Params>{
  final BazarcheAppRepository repository;

  GetOwnCommentUseCase({this.repository});

  @override
  Future<Either<Failure, OwnCommentEntity>> call(Params params) {
    return repository.getOwnComment(params.id);
  }
}