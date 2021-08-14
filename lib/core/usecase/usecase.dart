import 'package:bazarche/core/error/failures.dart';
import 'package:dio/dio.dart';
import 'package:either_type/either_type.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {

}
// ignore: must_be_immutable
class Params {
  final FormData formData;
  final Map body;
  final bool boolValue;
  final String value;
  String id;
  Params({this.body,this.boolValue,this.id,this.value,this.formData});
}