import 'package:bazarche/data/model/all_services_model.dart';

class AllServicesEntity{
  bool successful;
  String message;
  int statusCode;
  List<Data> data;

  AllServicesEntity({this.successful, this.message, this.statusCode, this.data});
}