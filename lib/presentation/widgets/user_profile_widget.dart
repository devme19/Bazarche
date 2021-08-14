import 'package:bazarche/presentation/navigations/bazarche_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class UserProfileWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=> Get.toNamed(BazarcheAppRoutes.userProfilePage),
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: SvgPicture.asset('assets/icons/person.svg'),
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.4),
            borderRadius: BorderRadius.all(
                Radius.circular(15))
        ),
        margin: EdgeInsets.only(left: 32.0,bottom: 32.0),
        width: 60,
        height: 60,
      ),
    );
  }
}
