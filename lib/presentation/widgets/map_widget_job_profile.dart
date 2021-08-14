import 'dart:async';

import 'package:bazarche/core/config/config.dart';
import 'package:bazarche/presentation/controllers/home_page_controller.dart';
import 'package:bazarche/presentation/controllers/job_profile_map_controller.dart';
import 'package:bazarche/presentation/controllers/map_widget_controller.dart';
import 'package:bazarche/presentation/utils/state_status.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gesture_x_detector/gesture_x_detector.dart';
import 'package:get/get.dart';
// import 'package:geolocation/geolocation.dart';
import "package:latlong/latlong.dart" as latLng;

import 'connection_error.dart';

class MapWidgetJobProfile extends StatelessWidget {

  latLng.LatLng position ;
  MapWidgetJobProfile({this.position}){
    if(position!=null) {
      // controller.initialPosition = initialPosition;
    }
    // controller.determinePosition();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.35),
              spreadRadius: 0.2,
              blurRadius: 3,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(40))
      ),
      child:
      Stack(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(40)),
                child: FlutterMap(
                  options: MapOptions(
                    center: position,
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
                      markers:
                      [
                        Marker(
                          width: 15.0,
                          height: 15.0,
                          point: position,
                          builder: (ctx) =>
                              Container(
                                  height: 15,width: 15,
                                  child: SvgPicture.asset('assets/icons/dot.svg',color: primaryColor,)
                              ),
                        )
                      ]
                      ,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}