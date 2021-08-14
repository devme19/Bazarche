import 'package:bazarche/data/model/all_category_model.dart';
import 'package:bazarche/domain/entities/all_category_entity.dart';
import 'package:bazarche/domain/entities/all_facilities_entity.dart';
import 'package:bazarche/domain/entities/all_services_entity.dart';
import 'package:geolocator/geolocator.dart';
import 'package:bazarche/data/model/following_model.dart' as following;
class Bazarche{

  static final Bazarche _bazarche = Bazarche._internal();

  factory Bazarche() {
    return _bazarche;
  }

  Bazarche._internal();

  AllCategoryEntity allCategoryEntity;
  List<Data> category= [];
  List<following.Data> followings= [];
  AllServicesEntity allServicesEntity;
  AllFacilitiesEntity allFacilitiesEntity;
  Position currentPosition;

}