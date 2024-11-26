import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/controllers.dart';
import 'package:my_peopler/src/core/di/injection.dart';
import 'package:my_peopler/src/helpers/helpers.dart';
import 'package:my_peopler/src/models/models.dart';
import 'package:my_peopler/src/repository/repository.dart';

class ProfileController extends GetxController {
  final ProfileRepository _profileRepo = getIt<ProfileRepository>();

  final Rx<Profile?> _user = Rx<Profile?>(null);
  User? get user => _user.value?.data;

  var isChangingPassword = false.obs;
  var isUpdatingProfile = false.obs;

  @override
  void onInit() {
    getProfile();
    super.onInit();
  }

  getProfile() async {
    var res = await _profileRepo.getProfile();
    if (!res.hasError) {
      _user.value = res.data as Profile;
      log(user.toString(), name: "Profile Controller");
      StorageHelper.saveProfile(user);
      if(user?.enable_live_tracking == 1){
        //TODO:[SPANDAN] START TRACKING HERE
        //TODO:[SPANDAN] IOS UPDATE LEFT OF TRACKING
        StorageHelper.enableBackgroundLocation(true);
        if(Platform.isIOS){
          startTracking();
        }
         
      }
      update();
    }
  }

  changePassword(String newPassword, String oldPassword) async {
    isChangingPassword(true);
    update();
    var res = await _profileRepo.changePassword(
        {'old_password': oldPassword, 'new_password': newPassword});
    if (!res.hasError) {
      MessageHelper.success(res.data);
      Get.find<AuthController>().logout();
    }else{
      MessageHelper.error(res.error??"Cannot Change Password");
    }
    isChangingPassword(false);
    update();
  }

  editProfile({
    required String name,
    required String email,
    required String contactNo,
    required String address,
    required String dob,
    String? avatar
  }) async {
    isUpdatingProfile(true);
    update();
    var data = {
      'name': name,
      'email': email,
      'present_address': address,
      'contact_no_one': contactNo,
      'date_of_birth': dob,
      'avatar': avatar
    };
    log(data.toString());
    var res = await _profileRepo.editProfile(data);
    if (!res.hasError) {
      getProfile();
      MessageHelper.success(res.data);
      Get.find<NavController>().back();
    }
    isUpdatingProfile(false);
    update();
  }

  startTracking() async {
    var res = await _profileRepo.sfaLocationLog();
    // if (!res.hasError) {
    //   update();
    // }
  }
}
