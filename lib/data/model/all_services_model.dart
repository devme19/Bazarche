import 'package:bazarche/domain/entities/all_services_entity.dart';

class AllServicesModel extends AllServicesEntity{


  AllServicesModel({
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

  AllServicesModel.fromJson(Map<String, dynamic> json) {
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
  String name;
  String color;
  String icon;
  int iV;

  Data({this.sId, this.name, this.color, this.icon, this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    color = json['color'];
    icon = json['icon'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['color'] = this.color;
    data['icon'] = this.icon;
    data['__v'] = this.iV;
    return data;
  }
}
