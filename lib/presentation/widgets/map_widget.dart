import 'dart:async';

import 'package:bazarche/core/config/config.dart';
import 'package:bazarche/presentation/controllers/home_page_controller.dart';
import 'package:bazarche/presentation/controllers/map_widget_controller.dart';
import 'package:bazarche/presentation/utils/state_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gesture_x_detector/gesture_x_detector.dart';
import 'package:get/get.dart';
// import 'package:geolocation/geolocation.dart';
import "package:latlong/latlong.dart" as latLng;

import 'connection_error.dart';

class MapWidget extends GetView<MapWidgetController> {

  Offset currentPosition;
  latLng.LatLng position ;
  MapWidget({this.position}){
    if(position!=null) {
      // controller.initialPosition = initialPosition;
      controller.setDesirePositionMarker(position);
    }
    // controller.determinePosition();
  }
  @override
  Widget build(BuildContext context) {
    return Obx(()=>
        controller.mapViewStatus.value == StateStatus.LOADING?
        Scaffold(body:
        Center(child: SpinKitDoubleBounce(
          color: Colors.red,
        ))):
        Container(
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.35),
                  spreadRadius: 0.2,
                  blurRadius: 3,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40),bottomRight: Radius.circular(40))
          ),
          child:
          Stack(
            children: [
              XGestureDetector(
                onMoveUpdate: (event) {
                  currentPosition = event.position;
                },
                onMoveEnd: (MoveEvent moveEvent) async{
                  if(!controller.isSearch) {
                    controller.getNearLocationsStatus.value =
                        StateStatus.LOADING;
                    var beforePosition = moveEvent.position;
                    await Future.delayed(Duration(seconds: 2));
                    // print('before x:${beforePosition.dx} y: ${beforePosition.dy} ---- after x:${currentPosition.dx} y: ${currentPosition.dy}');
                    if (beforePosition == currentPosition)
                      controller.getNearLocations(null);
                  }

                },
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40),bottomRight: Radius.circular(40)),
                      child: FlutterMap(
                        mapController: controller.mapController,
                        options: MapOptions(

                          // onPositionChanged: (mapPosition, boolValue){
                          //   if(!controller.isSearch)
                          //     controller.getNearLocations(null);
                          //
                          // },
                          center: controller.initialCameraPosition.value,
                          zoom: 13.0,
                        ),
                        layers: [
                          TileLayerOptions(
                              urlTemplate: "https://api.mapbox.com/styles/v1/cr7me/ckquo98p97p3x17nwjiwt6zgy/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiY3I3bWUiLCJhIjoiY2txczFqNjliMTU2NjJxbmJpZ2plcGlheSJ9.bQ_5pM6WnHdac7QnK26vgA",
                              additionalOptions: {
                                'accessToken':'pk.eyJ1IjoiY3I3bWUiLCJhIjoiY2txczFqNjliMTU2NjJxbmJpZ2plcGlheSJ9.bQ_5pM6WnHdac7QnK26vgA',
                                'id':'mapbox.mapbox-streets-v8',
                                'language':'fa-IR'
                              }
                          ),
                          MarkerLayerOptions(
                            markers: controller.markers.value.items
                            // [
                            //   Marker(
                            //     width: 200.0,
                            //     height: 200.0,
                            //     point: _initialCameraPosition,
                            //     builder: (ctx) =>
                            //         Container(
                            //           child: Icon(Icons.location_on,color: Colors.red,size: 50,),
                            //         ),
                            //   ),
                            // ]
                            ,
                          ),
                        ],
                      ),
                    ),
                    controller.getNearLocationsStatus.value == StateStatus.ERROR?
                    Align(
                      child: ConnectionError(parentAction: null,),
                    ):
                    !controller.isSearch?Align(
                      child: Icon(Icons.location_on,color: Colors.red,size: 50,),
                      alignment: Alignment.center,
                    ):Container()
                  ],
                ),
              ),
              controller.getNearLocationsStatus.value == StateStatus.LOADING?
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      // color: Colors.yellow,
                      width: 30,
                      height: 78,
                      child: 
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: SpinKitPulse(
                                  color: Colors.red,
                                  size: 15,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ):
              controller.getNearLocationsStatus.value == StateStatus.SUCCESS?
                  Container():
              controller.getNearLocationsStatus.value == StateStatus.ERROR?
                  ConnectionError(parentAction: retry,):
                  Container()
            ],
          ),
        )
    );
  }
  retry(bool value){
    controller.getNearLocations(null);
  }
}

// class MapWidget extends StatefulWidget {
//   RxList latLngs;
//   ValueChanged<latLng.LatLng> getCenter;
//   MapWidget({this.latLngs});
//   @override
//   _MapWidgetState createState() => _MapWidgetState();
// }
//
// class _MapWidgetState extends State<MapWidget> {
//   // Position currentLocation = new Position(longitude: 50, latitude: 60, timestamp: timestamp, accuracy: accuracy, altitude: altitude, heading: heading, speed: speed, speedAccuracy: speedAccuracy)
//
//   Marker currentLocationMarker;
//
//   bool loading=true;
//   List<Marker> markers=[];
//   @override
//   void initState() {
//     super.initState();
//     _determinePosition();
//
//   }
//
//
//   @override
//   Widget build(BuildContext context){
//
//     return
//       loading?
//
//       // loading?CircularProgressIndicator():
//     //   FlutterMap(
//     //   mapController: mapController,
//     //   options: MapOptions(
//     //
//     //     center: _initialCameraPosition,
//     //     zoom: 13.0,
//     //   ),
//     //   layers: [
//     //     TileLayerOptions(
//     //         urlTemplate: "https://api.mapbox.com/styles/v1/cr7me/ckquo98p97p3x17nwjiwt6zgy/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiY3I3bWUiLCJhIjoiY2txczFqNjliMTU2NjJxbmJpZ2plcGlheSJ9.bQ_5pM6WnHdac7QnK26vgA",
//     //         additionalOptions: {
//     //           'accessToken':'pk.eyJ1IjoiY3I3bWUiLCJhIjoiY2txczFqNjliMTU2NjJxbmJpZ2plcGlheSJ9.bQ_5pM6WnHdac7QnK26vgA',
//     //           'id':'mapbox.mapbox-streets-v8'
//     //         }
//     //     ),
//     //     // MarkerLayerOptions(
//     //     //   markers: [
//     //     //     currentLocationMarker
//     //     //   ],
//     //     // ),
//     //   ],
//     // );
//   }
// }
