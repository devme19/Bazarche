import 'package:bazarche/data/model/login_model.dart';

class LoginEntity{
  bool successful;
  String message;
  int statusCode;
  Data data;

  LoginEntity({this.successful, this.message, this.statusCode, this.data});
}