import 'package:bazarche/data/model/job_model.dart';

class JobEntity{
  bool successful;
  String message;
  int statusCode;
  List<Data> data;

  JobEntity({this.successful, this.message, this.statusCode, this.data});
}