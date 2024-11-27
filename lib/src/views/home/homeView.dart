import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:my_peopler/handle_local_notification.dart';
import 'package:my_peopler/location_service_repo.dart';
import 'package:my_peopler/my_shared_pref.dart';
import 'package:my_peopler/src/controllers/controllers.dart';
import 'package:my_peopler/src/controllers/sfaCustomerListController.dart';
import 'package:my_peopler/src/controllers/sfalocationLogsController.dart';
import 'package:my_peopler/src/core/core.dart';
import 'package:my_peopler/src/helpers/helpers.dart';
import 'package:my_peopler/src/resources/color_manager.dart';
import 'package:my_peopler/src/resources/values_manager.dart';
import 'package:my_peopler/src/routes/routes.dart';
import 'package:my_peopler/src/views/home/attendance_status.dart';
import 'package:my_peopler/src/widgets/myDrawer.dart';
import 'package:my_peopler/src/widgets/noticeCard.dart';
import 'package:my_peopler/utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:workmanager/workmanager.dart';

class Options {
  String name;
  String imagePath;
  Color lightColor;
  Color darkColor;
  Options(this.name, this.imagePath, this.lightColor, this.darkColor);
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Options> optionList = [
    Options('SFA', MyAssets.sfa, ColorManager.orangeColor,
        ColorManager.orangeColor2),
    // Options('CRM',MyAssets.crm,ColorManager.strawBerryColor,ColorManager.strawBerryColor2),
    // Options('Inventory',MyAssets.inventory,ColorManager.purpleColor,ColorManager.purpleColor2),
    //Options('Expenses',MyAssets.inventory,ColorManager.lightGreen2,ColorManager.lightGreen),
    // Options('CPA',MyAssets.cpa,ColorManager.lightPurple,ColorManager.lightPurple2),
    // Options('Task Board',MyAssets.taskBoard,ColorManager.creamColor,ColorManager.creamColor2),
    // Options('Contract',MyAssets.cpa,ColorManager.primaryColorLight,ColorManager.darkPrimary),
  ];
  final RefreshController _refreshController = RefreshController();
  bool showAllFloationActionButtons = false;
  String? test1, test2, test3;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await checkLocationStatus();
      if (StorageHelper.enableBackgroundlocation == null) {
        StorageHelper.enableBackgroundLocation(false);
      }
      if (Platform.isAndroid) {
        test1 = PreferenceHelper.getStringFromDevice(tokenKey: "test1");
        test2 = PreferenceHelper.getStringFromDevice(tokenKey: "test2");
        test3 = PreferenceHelper.getStringFromDevice(tokenKey: "test3");
        await enableBackgroundTracking();
      }
      await Get.find<SfaLocationLogsController>().getSharedPreference();
    });

    super.initState();
  }

  checkLocationStatus() async {
    if (Platform.isAndroid) {
      await Utils().initializeLocation();
    }
  }

  int totalCustomer = 0;

  enableBackgroundTracking() async {
    if (StorageHelper.liveTracking == "1") {
      StorageHelper.enableBackgroundLocation(true);
      if (Platform.isIOS) {
        // Workmanager().registerOneOffTask(
        //   "task-identifier",
        //   'simpleTask', // Ignored on iOS
        //   initialDelay: Duration(minutes: 15),
        //   constraints: Constraints(
        //       // connected or metered mark the task as requiring internet
        //       networkType: NetworkType.not_required,
        //       // require external power
        //       requiresCharging: false,
        //       requiresBatteryNotLow: false,
        //       requiresDeviceIdle: false,
        //       requiresStorageNotLow: false),
        //   inputData: {
        //     'token': StorageHelper.token,
        //     'code': StorageHelper.userCode
        //   },
        // );
        Fluttertoast.showToast(msg: 'Location Tracking enabled.');
      } else {
        Position locData = await Geolocator.getCurrentPosition();

        Map<String, dynamic> inputData = {
          'token': StorageHelper.token,
          'code': StorageHelper.userCode,
          'longitude': locData.longitude,
          'latitude': locData.latitude,
          'timestamp': locData.timestamp.millisecondsSinceEpoch ?? 0,
          'accuracy': locData.accuracy,
          'altitude': locData.altitude,
          'altitudeAccuracy': locData.altitudeAccuracy,
          'heading': locData.heading,
          'headingAccuracy': locData.headingAccuracy,
          'speed': locData.speed,
          'speedAccuracy': locData.speedAccuracy,
        };
        Workmanager().registerPeriodicTask("100", 'simpleTask',
            inputData: inputData,
            frequency: Duration(minutes: 15),
            constraints: Constraints(
              networkType: NetworkType.connected,
            ));
        // Workmanager().registerPeriodicTask(
        //   '1',
        //   'simpleTask',
        //   inputData: inputData,
        //   frequency: Duration(seconds: 1),
        //   constraints: Constraints(
        //       // connected or metered mark the task as requiring internet
        //       networkType: NetworkType.not_required,
        //       // require external power
        //       requiresCharging: false,
        //       requiresBatteryNotLow: false,
        //       requiresDeviceIdle: false,
        //       requiresStorageNotLow: false),
        // );
        Fluttertoast.showToast(msg: 'Location Tracking enabled.');
      }
    } else if (StorageHelper.liveTracking == "") {
      Fluttertoast.showToast(
          msg: 'Logout and re-login to enable location tracking');
    } else {
      Fluttertoast.showToast(
          msg:
              'Location Tracking not enabled by admin. Please contact your admin if you want to enable location tracking.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SfaLocationLogsController>(
        builder: (locationLogController) {
      if (locationLogController.freezeApp == true) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Get.offAllNamed(Routes.SYNC_LOCATION_LOGS_VIEW);
        });
      }
      return PopScope(
        canPop: false,
        onPopInvoked: (a) {
          false;
        },
        child: Scaffold(
          drawer: MyDrawer(),
          appBar: AppBar(
            leading: Builder(builder: (context) {
              return IconButton(
                onPressed: () {
                  PreferenceHelper.storeStringToDevice(
                    tokenKey: "test3",
                    tokenValue: "added on click",
                  ); // Get.find<NavController>().openDrawer();
                  // Scaffold.of(context).openDrawer();
                  HandleLocalNotification.showNotification(
                    title: "Test title",
                    body: "Test body",
                  );
                  LocationServiceRepository.backgroundLocationFetch();
                },
                icon: Icon(
                  Icons.menu,
                ),
              );
            }),
            title: Text("$test3 MyPeopler $test1 $test2"),
            actions: [
              IconButton(
                  onPressed: () {
                    // Get.find<NavController>().offNamed(Routes.NOTICE);
                    Get.find<NavController>().toNamed(
                      Routes.NOTICE,
                    );
                  },
                  icon: Icon(Icons.notifications))
            ],
          ),
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              showAllFloationActionButtons
                  ? Column(
                      children: [
                        FloatingActionButton(
                          mini: !showAllFloationActionButtons,
                          heroTag: 'EXPENSES VIEW',
                          tooltip: 'Expenses',
                          backgroundColor: ColorManager.lightGreen2,
                          child: Image.asset(MyAssets.inventory),
                          onPressed: () {
                            Get.toNamed(Routes.EXPENSES_DATE_VIEW);
                          },
                        ),
                      ],
                    )
                  : SizedBox.shrink(),
              SizedBox(
                height: 10,
              ),
              FloatingActionButton(
                  mini: showAllFloationActionButtons,
                  heroTag: 'Menu',
                  tooltip: 'Menu',
                  backgroundColor: ColorManager.primaryColorLight,
                  child: showAllFloationActionButtons
                      ? Icon(
                          Icons.close,
                        )
                      : Icon(Icons.dashboard),
                  onPressed: () {
                    setState(() {
                      showAllFloationActionButtons =
                          !showAllFloationActionButtons;
                    });
                  }),
              SizedBox(
                height: 80,
              )
            ],
          ),
          body: SmartRefresher(
            controller: _refreshController,
            onRefresh: () async {
              await Get.find<ProfileController>().getProfile();
              Get.find<SfaCustomerListController>().onInit();
              _refreshController.refreshCompleted();
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  AttendenceStatus(),
                  _buildOptions(context),
                  // _buildNotices(context),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  _buildOptions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: SizedBox(
        height: 150, //350,
        child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: optionList.length,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 150,
            childAspectRatio: 3 / 2.5,
            crossAxisSpacing: 5,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                if (index == 0) {
                  // Get.find<NavController>().offNamed(Routes.SFA_MENU);
                  Get.toNamed(Routes.SFA_MENU);
                }
              },
              child: Stack(
                fit: StackFit.loose,
                children: [
                  Container(
                    height: AppSize.s100,
                    width: AppSize.s100,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          optionList[index].lightColor,
                          optionList[index].darkColor
                        ]),
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(color: Colors.transparent)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          optionList[index].imagePath,
                          height: 50,
                          width: 50,
                        ),
                        Text(
                          optionList[index].name,
                          style: Theme.of(context).textTheme.titleLarge,
                        )
                      ],
                    ),
                  ),
                  // if (index == 0)
                  Positioned(
                      right: 6,
                      top: 0,
                      child: Container(
                        height: 20,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: ColorManager.primaryCol,
                        ),
                        child: GetBuilder<SfaCustomerListController>(
                            builder: (controller) {
                          totalCustomer = 0;
                          for (var e in controller
                              .sfaCustomerList.clientLists.entries) {
                            totalCustomer = totalCustomer + e.value.length;
                          }
                          return Text(
                            totalCustomer.toString(),
                            style: TextStyle(color: Colors.white, fontSize: 16),
                            textAlign: TextAlign.center,
                          );
                        }),
                      ))
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  _buildNotices(BuildContext context) {
    return GetX<NoticeController>(builder: (noticeController) {
      if (noticeController.notices.isEmpty) {
        return SizedBox.shrink();
      } else {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Notices",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 24,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.find<NavController>().toNamed(
                        Routes.NOTICE,
                      );
                    },
                    child: Text(
                      "View all",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Pallete.primaryCol),
                    ),
                  ),
                ],
              ),
              GetX<NoticeController>(builder: (noticeController) {
                return ListView.builder(
                  itemCount: noticeController.notices.length < 6
                      ? noticeController.notices.length
                      : 6,
                  primary: false,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return NoticeCard(notice: noticeController.notices[index]);
                  },
                );
              })
            ],
          ),
        );
      }
    });
  }
}

void _ontapped() {
  log("search button clicked");
}
