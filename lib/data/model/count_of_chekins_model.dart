import 'package:bazarche/domain/entities/count_of_checkins_entity.dart';

class CountOfCheckInsModel extends CountOfCheckInsEntity{


  CountOfCheckInsModel(
      {
        bool successful,
        String message,
        int statusCode,
        int data,
}):super(
    data: data,
    statusCode: statusCode,
    message: message,
    successful: successful
  );

  CountOfCheckInsModel.fromJson(Map<String, dynamic> json) {
    successful = json['successful'];
    message = json['message'];
    statusCode = json['statusCode'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['successful'] = this.successful;
    data['message'] = this.message;
    data['statusCode'] = this.statusCode;
    data['data'] = this.data;
    return data;
  }
}