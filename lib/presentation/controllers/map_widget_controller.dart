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

class MapWidgetController extends GetxController{
  var mapViewStatus = StateStatus.INITIAL.obs;
  Rx<MyMarker> markers= MyMarker().obs;
  Rx<latLng.LatLng> initialCameraPosition = latLng.LatLng(35.689198, 51.388973).obs;
  latLng.LatLng initialPosition;
  MapController mapController = new MapController();
  Position latestPosition;
  var getNearLocationsStatus = StateStatus.INITIAL.obs;
  Map<String, dynamic> jsonMap;
  bool isSearch = false;
  ValueChanged<bool> onMakerTap;
  HomePageController homeController;
  @override
  void onInit() {
    super.onInit();
    // homeController = Get.find<HomeController>();
    determinePosition();
  }

  Future<Position> determinePosition() async {
    mapViewStatus.value = StateStatus.LOADING;
    await getLocationPermission();
    // for(latLng.LatLng item in latLngs)
    //   markers.add(Marker(
    //     width: 200.0,
    //     height: 200.0,
    //     point: item,
    //     builder: (ctx) =>
    //         InkWell(
    //           onTap: (){
    //             Get.snackbar('', 'lat:${item.latitude} lang:${item.longitude}');
    //           },
    //           child: Container(
    //             child: Icon(Icons.location_on,color: Colors.blue,size: 50,),
    //           ),
    //         ),
    //   ));

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.

    latestPosition = await Geolocator.getCurrentPosition();
    if(initialPosition!=null)
      initialCameraPosition.value = initialPosition;
    else
    initialCameraPosition.value = latLng.LatLng(latestPosition.latitude,latestPosition.longitude);
    // markers.value.items.add(Marker(
    //   width: 200.0,
    //   height: 200.0,
    //   point: initialCameraPosition.value,
    //   builder: (ctx) =>
    //       Container(
    //         child: Icon(Icons.location_on,color: Colors.red,size: 50,),
    //       ),
    // ));
    // currentLocationMarker = Marker(
    //   width: 80.0,||
    //   height: 80.0,
    //   point: _initialCameraPosition,
    //
    // );
    // loading = false;
    mapViewStatus.value = StateStatus.SUCCESS;
    return await Geolocator.getCurrentPosition();
  }
  getLocationPermission() async{
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

  }
  getMapCenter(){
    initialCameraPosition.value = mapController.center;
    markers.value.items.clear();
    markers.value.items.add(Marker(
      width: 200.0,
      height: 200.0,
      point: initialCameraPosition.value,
      builder: (ctx) =>
          Container(
            child: Icon(Icons.location_on,color: Colors.red,size: 50,),
          ),
    ));
  }
  getCurrentPosition()async{
    // markers.value.items.clear();
    Geolocator.getCurrentPosition().then((position) {
      print('lat:${latestPosition.latitude-position.latitude}');
      print('long:${latestPosition.longitude-position.longitude}');
      if((position.latitude-latestPosition.latitude).abs()>0.0005 ||
          (position.longitude-latestPosition.longitude).abs()>0.0005) {
        latestPosition = position;
        Bazarche().currentPosition = position;
        markers.value.items.clear();
        initialCameraPosition.value = latLng.LatLng(latestPosition.latitude,latestPosition.longitude);
        markers.value.items.add(Marker(
          width: 15.0,
          height: 15.0,
          point: initialCameraPosition.value,
          builder: (ctx) =>
              Container(
                  height: 15,width: 15,
                  child: SvgPicture.asset('assets/icons/dot.svg',color: primaryColor,)
              ),
        ));
        mapController.move(initialCameraPosition.value, 5);
        getNearLocations(null);
      }
    });
    initialCameraPosition.value = latLng.LatLng(latestPosition.latitude,latestPosition.longitude);
    markers.value.items.add(Marker(
      width: 20.0,
      height: 20.0,
      point: initialCameraPosition.value,
      builder: (ctx) =>
          Container(
              height: 20,width: 20,
            child: SvgPicture.asset('assets/icons/dot.svg',color: primaryColor,)
          ),
    ));
    mapController.move(initialCameraPosition.value, 15);
  }
  setMarker(List<Data> jobs,ValueChanged<bool> parentAction,bool search){
    isSearch = search;
    markers.value= MyMarker();
    int index;
    markers.value.items.add(Marker(
      width: 15.0,
      height: 15.0,
      point: initialCameraPosition.value,
      builder: (ctx) =>
          Container(
              height: 15,width: 15,
              child: SvgPicture.asset('assets/icons/dot.svg',color: primaryColor,)
          ),
    ));
    for(Data item in jobs) {
      catModel.Data categoryObj =Bazarche().category.firstWhere((category) => category.sId == item.job.category);

      markers.value.items.add(Marker(
        width: 50.0,
        height: 50.0,
        point: latLng.LatLng(
            item.job.location.coordinates[1], item.job.location.coordinates[0]),
        builder: (ctx) => InkWell(
          onTap: () {
            // Get.snackbar('', 'lat:${item.latitude} lang:${item.longitude}');\
            Get.bottomSheet(
                InkWell(
                  onTap: (){
                    Get.back();
                    Get.toNamed(BazarcheAppRoutes.jobProfilePage,arguments: item.sId);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                      borderRadius: BorderRadius.only(topRight: Radius.circular(50),topLeft: Radius.circular(50))
                    ),

                    height: 220,
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Column(
                        children: [
                          Expanded(flex:2,child: BestListItemWidget(data: item,)),
                          SizedBox(height: 16.0,),

                          Expanded(
                            child:
                            Container(
                              
                              margin: EdgeInsets.symmetric(horizontal: 64.0),
                              child: Row(
                                children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: (){
                                      MapsLauncher.launchCoordinates(item.job.location.coordinates[1], item.job.location.coordinates[0]);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(vertical: 16,horizontal: 32),
                                      decoration: BoxDecoration(
                                        color: primaryColor,
                                        borderRadius: BorderRadius.all(Radius.circular(15)),
                                      ),
                                      child: Center(child: Text('مسیریابی',style: TextStyle(color: Colors.white),)),
                                    ),
                                  ),
                                ),
                                SizedBox(width:32.0),
                                Expanded(
                                    child: InkWell(
                                    onTap: (){
                                      // _launchURL('tel:${item.job.}');
                                    }
                                    ,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(vertical: 16,horizontal: 32),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(Radius.circular(15)),
                                        border: Border.all(color: primaryColor)
                                      ),
                                      child: Center(child: Text('تماس',style: TextStyle(color: primaryColor),)),
                                    ),
                                ),
                                  )
                              ],),
                            ),
                          )
                        ],
                      )),
                )
            );
            if(parentAction!=null)
              parentAction(true);
          },
          child: Container(
            // color: Colors.yellow,
              child: Stack(
            children: [
              Align(alignment: Alignment.topCenter,child: Padding(
                padding: const EdgeInsets.only(top:5.0),
                child: SvgPicture.network(uploadBaseUrl+'categories/'+categoryObj.icon,width: 20,height: 20,),
              )),
              Align(alignment:Alignment.center,child: SvgPicture.asset('assets/icons/unselected.svg',color: Color(int.parse('0xff${categoryObj.color}')),)),
            ],
          )),
        ),
      ));
    }
    // mapController.move(initialCameraPosition.value, 11);
  }
  void _launchURL(String _url) async =>
      await canLaunch(_url) ? await launch(_url) : print ('Could not launch $_url');
  setDesirePositionMarker(latLng.LatLng position){
    markers.value= MyMarker();
    markers.value.items.add(Marker(
      width: 15.0,
      height: 15.0,
      point: position,
      builder: (ctx) =>
          Container(
              height: 15,width: 15,
              child: SvgPicture.asset('assets/icons/dot.svg',color: primaryColor,)
          ),
    ));
    mapController.move(position, 15);
  }
  getNearLocations(ValueChanged<bool> makerTap) async {
    // status(StateStatus.LOADING);
    if(makerTap != null)
      onMakerTap = makerTap;
    isSearch = false;
      GetNearLocationsUseCase getNearLocationsUseCase = Get.find();
      if(Bazarche().currentPosition != null) {
        jsonMap = {
          'lat': mapController.center.latitude,
          'long': mapController.center.longitude,
        };
      } else {
        Position currentPosition = await Geolocator.getCurrentPosition();
        Bazarche().currentPosition = currentPosition;
        jsonMap = {
          'lat': currentPosition.latitude,
          'long': currentPosition.longitude,
        };
      }
      getNearLocationsStatus.value = StateStatus.LOADING;
      getNearLocationsUseCase.call(Params(body: jsonMap)).then((response) {
        if (response.isRight) {
          getNearLocationsStatus.value = StateStatus.SUCCESS;
          setMarker(response.right.data, onMakerTap,isSearch);
          // status(StateStatus.SUCCESS);
        } else if (response.isLeft) {
          getNearLocationsStatus.value = StateStatus.ERROR;
        }
      });
  }

}