import 'package:bazarche/data/model/job_profile_model.dart';

class JobProfileEntity{
  bool successful;
  String message;
  int statusCode;
  Data data;

  JobProfileEntity({this.successful, this.message, this.statusCode, this.data});
}