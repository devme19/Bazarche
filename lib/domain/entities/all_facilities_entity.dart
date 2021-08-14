import 'package:bazarche/data/model/all_facilities_model.dart';

class AllFacilitiesEntity{
  bool successful;
  String message;
  int statusCode;
  List<Data> data;

  AllFacilitiesEntity({this.successful, this.message, this.statusCode, this.data});
}