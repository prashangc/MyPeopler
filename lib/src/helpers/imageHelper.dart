import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageHelper {
  static Future<bool?> chooseSource(BuildContext context)async{
    bool? isCamera = await Get.bottomSheet(
      BottomSheet(
        onClosing: () {
          // Get.back(result: true);
        },
        constraints: BoxConstraints.tight(const Size(double.infinity, 120)),
        builder: (context) {
          return ListView(
            children: [
              ListTile(
                leading: const Icon(Icons.image_outlined),
                title: const Text("Gallery"),
                // contentPadding: EdgeInsets.only(left: 50),
                onTap: () {
                  Get.back(result: false);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Camera"),
                // contentPadding: EdgeInsets.only(left: 50),
                onTap: () {
                  Get.back(result: true);
                },
              ),
            ],
          );
        },
      ),
    );
    if(isCamera == null){
      return null;
    }
    return isCamera;
  }

   
}