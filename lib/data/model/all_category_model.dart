import 'package:bazarche/domain/entities/all_category_entity.dart';

class AllCategoryModel extends AllCategoryEntity{


  AllCategoryModel({
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

  AllCategoryModel.fromJson(Map<String, dynamic> json) {
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
  List<SubCategories> subCategories;
  String sId;
  String name;
  String icon;
  String color;

  Data({this.subCategories, this.sId, this.name, this.icon, this.color});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['subCategories'] != null) {
      subCategories = [];
      json['subCategories'].forEach((v) {
        subCategories.add(new SubCategories.fromJson(v));
      });
    }
    sId = json['_id'];
    name = json['name'];
    icon = json['icon'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.subCategories != null) {
      data['subCategories'] =
          this.subCategories.map((v) => v.toJson()).toList();
    }
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['icon'] = this.icon;
    data['color'] = this.color;
    return data;
  }
}

class SubCategories {
  String name;
  String color;
  String icon;
  String sId;

  SubCategories({this.name, this.color, this.icon, this.sId});

  SubCategories.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    color = json['color'];
    icon = json['icon'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['color'] = this.color;
    data['icon'] = this.icon;
    data['_id'] = this.sId;
    return data;
  }
}
