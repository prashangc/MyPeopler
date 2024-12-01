import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/authController.dart';
import 'package:my_peopler/src/controllers/navController.dart';
import 'package:my_peopler/src/controllers/profileController.dart';
import 'package:my_peopler/src/core/constants/myAssets.dart';
import 'package:my_peopler/src/helpers/messageHelper.dart';
import 'package:my_peopler/src/routes/appPages.dart';
import 'package:my_peopler/src/views/profile/widgets/profileImgBox.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: [
            _buildProfile(),
            SizedBox(
              height: 50,
            ),
            ListTile(
              leading: _buildIcon(MyAssets.notice),
              title: Text("Notices"),
              onTap: () {
                // Get.find<NavController>().offNamed(Routes.NOTICE);
                Get.find<NavController>().toNamed(
                  Routes.NOTICE,
                );
              },
            ),
            _buildDivider(),
            // ListTile(
            //   leading: _buildIcon(MyAssets.bonus),
            //   title: Text("Bonus"),
            //   onTap: () {
            //     Navigator.pop(context);
            //     Get.find<NavController>().offNamed(Routes.BONUS);
            //   },
            // ),
            // _buildDivider(),
            ListTile(
              leading: _buildIcon(MyAssets.todo),
              title: Text("To Do"),
              onTap: () {
                Get.find<NavController>().offNamed(Routes.TODO);
              },
            ),
            _buildDivider(),
            ListTile(
              leading: _buildIcon(MyAssets.award),
              title: Text("Awards"),
              onTap: () {
                Get.find<NavController>().offNamed(Routes.AWARD);
              },
            ),
            _buildDivider(),
            ListTile(
              leading: _buildIcon(MyAssets.document),
              title: Text("Documents"),
              onTap: () {
                Get.find<NavController>().offNamed(Routes.DOCUMENT_FOLDERS);
              },
            ),
            _buildDivider(),
            ListTile(
              leading: _buildIcon(MyAssets.surveyPoll),
              title: Text("Survey & Poll"),
              onTap: () {
                Get.find<NavController>().offNamed(Routes.SURVEY_POLL);
              },
            ),
            _buildDivider(),
            ListTile(
              leading: _buildIcon(MyAssets.holiday),
              title: Text("Holidays"),
              onTap: () {
                // Navigator.pop(context);
                Get.find<NavController>().offNamed(Routes.HOLIDAY);
              },
            ),
            _buildDivider(),
            ListTile(
              leading: _buildIcon(MyAssets.logout),
              title: Text("Log Out"),
              onTap: () {
                MessageHelper.showInfoAlert(
                  context: context,
                  title: 'Logging Out',
                  desc: 'Do you want to log out?',
                  okBtnText: 'Yes',
                  cancelBtnText: 'No',
                  btnCancelOnPress: () {
                    //Navigator.pop(context);
                  },
                  btnOkOnPress: () async {
                    Get.find<AuthController>().logout();
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  _buildIcon(String imgPath) {
    return SizedBox(
      width: 30,
      height: 30,
      child: Image.asset(imgPath),
    );
  }

  _buildDivider() {
    return Divider(
      color: Colors.grey,
      thickness: 1.5,
    );
  }

  _buildProfile() {
    return Column(
      children: [
        SizedBox(
          height: 50,
        ),
        GetBuilder<ProfileController>(builder: (controller) {
          return ProfileImgBox(
            user: controller.user,
            isDrawer: true,
          );
        }),
        // CircleAvatar(
        //   radius: 35,
        //   backgroundImage: NetworkImage(
        //     "https://play-lh.googleusercontent.com/-u-oG-Ni_pco9h7zc3CQl-lFkKJjztO3RGZMjnbaDiznnbXoMQZYUjITHN0BVxYHBg=w240-h480-rw",
        //   ),
        // ),
        // SizedBox(
        //   height: 15,
        // ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(vertical: 5),
        //   child: Text(
        //     "My Name",
        //   ),
        // ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(vertical: 5),
        //   child: Text(
        //     "myemail@gmail.com",
        //   ),
        // ),
      ],
    );
  }
}
