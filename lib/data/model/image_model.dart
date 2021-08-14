import 'package:bazarche/domain/entities/image_entity.dart';

class ImageModel extends ImageEntity{


  ImageModel({
    bool successful,
    String message,
    int statusCode,
    List<Data> data,
}):super(
    successful: successful,
    message: message,
    statusCode: statusCode,
    data: data
  );

  ImageModel.fromJson(Map<String, dynamic> json) {
    successful = json['successful'];
    message = json['message'];
    statusCode = json['statusCode'];
    if (json['data'] != null) {
      data = [];
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
  String sId;
  String jobId;
  String image;
  String description;
  String userId;
  int iV;

  Data(
      {this.sId,
        this.jobId,
        this.image,
        this.description,
        this.userId,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    jobId = json['jobId'];
    image = json['image'];
    description = json['description'];
    userId = json['userId'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['jobId'] = this.jobId;
    data['image'] = this.image;
    data['description'] = this.description;
    data['userId'] = this.userId;
    data['__v'] = this.iV;
    return data;
  }
}
