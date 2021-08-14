import 'package:bazarche/core/error/failures.dart';
import 'package:bazarche/core/usecase/usecase.dart';
import 'package:bazarche/domain/entities/comment_entity.dart';
import 'package:bazarche/domain/repository/bazarche_app_repository.dart';
import 'package:either_type/src/either.dart';

class GetCommentUseCase implements UseCase<CommentEntity,Params>{
  final BazarcheAppRepository repository;

  GetCommentUseCase({this.repository});

  @override
  Future<Either<Failure, CommentEntity>> call(Params params) {
    return repository.getComments(params.id, params.body);
  }

}