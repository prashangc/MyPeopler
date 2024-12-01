import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/authController.dart';
import 'package:my_peopler/src/controllers/navController.dart';
import 'package:my_peopler/src/core/pallete.dart';
import 'package:my_peopler/src/helpers/messageHelper.dart';
import 'package:my_peopler/src/routes/appPages.dart';
import 'package:my_peopler/src/views/profile/widgets/profileContainer.dart';
import 'package:my_peopler/src/widgets/logoutButton.dart';
import 'package:my_peopler/src/widgets/myDrawer.dart';
import 'package:my_peopler/src/widgets/optionCardTile.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        backgroundColor: Pallete.primaryCol,
        elevation: 0,
        leading: Builder(builder: (context) {
          return IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: Icon(
              Icons.menu,
            ),
          );
        }),
        title: Text("Profile"),
        centerTitle: true,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height - 150,
        child: SingleChildScrollView(
          child: Column(
            children: [
              ProfileContainer(),
              OptionTileCard(
                title: "Edit Profile",
                icon: Icons.edit,
                onTap: () {
                  Get.find<NavController>().toNamed(Routes.EDIT_PROFILE);
                },
              ),
              OptionTileCard(
                title: "Change Password",
                icon: Icons.password,
                onTap: () {
                  Get.find<NavController>().toNamed(Routes.CHANGE_PASSWORD);
                },
              ),
              OptionTileCard(
                title: "Company Profile",
                icon: Icons.business_outlined,
                onTap: () async {
                  // final Uri uri = Uri.parse("https://mypeopler.com/");
                  // if (await canLaunchUrl(uri)) {
                  //   launchUrl(uri, mode: LaunchMode.externalApplication);
                  // } else {
                  //   log("Cannot Launch Url", name: "Company Profile Tab: ");
                  // }
                  Get.find<NavController>().toNamed(Routes.COMPANY_PROFILE);
                },
              ),
              OptionTileCard(
                title: "Current Location Co-ordinates",
                icon: Icons.location_on_outlined,
                onTap: () async {
                  Get.find<NavController>()
                      .toNamed(Routes.LOCATION_COORDINATES_VIEW);
                },
              ),
              LogoutBtn(
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
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
