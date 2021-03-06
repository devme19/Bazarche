import 'dart:io';

import 'package:bazarche/data/datasources/dio_connectivity_request_retrier.dart';
import 'package:dio/dio.dart';

class RetryOnConnectionChangeInterceptor extends Interceptor{
  final DioConnectivityRequestRetrier requestRetrier;

  RetryOnConnectionChangeInterceptor({this.requestRetrier});

  @override
  Future onError(DioError err,ErrorInterceptorHandler handler) async{
    if(_shouldRetry(err)){
      try{
        return requestRetrier.scheduleRequestRetry(err.response.requestOptions);
      }catch(e){
        return e;
      }
    }
    return err;
  }
  bool _shouldRetry(DioError err) {
    return err.type == DioErrorType.other &&
        err.error != null &&
        err.error is SocketException;
  }
}