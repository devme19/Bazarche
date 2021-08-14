
import 'package:bazarche/core/error/exceptions.dart';
import 'package:get_storage/get_storage.dart';

abstract class BazarcheAppLocalDataSource{
  saveRefreshToken(String token);
  String getRefreshToken();
  String getAuthToken();
  saveAuthToken(String authToken);
  logOut();
}


class BazarcheAppLocalDataSourceImpl implements BazarcheAppLocalDataSource{
  GetStorage box;

  final String refreshToken =  "refreshToken";
  final String authToken =  "authToken";
  BazarcheAppLocalDataSourceImpl(){
   box = GetStorage();
  }


  @override
  String getRefreshToken() {
    try{
      return box.read(refreshToken);
    }catch(e){
      throw CacheException();
    }
  }

  @override
  saveRefreshToken(String refToken) {
    try{
      box.write(refreshToken, refToken);
    }catch(e){
      throw CacheException();
    }
  }
  @override
  bool logOut() {
    try{
      box.remove(refreshToken);
      return true;
    }catch(e){
      throw CacheException();
    }
  }

  @override
  String getAuthToken() {
    try{
      return box.read(authToken);
    }catch(e){
      throw CacheException();
    }
  }

  @override
  saveAuthToken(String accessToken) {
    try{
      box.write(authToken, accessToken);
    }catch(e){
      throw CacheException();
    }
  }

}