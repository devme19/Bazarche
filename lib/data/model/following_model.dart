import 'package:bazarche/domain/entities/following_entity.dart';

class FollowingModel extends FollowingEntity{


  FollowingModel({
    bool successful,
    String message,
    int statusCode,
    List<Data> data,
});

  FollowingModel.fromJson(Map<String, dynamic> json) {
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
  String profileImage;
  String sId;
  String title;
  String bio;

  Data({this.profileImage, this.sId, this.title, this.bio});

  Data.fromJson(Map<String, dynamic> json) {
    profileImage = json['profileImage'];
    sId = json['_id'];
    title = json['title'];
    bio = json['bio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profileImage'] = this.profileImage;
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['bio'] = this.bio;
    return data;
  }
}
