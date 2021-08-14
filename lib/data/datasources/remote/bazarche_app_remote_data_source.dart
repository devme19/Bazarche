import 'dart:async';
import 'package:bazarche/core/error/exceptions.dart';
import 'package:bazarche/core/generics.dart';
import 'package:bazarche/data/datasources/remote/client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';


abstract class BazarcheAppRemoteDataSource {
  Future<T> get<T, K>(String url,Map queryParameters);
  Future<T> post<T, K>(Map body, String url);
  Future<bool> delete(String url);
  Future<bool> requestMultiPart(FormData formData,String url,ValueChanged<double> uploadedAmount);
}

class BazarcheAppRemoteDatasourceImpl implements BazarcheAppRemoteDataSource{

  @override
  Future<T> get<T, K>(String url,Map queryParameters) async{
    try{
      Response response = await Client().dio.get(url,queryParameters: queryParameters);
      if(response. statusCode == 200)
      {
        if(T == bool)
          return true as T;
        return Generics.fromJson<T,K>(response.data);
      }
      else
        if(T == bool)
          return false as T;
    }on DioError catch(e){
      if(e.type == DioErrorType.other || e.type == DioErrorType.connectTimeout || e.type == DioErrorType.receiveTimeout)
        throw ServerException(errorCode: 101,errorMessage: 'خطا در برقراری ارتباط');
      else
        throw ServerException(errorCode: e.response.statusCode,errorMessage: e.response.statusMessage);
    }

  }

  @override
  Future<T> post<T, K>(Map body, String url) async{
    // TODO: implement post
    try{
      Response response = await Client().dio.post(url, data: body);
      if (response.statusCode == 200) {
        if (T == bool) return true as T;
        return Generics.fromJson<T, K>(response.data);
      }
      else
      if(T == bool)
        return false as T;
    } on DioError catch(e){
      if(e.type == DioErrorType.other || e.type == DioErrorType.connectTimeout || e.type == DioErrorType.receiveTimeout)
        throw ServerException(errorCode: 101,errorMessage: 'خطا در برقراری ارتباط');
      else
        throw ServerException(errorCode: e.response.statusCode,errorMessage: e.response.statusMessage);
    }
  }
  @override
  Future<bool> delete(String url) async{
    try{
      Response response = await Client().dio.delete(url);
      if (response.statusCode == 200)
        return true;
      else return false;
    } on DioError catch(e){
      if(e.type == DioErrorType.other)
        throw ServerException(errorCode: 101,errorMessage: 'خطا در برقراری ارتباط');
      else
        throw ServerException(errorCode: e.response.statusCode,errorMessage: e.response.statusMessage);
    }
  }

  @override
  Future<bool> requestMultiPart(FormData formData,String url,ValueChanged<double> uploadedAmount) async{
    try{
      Response response = await Client().dio.post(
        url,
        data: formData,
        // options: Options(headers: headers,),
        onSendProgress: (int sent, int total) {
          uploadedAmount(sent/total);
          print('Uploaded : ${sent/total}');
        },
      );
      if(response.statusCode == 200) {
        print("============= Print Resp data: ");
        return true;
      }
      else
      {
        return false;
      }
    }on DioError catch(e){
      if(e.type == DioErrorType.other)
        throw ServerException(errorCode: 101,errorMessage: 'خطا در برقراری ارتباط');
      else
        throw ServerException(errorCode: e.response.statusCode,errorMessage: e.response.statusMessage);
    }
  }
}