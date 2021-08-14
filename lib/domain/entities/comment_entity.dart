import 'package:bazarche/data/model/comment_model.dart';

class CommentEntity{
  bool successful;
  String message;
  int statusCode;
  List<Data> data;

  CommentEntity({this.successful, this.message, this.statusCode, this.data});
}