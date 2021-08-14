import 'package:bazarche/data/datasources/remote/client.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

class RefreshTokenInterceptor extends Interceptor{
  GetStorage box = GetStorage();

  @override
  Future onError(DioError error,ErrorInterceptorHandler handler) async{
    if(error.response?.statusCode == 403)
    {
      String refreshToken = box.read('refreshToken');
      Map<String, dynamic> jsonMap = {
        'refreshToken': refreshToken,
      };
      RequestOptions options = error.response.requestOptions;
      Client().dio.interceptors.requestLock.lock();
      Client().dio.interceptors.responseLock.lock();
      Dio tokenDio = Dio();
      tokenDio.options = Client().dio.options;
      Response response = await tokenDio.post("oauth/refreshToken",data: jsonMap);
      String token ="";
      // = AuthModel.fromJson(response.data).authData.accessToken;
      box.write('accessToken', token);
      options.headers['Authorization']='Bearer $token';
      Client().dio.interceptors.requestLock.unlock();
      Client().dio.interceptors.responseLock.unlock();
      handler.next(error);
      // return Client.dio.request(options.path,options: options);
      // return super.onRequest(options, handler);
    }else handler.next(error);
  }
}