import 'package:bazarche/domain/entities/comment_entity.dart';

class CommentModel extends CommentEntity{


  CommentModel({
    bool successful,
    String message,
    int statusCode,
    List<Data> data,
}):super(data: data,statusCode: statusCode,message: message,successful: successful);

  CommentModel.fromJson(Map<String, dynamic> json) {
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
  String content;
  String jobId;
  String userId;
  User user;
  int rate;

  Data({this.sId, this.content, this.jobId, this.userId, this.user, this.rate});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    content = json['content'];
    jobId = json['jobId'];
    userId = json['userId'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['content'] = this.content;
    data['jobId'] = this.jobId;
    data['userId'] = this.userId;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['rate'] = this.rate;
    return data;
  }
}

class User {
  String fullname;
  String phone;
  String email;
  String bio;
  bool verified;
  int score;
  String profileImage;
  String id;

  User(
      {this.fullname,
        this.phone,
        this.email,
        this.bio,
        this.verified,
        this.score,
        this.profileImage,
        this.id});

  User.fromJson(Map<String, dynamic> json) {
    fullname = json['fullname'];
    phone = json['phone'];
    email = json['email'];
    bio = json['bio'];
    verified = json['verified'];
    score = json['score'];
    profileImage = json['profileImage'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullname'] = this.fullname;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['bio'] = this.bio;
    data['verified'] = this.verified;
    data['score'] = this.score;
    data['profileImage'] = this.profileImage;
    data['id'] = this.id;
    return data;
  }
}
