

import 'package:bazarche/data/model/all_category_model.dart';
import 'package:bazarche/data/model/all_facilities_model.dart';
import 'package:bazarche/data/model/all_services_model.dart';
import 'package:bazarche/data/model/comment_model.dart';
import 'package:bazarche/data/model/count_of_chekins_model.dart';
import 'package:bazarche/data/model/following_model.dart';
import 'package:bazarche/data/model/image_model.dart';
import 'package:bazarche/data/model/job_model.dart';
import 'package:bazarche/data/model/job_profile_model.dart';
import 'package:bazarche/data/model/login_model.dart';
import 'package:bazarche/data/model/own_comment_model.dart';
import 'package:bazarche/data/model/profile_model.dart';

class Generics {
  static T fromJson<T,K>(dynamic json) {
    print(T);
    print(K);
    if (json is Iterable) {
      return _fromJsonList<K>(json) as T;
    }
    else
    if (T == AllCategoryModel) {
      return AllCategoryModel.fromJson(json) as T;
    }
    else
    if (T == AllServicesModel) {
      return AllServicesModel.fromJson(json) as T;
    }

    else
    if (T == AllFacilitiesModel) {
      return AllFacilitiesModel.fromJson(json) as T;
    }
    else
    if (T == LoginModel) {
      return LoginModel.fromJson(json) as T;
    }
    else
    if (T == ProfileModel) {
      return ProfileModel.fromJson(json) as T;
    }
    else
    if (T == JobModel) {
      return JobModel.fromJson(json) as T;
    }
    else
    if (T == JobProfileModel) {
      return JobProfileModel.fromJson(json) as T;
    }
    else
    if (T == FollowingModel) {
      return FollowingModel.fromJson(json) as T;
    }
    else
    if (T == ImageModel) {
      return ImageModel.fromJson(json) as T;
    }
    else
    if (T == CountOfCheckInsModel) {
      return CountOfCheckInsModel.fromJson(json) as T;
    }
    else
    if (T == CommentModel) {
      return CommentModel.fromJson(json) as T;
    }
    else
    if (T == OwnCommentModel) {
      return OwnCommentModel.fromJson(json) as T;
    }
    else
      {
        throw Exception("Unknown class");
      }

  }
  static List<K> _fromJsonList<K>(List jsonList) {
    if (jsonList == null) {
      return null;
    }

    List<K> output = [];

    for (Map<String, dynamic> json in jsonList) {
      output.add(fromJson(json));
    }
    return output;
  }
}