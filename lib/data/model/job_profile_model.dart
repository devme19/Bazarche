import 'package:bazarche/domain/entities/job_profile_entity.dart';

class JobProfileModel extends JobProfileEntity{


  JobProfileModel({
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

  JobProfileModel.fromJson(Map<String, dynamic> json) {
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
  List<String> facilities;
  List<String> services;
  List<String> phone;
  int checkIns;
  int followers;
  int views;
  bool isLicensed;
  bool isAccepted;
  String title;
  String category;
  String address;
  String profileImage;
  String bio;
  String description;
  List<WorkingTime> workingTime;
  Location location;
  String userId;
  int comments;
  int images;
  double rate;

  Data(
      {this.sId,
        this.facilities,
        this.services,
        this.phone,
        this.checkIns,
        this.followers,
        this.views,
        this.isLicensed,
        this.isAccepted,
        this.title,
        this.category,
        this.address,
        this.bio,
        this.description,
        this.workingTime,
        this.location,
        this.profileImage,
        this.userId,
        this.images,
        this.rate,
        this.comments
      });

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    facilities = json['facilities'].cast<String>();
    services = json['services'].cast<String>();
    phone = json['phone'].cast<String>();
    checkIns = json['checkIns'];
    followers = json['followers'];
    views = json['views'];
    isLicensed = json['isLicensed'];
    rate = json['rate'];
    isAccepted = json['isAccepted'];
    title = json['title'];
    profileImage = json['profileImage'];
    images = json['images'];
    category = json['category'];
        // != null
        // ? new Category.fromJson(json['category'])
        // : null;
    address = json['address'];
    bio = json['bio'];
    description = json['description'];
    if (json['workingTime'] != null) {
      workingTime = [];
      json['workingTime'].forEach((v) {
        workingTime.add(new WorkingTime.fromJson(v));
      });
    }
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    userId = json['userId'];
    comments = json['comments'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['facilities'] = this.facilities;
    data['services'] = this.services;
    data['phone'] = this.phone;
    data['checkIns'] = this.checkIns;
    data['followers'] = this.followers;
    data['views'] = this.views;
    data['isLicensed'] = this.isLicensed;
    data['isAccepted'] = this.isAccepted;
    data['title'] = this.title;
    // if (this.category != null) {
    //   data['category'] = this.category.toJson();
    // }
    data['address'] = this.address;
    data['bio'] = this.bio;
    data['description'] = this.description;
    if (this.workingTime != null) {
      data['workingTime'] = this.workingTime.map((v) => v.toJson()).toList();
    }
    if (this.location != null) {
      data['location'] = this.location.toJson();
    }
    data['userId'] = this.userId;
    data['comments'] = this.comments;
    return data;
  }
}

class Category {
  String sId;
  Null parent;
  String name;
  String color;
  String icon;
  int iV;

  Category({this.sId, this.parent, this.name, this.color, this.icon, this.iV});

  Category.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    parent = json['parent'];
    name = json['name'];
    color = json['color'];
    icon = json['icon'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['parent'] = this.parent;
    data['name'] = this.name;
    data['color'] = this.color;
    data['icon'] = this.icon;
    data['__v'] = this.iV;
    return data;
  }
}

class WorkingTime {
  String sId;
  String day;
  Opens opens;
  Opens closes;

  WorkingTime({this.sId, this.day, this.opens, this.closes});

  WorkingTime.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    day = json['day'];
    opens = json['opens'] != null ? new Opens.fromJson(json['opens']) : null;
    closes = json['closes'] != null ? new Opens.fromJson(json['closes']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['day'] = this.day;
    if (this.opens != null) {
      data['opens'] = this.opens.toJson();
    }
    if (this.closes != null) {
      data['closes'] = this.closes.toJson();
    }
    return data;
  }
}

class Opens {
  int hour;
  int minute;

  Opens({this.hour, this.minute});

  Opens.fromJson(Map<String, dynamic> json) {
    hour = json['hour'];
    minute = json['minute'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hour'] = this.hour;
    data['minute'] = this.minute;
    return data;
  }
}

class Location {
  String type;
  List<double> coordinates;
  String sId;

  Location({this.type, this.coordinates, this.sId});

  Location.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
    data['_id'] = this.sId;
    return data;
  }
}
