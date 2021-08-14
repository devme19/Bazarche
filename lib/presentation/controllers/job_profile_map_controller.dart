import 'package:bazarche/core/config/config.dart';
import 'package:bazarche/core/usecase/usecase.dart';
import 'package:bazarche/data/model/all_category_model.dart' as catModel;
import 'package:bazarche/data/model/job_model.dart';
import 'package:bazarche/domain/usecases/job/get_near_locations_usecase.dart';
import 'package:bazarche/presentation/controllers/home_page_controller.dart';
import 'package:bazarche/presentation/navigations/bazarche_app.dart';
import 'package:bazarche/presentation/utils/bazarche.dart';
import 'package:bazarche/presentation/utils/my_marker.dart';
import 'package:bazarche/presentation/utils/state_status.dart';
import 'package:bazarche/presentation/widgets/best_list_item_widget.dart';
import 'package:bazarche/presentation/widgets/connection_error.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import "package:latlong/latlong.dart" as latLng;
import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

class JobProfileMapController extends GetxController{
  var mapViewStatus = StateStatus.INITIAL.obs;
  Rx<MyMarker> markers= MyMarker().obs;
  latLng.LatLng initialCameraPosition;
  latLng.LatLng initialPosition;
  MapController mapController = new MapController();
  Map<String, dynamic> jsonMap;
  bool isSearch = false;
  ValueChanged<bool> onMakerTap;
  HomePageController homeController;
  @override
  void onInit() {
    super.onInit();
  }
  getCurrentPosition()async{
    markers.value.items.clear();
    markers.value.items.add(Marker(
      width: 15.0,
      height: 15.0,
      point: initialCameraPosition,
      builder: (ctx) =>
          Container(
              height: 15,width: 15,
              child: SvgPicture.asset('assets/icons/dot.svg',color: primaryColor,)
          ),
    ));
    mapController.move(initialCameraPosition, 5);
  }
}