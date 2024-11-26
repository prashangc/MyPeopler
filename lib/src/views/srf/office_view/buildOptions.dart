import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/sfaCustomerListController.dart';
import 'package:my_peopler/src/resources/values_manager.dart';

buildOption(BuildContext context,
      {required String title, required Color color, Function()? onTap}) {
    return GetBuilder<SfaCustomerListController>(builder: (controller) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 1),
        child: InkWell(
          onTap: onTap,
          child: Container(
            height: AppSize.s65,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(12.0)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title.toUpperCase(),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(
            Icons.arrow_forward,
          ),),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }