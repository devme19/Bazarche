import 'package:bazarche/data/model/following_model.dart';

class FollowingEntity {
  bool successful;
  String message;
  int statusCode;
  List<Data> data;

  FollowingEntity({this.successful, this.message, this.statusCode, this.data});
}