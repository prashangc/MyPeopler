import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/controllers.dart';

import 'profileImgBox.dart';
import 'profileInfo.dart';

class ProfileContainer extends StatelessWidget {
  const ProfileContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (controller) {
      return Column(
        children: [
          Center(
            child: ProfileImgBox(user: controller.user,),
          ),
          SizedBox(
            height: 10,
          ),
          ProfileInfo(user: controller.user,),
        ],
      );
    });
  }
}
