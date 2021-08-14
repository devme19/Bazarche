
import 'package:bazarche/data/model/profile_model.dart';

class ProfileEntity{
  bool successful;
  String message;
  int statusCode;
  Data data;

  ProfileEntity({this.successful, this.message, this.statusCode, this.data});
}