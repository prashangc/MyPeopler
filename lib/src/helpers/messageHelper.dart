import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_peopler/src/core/core.dart';

class MessageHelper {
  static void error(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Pallete.errorCol,
        textColor: Pallete.white,
        fontSize: 16.0);
  }

  static void warning(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Pallete.warningCol,
        textColor: Pallete.white,
        fontSize: 16.0);
  }

  static void success(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Pallete.successCol,
        textColor: Pallete.white,
        fontSize: 16.0);
  }

  static void showInfoAlert({
    required BuildContext context,
    required String title,
    String? desc,
    String? okBtnText = 'Yes',
    String? cancelBtnText = 'No',
    void Function()? btnOkOnPress,
    void Function()? btnCancelOnPress,
  }) {
    AwesomeDialog(
      context: context,
      width: MediaQuery.of(context).size.width,
      dialogType: DialogType.info,
      animType: AnimType.bottomSlide,
      title: title,
      desc: desc,
      // btnOkColor: Colors.red,
      btnOkText: okBtnText,
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      btnCancelText: cancelBtnText,
      // btnCancelColor: Colors.grey,
      buttonsTextStyle: TextStyle(
          fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      btnCancelOnPress: btnCancelOnPress,
      btnOkOnPress: btnOkOnPress,
    ).show();
  }

  static void showWarningAlert({
    required BuildContext context,
    required String title,
    String? desc,
    String? okBtnText = 'Ok',
    String? cancelBtnText = 'Back',
    void Function()? btnOkOnPress,
  }) {
    AwesomeDialog(
      context: context,
      width: MediaQuery.of(context).size.width,
      dialogType: DialogType.warning,
      animType: AnimType.bottomSlide,
      title: title,
      desc: desc,
      // btnOkColor: Colors.red,
      btnOkText: okBtnText,
      btnCancelText: cancelBtnText,
      // btnCancelColor: Colors.grey,
      buttonsTextStyle: TextStyle(
          fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      btnCancelOnPress: () {},
      btnOkOnPress: btnOkOnPress,
    ).show();
  }

  static void showSuccessAlert({
    required BuildContext context,
    required String title,
    String? desc,
    String? okBtnText = 'Ok',
    String? cancelBtnText = 'Back',
    void Function()? btnOkOnPress,
  }) {
    AwesomeDialog(
      context: context,
      width: MediaQuery.of(context).size.width,
      dialogType: DialogType.success,
      animType: AnimType.bottomSlide,
      title: title,
      desc: desc,
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      // btnOkColor: Colors.red,
      btnOkText: okBtnText,
      btnCancelText: cancelBtnText,
      // btnCancelColor: Colors.grey,
      buttonsTextStyle: TextStyle(
          fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      //btnCancelOnPress: () {},
      btnOkOnPress: btnOkOnPress,
    ).show();
  }

  static errorDialog(
      {required BuildContext context,
      required String errorMessage,
      dynamic Function()? btnOkOnPress,
      dynamic Function()? btnCancelOnPress,
      bool dismissOnTouchOutside = true,
      Widget? btnOk,
      Widget? btnCancel,
      String? btnOkText,
      String? btnCancelText}) {
    AwesomeDialog(
      width: MediaQuery.of(context).orientation != Orientation.portrait
          ? MediaQuery.of(context).size.width / 2
          : MediaQuery.of(context).size.width,
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.scale,
      title: 'Error',
      desc: errorMessage,
      btnOk: btnOk,
      btnCancel: btnCancel,
     // btnOkColor: primaryColor,
      btnOkOnPress: btnOkOnPress,
      btnCancelOnPress: btnCancelOnPress,
      btnOkText: btnOkText,
      btnCancelText: btnCancelText,
      dismissOnTouchOutside: dismissOnTouchOutside,
    ).show();
  }

  static String? getResponseMsg(Map<String, dynamic> res) {
    if (res['error'] != null) {
      return res['error'];
    } else if (res['message'] != null) {
      return res['message'];
    } else if (res['email'] != null) {
      return res['email'];
    } else if (res['old_password'] != null) {
      return res['old_password'];
    }else if(res['status'] != null){
      return res['status'];
    }
    return null;
  }
}
