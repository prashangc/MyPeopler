import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/navController.dart';

class MyPeoplerScaffoldWidget extends StatelessWidget {
  final Widget? body;
  final String? appTitle;
  const MyPeoplerScaffoldWidget({super.key,this.body, this.appTitle});

  @override
   Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(appTitle ?? ""),
          leading: IconButton(
            onPressed: () {
              Get.find<NavController>().back();
            },
            icon: Icon(Icons.arrow_back_ios_new),
          ),
          automaticallyImplyLeading: false,
        ),
        body: body),
    );
   }
}