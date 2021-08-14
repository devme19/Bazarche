import 'package:bazarche/presentation/controllers/splash_page_controller.dart';
import 'package:bazarche/presentation/utils/state_status.dart';
import 'package:bazarche/presentation/widgets/connection_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  SplashPageController splashController = Get.put(SplashPageController());
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        body: Center(
            child:
            Obx(()=>splashController.splashStatus.value == StateStatus.LOADING?
            Container(
                child: SpinKitFoldingCube(
                  color: Theme.of(context).primaryColor,
                  size: 50.0,
                )
            ):splashController.splashStatus.value == StateStatus.ERROR?ConnectionError(parentAction: reConnect,):Container(),)
        ),
      );
  }

  @override
  void initState(){
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      splashController.isLogin();
    });
  }
  reConnect(bool){
    splashController.isLogin();
  }
}