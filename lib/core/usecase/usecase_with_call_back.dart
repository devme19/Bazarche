import 'package:bazarche/core/error/failures.dart';
import 'package:either_type/either_type.dart';
import 'package:flutter/material.dart';

abstract class UseCaseWithCallBack<Type, Params> {
  Future<Either<Failure, Type>> call(Params params,ValueChanged<double> callBack);
}