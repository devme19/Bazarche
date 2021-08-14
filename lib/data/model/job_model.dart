import 'package:bazarche/domain/entities/job_entity.dart';

class JobModel extends JobEntity{

  JobModel({
    bool successful,
    String message,
    int statusCode,
    List<Data> data,
  }):super(
    data: data,
    statusCode: statusCode,
    message: message,
    successful: successful
  );

  JobModel.fromJson(Map<String, dynamic> json) {
    successful = json['successful'];
    message = json['message'];
    statusCode = json['statusCode'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['successful'] = this.successful;
    data['message'] = this.message;
    data['statusCode'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  double averageRate;
  String sId;
  Job job;

  Data({this.averageRate, this.sId, this.job});

  Data.fromJson(Map<String, dynamic> json) {
    averageRate = json['averageRate'];
    sId = json['_id'];
    job = json['job'] != null ? new Job.fromJson(json['job']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['averageRate'] = this.averageRate;
    data['_id'] = this.sId;
    if (this.job != null) {
      data['job'] = this.job.toJson();
    }
    return data;
  }
}

class Job {
  String title;
  String category;
  String profileImage;
  String address;
  int checkIns;
  Location location;
  int comments;

  Job(
      {this.title,
        this.category,
        this.profileImage,
        this.address,
        this.checkIns,
        this.location,
        this.comments});

  Job.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    category = json['category'];
    profileImage = json['profileImage'];
    address = json['address'];
    checkIns = json['checkIns'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    comments = json['comments'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['category'] = this.category;
    data['profileImage'] = this.profileImage;
    data['address'] = this.address;
    data['checkIns'] = this.checkIns;
    if (this.location != null) {
      data['location'] = this.location.toJson();
    }
    data['comments'] = this.comments;
    return data;
  }
}

class Location {
  String type;
  List<double> coordinates;

  Location({this.type, this.coordinates});

  Location.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
    return data;
  }
}
