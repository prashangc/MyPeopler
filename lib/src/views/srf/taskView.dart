import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:my_peopler/src/controllers/sfaCustomerListController.dart';
import 'package:my_peopler/src/helpers/helpers.dart';
import 'package:my_peopler/src/resources/color_manager.dart';
import 'package:my_peopler/src/resources/values_manager.dart';

class TaskView extends StatefulWidget {
  const TaskView({super.key});

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  late final int customerId;
  @override
  void initState() {
  customerId = Get.arguments;
  Get.find<SfaCustomerListController>().getTaskList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks'),
      ),
      body: GetBuilder<SfaCustomerListController>(builder: (controller) {
        if (controller.isLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (controller.sfaTask.isEmpty) {
          return Center(child: Text('No task assigned'));
        }
        return ListView.builder(
            shrinkWrap: true,
            itemCount: controller.sfaTask.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: AppSize.s28,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: ColorManager.lightGreen2,
                          border: Border.all(color: Colors.transparent),
                          borderRadius: BorderRadius.all(Radius.circular(6.0))),
                      child: Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                'From : ${controller.sfaTask[index]?.fromDate?.year.toString().padLeft(4, '0')}-${controller.sfaTask[index]?.fromDate?.month.toString().padLeft(2, '0')}-${controller.sfaTask[index]?.fromDate?.day.toString().padLeft(2, '0')}'),
                            Text(
                                'To : ${controller.sfaTask[index]?.toDate?.year.toString().padLeft(4, '0')}-${controller.sfaTask[index]?.toDate?.month.toString().padLeft(2, '0')}-${controller.sfaTask[index]?.toDate?.day.toString().padLeft(2, '0')}')
                          ],
                        ),
                      ),
                    ),
                    ...controller.sfaTask[index]!.items!.map((e) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 1.0),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            onTap: () {
                              MessageHelper.showInfoAlert(
                                  context: context,
                                  title: e.isCompleted == 0
                                      ? 'Task completed'
                                      : 'Task pending',
                                  desc: e.isCompleted == 0
                                      ? 'Is your task completed?'
                                      : 'Still on pending?',
                                  btnOkOnPress: () {
                                    successMethod();
                                    controller.toggleTaskItems(
                                        controller.sfaTask[index]!.id!, e.id!);
                                  },
                                  btnCancelOnPress: () {});
                            },
                            title: Text('${e.title}'),
                            tileColor: e.isCompleted == 1
                                ? ColorManager.primaryColorLight
                                : ColorManager.strawBerryColor,
                            subtitle: Text('${e.description}'),
                            isThreeLine: true,
                            trailing: Text(
                                e.isCompleted == 1 ? 'Compeleted' : 'Pending'),
                          ),
                        ))
                  ],
                ),
              );
            });
      }),
    );
  }

  void successMethod() {
    if (StorageHelper.taskhit != null) {
      if (StorageHelper.taskhit!.isNotEmpty) {
        StorageHelper.taskhit!.add(
            '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day} $customerId');

        // convert each item to a string by using JSON encoding
        final jsonList =
            StorageHelper.taskhit!.map((item) => jsonEncode(item)).toList();

        // using toSet - toList strategy
        final uniqueJsonList = jsonList.toSet().toList();

        // convert each item back to the original form using JSON decoding
        StorageHelper.settaskhit(
            uniqueJsonList.map((item) => jsonDecode(item) as String).toList());
        log(StorageHelper.taskhit.toString());
      } else {
        StorageHelper.settaskhit([
          '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day} $customerId'
        ]);
      }
    } else {
      StorageHelper.settaskhit([
        '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day} $customerId'
      ]);
    }
  }
}
