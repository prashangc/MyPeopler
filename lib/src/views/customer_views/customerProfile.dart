import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/authController.dart';
import 'package:my_peopler/src/helpers/helpers.dart';
import 'package:my_peopler/src/widgets/logoutButton.dart';

class CustomerProfile extends StatefulWidget {
  const CustomerProfile({super.key});

  @override
  State<CustomerProfile> createState() => _CustomerProfileState();
}

class _CustomerProfileState extends State<CustomerProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Column(
        children: [
          LogoutBtn(
            onTap: () async {
              MessageHelper.showInfoAlert(
                context: context,
                title: 'Logout',
                desc: 'Do you want to logout?',
                btnCancelOnPress: (){},
                btnOkOnPress: () async{
                  await Get.find<AuthController>().customerLogout();
                }
              );
            
          },
          ),
        ],
      ),
    );
  }
}
