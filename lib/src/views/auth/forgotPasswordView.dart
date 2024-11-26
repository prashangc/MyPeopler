import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/authController.dart';
import 'package:my_peopler/src/core/core.dart';
import 'package:my_peopler/src/helpers/helpers.dart';
import 'package:my_peopler/src/widgets/widgets.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _email = TextEditingController();

  final TextEditingController _userCode = TextEditingController();

  @override
  void initState() {
    setInitialValue();
    super.initState();
  }

  setInitialValue() {
    _email.text = StorageHelper.userEmail;
    _userCode.text = StorageHelper.userCode;
    
  }

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
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back_ios_new,
              ),
            );
          },
        ),
        title: Text("Forgot Password"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
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
                  name: "Email",
                  controller: _email,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Enter Email";
                    }
                    return null;
                  },
                ),
                ProfileTFF(
                  name: "User Code",
                  controller: _userCode,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Enter User Code";
                    }
                    return null;
                  },
                ),
                GetBuilder<AuthController>(builder: (controller) {
                  return SubmitButton(
                    onPressed: () async {
                      await _forgotPassword();
                    },
                    label: "Submit",
                    isLoading: controller.isRessettingPassword.value,
                    hPad: 0,
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _forgotPassword() {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      Get.find<AuthController>().forgotPassword(_email.text, _userCode.text);
    }
  }
}
