import 'package:bazarche/domain/entities/own_comment_entity.dart';

class OwnCommentModel extends OwnCommentEntity{


  OwnCommentModel({
    bool successful,
    String message,
    int statusCode,
    Data data,
}):super(
    successful: successful,
    message: message,
    statusCode: statusCode,
    data: data
  );

  OwnCommentModel.fromJson(Map<String, dynamic> json) {
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
  String date;
  String sId;
  String userId;
  String jobId;
  String content;
  User user;
  int rate;

  Data(
      {this.date,
        this.sId,
        this.userId,
        this.jobId,
        this.content,
        this.user,
        this.rate});

  Data.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    sId = json['_id'];
    userId = json['userId'];
    jobId = json['jobId'];
    content = json['content'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    data['jobId'] = this.jobId;
    data['content'] = this.content;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['rate'] = this.rate;
    return data;
  }
}

class User {
  String fullname;
  int score;
  bool verified;
  List<String> checkIns;
  List<String> following;
  String phone;
  String token;
  int iV;
  String bio;
  String email;
  String profileImage;
  String id;

  User(
      {this.fullname,
        this.score,
        this.verified,
        this.checkIns,
        this.following,
        this.phone,
        this.token,
        this.iV,
        this.bio,
        this.email,
        this.profileImage,
        this.id});

  User.fromJson(Map<String, dynamic> json) {
    fullname = json['fullname'];
    score = json['score'];
    verified = json['verified'];
    checkIns = json['checkIns'].cast<String>();
    following = json['following'].cast<String>();
    phone = json['phone'];
    token = json['token'];
    iV = json['__v'];
    bio = json['bio'];
    email = json['email'];
    profileImage = json['profileImage'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullname'] = this.fullname;
    data['score'] = this.score;
    data['verified'] = this.verified;
    data['checkIns'] = this.checkIns;
    data['following'] = this.following;
    data['phone'] = this.phone;
    data['token'] = this.token;
    data['__v'] = this.iV;
    data['bio'] = this.bio;
    data['email'] = this.email;
    data['profileImage'] = this.profileImage;
    data['id'] = this.id;
    return data;
  }
}
