import 'dart:developer';

import 'package:get/get.dart';
import 'package:my_peopler/main.dart';
import 'package:my_peopler/src/controllers/authController.dart';
import 'package:my_peopler/src/core/constants/userState.dart';
import 'package:my_peopler/src/helpers/helpers.dart';
import 'package:my_peopler/src/routes/appPages.dart';
import 'package:my_peopler/src/views/auth/loginView.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  GetPage? onPageCalled(GetPage? page) {
    AuthController controller = Get.find();
    if (controller.status != UserState.AUTHENTICATED) {
      return GetPage(name: Routes.LOGIN, page: () => LoginView());
    }

    var userId = StorageHelper.userId;
    if (userId != null && StorageHelper.isCheckedIn) {
      startLocator(userId); // start background service
    } else {
      stopBackgroundLocator();
    }

    return super.onPageCalled(page);
  }

  @override
  List<Bindings>? onBindingsStart(List<Bindings>? bindings) {
    if (Get.find<AuthController>().status == UserState.AUTHENTICATED) {
      log("Authenticated");
      return super.onBindingsStart(bindings);
    } else {
      return [];
    }
  }
}
