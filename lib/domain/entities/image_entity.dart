import 'package:bazarche/data/model/image_model.dart';

class ImageEntity {
  bool successful;
  String message;
  int statusCode;
  List<Data> data;

  ImageEntity({this.successful, this.message, this.statusCode, this.data});
}