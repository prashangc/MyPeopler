import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/controllers.dart';
import 'package:my_peopler/src/core/constants/myAssets.dart';
import 'package:my_peopler/src/core/pallete.dart';
import 'package:my_peopler/src/widgets/profileTFF.dart';
import 'package:my_peopler/src/widgets/submitButton.dart';

class ChangePasswordView extends StatelessWidget {
  ChangePasswordView({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _oldPassword = TextEditingController();
  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pallete.primaryCol,
        elevation: 0,
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () {
                Get.find<NavController>().back();
              },
              icon: Icon(
                Icons.arrow_back_ios_new,
              ),
            );
          },
        ),
        title: Text("Change Password"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Image.asset(
                    MyAssets.changePassword,
                    width: 140,
                    height: 140,
                  ),
                ),
                ProfileTFF(
                  name: "Old Password",
                  controller: _oldPassword,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Enter Old Password";
                    }
                    return null;
                  },
                ),
                ProfileTFF(
                  name: "New Password",
                  controller: _newPassword,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Enter New Password";
                    }
                    if (val.length < 4) {
                      return "Too Short Password";
                    }
                    if (val == _oldPassword.text) {
                      return "New password cannot be same as old password";
                    }
                    return null;
                  },
                ),
                ProfileTFF(
                  name: "Confirm New Password",
                  controller: _confirmPassword,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Enter Confirm Password";
                    }
                    if (val != _newPassword.text) {
                      return "Confirm Password doesnot match";
                    }
                    return null;
                  },
                ),
                GetBuilder<ProfileController>(builder: (controller) {
                  return SubmitButton(
                    onPressed: () async {
                      await _changePassword();
                    },
                    label: "Change Password",
                    hPad: 0,
                    isLoading: controller.isChangingPassword.value,
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _changePassword() async {
    if (_formKey.currentState!.validate()) {
      Get.find<ProfileController>()
          .changePassword(_newPassword.text, _oldPassword.text);
    }
  }
}
