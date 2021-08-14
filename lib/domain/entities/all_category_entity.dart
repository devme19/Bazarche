import 'package:bazarche/data/model/all_category_model.dart';

class AllCategoryEntity {
  bool successful;
  String message;
  int statusCode;
  List<Data> data;

  AllCategoryEntity(
      {this.successful, this.message, this.statusCode, this.data});
}