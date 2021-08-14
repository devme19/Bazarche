import 'package:bazarche/core/error/failures.dart';
import 'package:bazarche/core/usecase/usecase.dart';
import 'package:bazarche/domain/entities/image_entity.dart';
import 'package:bazarche/domain/repository/bazarche_app_repository.dart';
import 'package:either_type/src/either.dart';

class GetImagesUseCase implements UseCase<ImageEntity,Params>{
  final BazarcheAppRepository repository;

  GetImagesUseCase({this.repository});

  @override
  Future<Either<Failure, ImageEntity>> call(Params params) {
    return repository.getImages(params.id,params.body);
  }
}