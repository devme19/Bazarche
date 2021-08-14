import 'package:get/get.dart';
class ServerException implements Exception {
  final int errorCode;
  final String errorMessage;

  ServerException({this.errorCode, this.errorMessage});
// String url;



//   ServerException(int errorCode,String message){
//     errorMessage = message;
//     this.errorCode = errorCode;
//     if(errorCode == 401 && !url.contains("login")) {
//
//       // Get.offAllNamed(MahdiarAppRoutes.loginPage);
//     } else
//       // if(errorCode == 409 && url.contains('user/jobs/check-ins'))
//       //   errorMessage.add('')
//     if(errorCode == 401 && url.contains("login"))
//       errorMessage.add("Email or password is incorrect".tr);
//     else
//     if(errorCode == 402 && url.contains("user/reset"))
//       errorMessage.add("User not exist".tr);
//     else
//     if(errorCode == 422&& url.contains("register"))
//       errorMessage.add("Email already received has been registered".tr);
//     else
//     if(errorCode == 422&& url.contains("changePassword"))
//       errorMessage.add("Old Password does not match".tr);
//     else
//     if(errorCode == 422&& url.contains("drug"))
//       errorMessage.add("Not Found".tr);
//     else
//       if(errorCode==0 || errorCode == 1)
//         errorMessage.add("unable to connect".tr);
//       else
//         errorMessage.add("Unhandled error".tr);
// }
}

class CacheException implements Exception {}
