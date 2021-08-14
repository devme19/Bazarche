import 'package:bazarche/data/model/own_comment_model.dart';

class OwnCommentEntity{
  bool successful;
  String message;
  int statusCode;
  Data data;

  OwnCommentEntity({this.successful, this.message, this.statusCode, this.data});
}