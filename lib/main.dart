// @dart=2.9
import 'package:bazarche/data/datasources/remote/client.dart';
import 'package:bazarche/presentation/bindings/main_page_binding.dart';
import 'package:bazarche/presentation/navigations/bazarche_app.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:device_preview/device_preview.dart';
import 'core/config/config.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized()..scheduleAttachRootWidget(FlutterImageCompress());
  // WidgetsFlutterBinding.ensureInitialized();
  // runApp(DevicePreview(
  //   enabled: !kReleaseMode,
  //   builder: (context) => MyApp(),
  // ));
  runApp(MyApp());
  Client().init();

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(Get.width, Get.height),
        builder: () => GetMaterialApp(
          // builder: DevicePreview.appBuilder,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: primaryColor,
          fontFamily: 'IRANYekan',
          hintColor: Colors.grey.withOpacity(0.5),
        textTheme: TextTheme(
            subtitle1: TextStyle(fontSize: 21.sp),
          subtitle2: TextStyle(fontSize: 21.sp),
// headline1: TextStyle(fontSize: 72.0),
// headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 18.sp),
          button: TextStyle(fontSize: 21.sp),
        ),
          ),
          initialRoute: BazarcheAppRoutes.splashPage,
          locale: Locale('fa','IR'),
          initialBinding: MainPageBinding(),
          getPages: BazarcheApp.pages,
        ),
    );
  }
}