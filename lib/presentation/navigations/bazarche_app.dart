
import 'package:bazarche/presentation/bindings/comments_page_binding.dart';
import 'package:bazarche/presentation/bindings/edit_user_profile_page_binding.dart';
import 'package:bazarche/presentation/bindings/home_page_binding.dart';
import 'package:bazarche/presentation/bindings/job_profile_page_binding.dart';
import 'package:bazarche/presentation/bindings/login_page_binding.dart';
import 'package:bazarche/presentation/bindings/main_page_binding.dart';
import 'package:bazarche/presentation/bindings/phone_verification_page_binding.dart';
import 'package:bazarche/presentation/bindings/splash_page_binding.dart';
import 'package:bazarche/presentation/bindings/user_profile_page_binding.dart';
import 'package:bazarche/presentation/pages/comments_page.dart';
import 'package:bazarche/presentation/pages/job_detail_page.dart';
import 'package:bazarche/presentation/pages/edit_user_profile_page.dart';
import 'package:bazarche/presentation/pages/job_profile_page.dart';
import 'package:bazarche/presentation/pages/home_page.dart';
import 'package:bazarche/presentation/pages/phone_verification_page.dart';
import 'package:bazarche/presentation/pages/login_page.dart';
import 'package:bazarche/presentation/pages/splash_page.dart';
import 'package:bazarche/presentation/pages/user_profile_page.dart';
import 'package:get/get.dart';

class BazarcheAppRoutes{
  static final String splashPage = "/splashPage";
  static final String phoneVerificationPage = "/phoneVerificationPage";
  static final String loginPage = "/loginPage";
  static final String settingPage = "/settingPage";
  static final String homePage = "/homePage";
  static final String jobProfilePage = "/jobProfilePage";
  static final String userProfilePage = "/userProfilePage";
  static final String editUserProfilePage = "/editUserProfilePage";
  static final String jobDetailPage = "/jobDetailPage";
  static final String commentsPage = "/commentsPage";
}

class BazarcheApp{
  static final pages = [
    GetPage(name: BazarcheAppRoutes.splashPage, page: ()=> SplashPage(),bindings: [MainPageBinding(),SplashPageBinding()]),
    GetPage(name: BazarcheAppRoutes.phoneVerificationPage, page: ()=> PhoneVerificationPage(),bindings: [MainPageBinding(),PhoneVerificationPageBinding()]),
    GetPage(name: BazarcheAppRoutes.loginPage, page: ()=> LoginPage(),bindings: [MainPageBinding(),LoginPageBinding()]),
    GetPage(name: BazarcheAppRoutes.homePage, page: ()=> HomePage(),bindings: [MainPageBinding(),HomePageBinding()]),
    GetPage(name: BazarcheAppRoutes.jobProfilePage, page: ()=> JobProfilePage(),bindings: [MainPageBinding(),JobProfilePageBinding()]),
    GetPage(name: BazarcheAppRoutes.userProfilePage, page: ()=> UserProfilePage(),bindings: [MainPageBinding(),UserProfilePageBinding()]),
    GetPage(name: BazarcheAppRoutes.editUserProfilePage, page: ()=> EditUserProfilePage(),bindings: [MainPageBinding(),EditUserProfilePageBinding()]),
    GetPage(name: BazarcheAppRoutes.jobDetailPage, page: ()=> JobDetailPage(),bindings: [MainPageBinding()]),
    GetPage(name: BazarcheAppRoutes.commentsPage, page: ()=> CommentsPage(),bindings: [MainPageBinding(),CommentsPageBinding()]),
  ];
}