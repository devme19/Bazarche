import 'package:bazarche/domain/entities/profile_entity.dart';

class ProfileModel extends ProfileEntity{


  ProfileModel({
    bool successful,
    String message,
    int statusCode,
    Data data,
    }):super(
    data: data,
    statusCode: statusCode,
    message: message,
    successful: successful
  );

  ProfileModel.fromJson(Map<String, dynamic> json) {
    successful = json['successful'];
    message = json['message'];
    statusCode = json['statusCode'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['successful'] = this.successful;
    data['message'] = this.message;
    data['statusCode'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String sId;
  String fullname;
  int score;
  bool verified;
  int checkIns;
  int following;
  String phone;
  String bio;
  String email;
  String profileImage;

  Data(
      {this.sId,
        this.fullname,
        this.score,
        this.verified,
        this.checkIns,
        this.following,
        this.phone,
        this.bio,
        this.email,
        this.profileImage
      });

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    fullname = json['fullname'] ??'';
    score = json['score']??'';
    verified = json['verified']??'';
    checkIns = json['checkIns']??'';
    following = json['following']??'';
    phone = json['phone']??'';
    bio = json['bio']??'';
    email = json['email']??'';
    profileImage = json['profileImage']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['fullname'] = this.fullname;
    data['score'] = this.score;
    data['verified'] = this.verified;
    data['checkIns'] = this.checkIns;
    data['following'] = this.following;
    data['phone'] = this.phone;
    return data;
  }
}
