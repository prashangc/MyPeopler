import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/authController.dart';
import 'package:my_peopler/src/helpers/helpers.dart';
import 'package:my_peopler/src/resources/color_manager.dart';
import 'package:my_peopler/src/routes/routes.dart';
import 'package:my_peopler/src/widgets/customTFF.dart';
import 'package:my_peopler/src/widgets/submitButton.dart';
import 'package:my_peopler/utils.dart';

import '../../controllers/navController.dart';
import '../../models/models.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _username = TextEditingController();

  final TextEditingController _password = TextEditingController();

  final TextEditingController _userCode = TextEditingController();

  bool rememberMe = false;
  String? fcmToken;
  String? macAddress;
  bool employeePressed = true;
  bool customerPressed = false;
  @override
  void initState() {
    super.initState();

    setInitialValue();
    getMacAddress();
  }

  getMacAddress() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      log(androidInfo.fingerprint);
      macAddress = androidInfo.fingerprint;
    } else {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      //macAddress = "${iosInfo.localizedModel} ${iosInfo.model} ${iosInfo.name} ${iosInfo.systemName} ${iosInfo.systemVersion}";
      log(iosInfo.identifierForVendor.toString());
      macAddress = iosInfo.identifierForVendor;
    }
  }

  setInitialValue() async {
    if (Platform.isAndroid) {
      await Utils().initializeLocation();
    }
    if (!mounted) return;
    setState(() {
      rememberMe = StorageHelper.rememberMe ?? false;
      _username.text = StorageHelper.userEmail;
      _userCode.text = StorageHelper.userCode;
      _password.text = StorageHelper.userPassword;
    });
  }

  _customerLogin() async {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();

      var response = await Get.find<AuthController>().customerLogin(
          _username.text,
          _password.text,
          _userCode.text,
          macAddress ?? 'no mac address',
          rememberMe);
      if (response != '') {
        return MessageHelper.showWarningAlert(
            context: context, title: 'Warning', desc: response);
      } else {
        StorageHelper.setUserType(isEmployee: false);
        initPlatformState();
      }
    }
  }

  _employeeLogin() async {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();

      var response = await Get.find<AuthController>().login(
          _username.text,
          _password.text,
          _userCode.text,
          macAddress ?? 'no mac address',
          rememberMe);
      if (response != '') {
        return MessageHelper.showWarningAlert(
            context: context, title: 'Warning', desc: response);
      } else {
        StorageHelper.setUserType(isEmployee: true);
        initPlatformState();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Logo
                SizedBox(
                  height: context.height * 0.35,
                  child: Center(
                    child: Image.asset("assets/images/logo.png"),
                  ),
                ),
                // Username TFF
                CustomTFF(
                  labelText: "Email",
                  controller: _username,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Enter Email";
                    }
                    return null;
                  },
                  vPad: 8,
                ),
                // Password TFF
                CustomTFF(
                  labelText: "Password",
                  controller: _password,
                  obscureText: true,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Enter Password";
                    }
                    return null;
                  },
                  vPad: 8,
                ),
                // User Code TFF
                CustomTFF(
                  labelText: "User Code",
                  controller: _userCode,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Enter your code";
                    }
                    return null;
                  },
                  isLast: true,
                  vPad: 8,
                ),
                SizedBox(
                  height: 4,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width / 3,
                        padding:
                            EdgeInsets.only(top: 0, left: 18.0, right: 5.0),
                        decoration: BoxDecoration(
                            color: employeePressed == true
                                ? ColorManager.lightPurple
                                : ColorManager.textFeildColor,
                            border: Border.all(
                                color: employeePressed == true
                                    ? ColorManager.primaryCol
                                    : ColorManager.textFeildColor),
                            borderRadius: BorderRadius.circular(4.0)),
                        child: InkWell(
                          child: Row(
                            children: [
                              employeePressed
                                  ? Icon(Icons.business_center)
                                  : Icon(Icons.business_center_outlined),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Employee',
                                style: TextStyle(
                                    fontWeight: employeePressed == true
                                        ? FontWeight.bold
                                        : FontWeight.normal),
                              ),
                            ],
                          ),
                          onTap: () {
                            setState(() {
                              employeePressed = true;
                              if (employeePressed == true) {
                                customerPressed = false;
                              }
                            });
                          },
                        ),
                      ),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width / 3,
                        padding:
                            EdgeInsets.only(top: 0, left: 18.0, right: 5.0),
                        decoration: BoxDecoration(
                            color: customerPressed == true
                                ? ColorManager.lightPurple
                                : ColorManager.textFeildColor,
                            border: Border.all(
                                color: customerPressed == true
                                    ? ColorManager.primaryCol
                                    : ColorManager.textFeildColor),
                            borderRadius: BorderRadius.circular(4.0)),
                        child: InkWell(
                          child: Row(
                            children: [
                              employeePressed
                                  ? Icon(Icons.account_circle_outlined)
                                  : Icon(Icons.account_circle_rounded),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Customer',
                                style: TextStyle(
                                    fontWeight: customerPressed == true
                                        ? FontWeight.bold
                                        : FontWeight.normal),
                              ),
                            ],
                          ),
                          onTap: () {
                            setState(() {
                              customerPressed = true;
                              if (customerPressed == true) {
                                employeePressed = false;
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                // Submit Btn
                GetBuilder<AuthController>(
                  builder: (controller) {
                    return SubmitButton(
                      onPressed: () {
                        if (employeePressed == true) {
                          _employeeLogin();
                        } else {
                          _customerLogin();
                        }
                      },
                      label: "Log In",
                      isLoading: controller.isLoading.value,
                    );
                  },
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: rememberMe,
                      onChanged: (val) {
                        setState(() {
                          rememberMe = !rememberMe;
                        });
                      },
                    ),
                    Text("Remember Me")
                  ],
                ),
                // Forgot Password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Get.toNamed(Routes.FORGOT_PASSWORD);
                        },
                        child: Text("Forgot Password?"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> initPlatformState() async {
    fcmToken = await FirebaseMessaging.instance.getToken();
    log(fcmToken.toString());
    Map<String, dynamic> data = {
      "fcm_token": fcmToken,
    };
    await Get.find<AuthController>().saveFcmToken(data);

    // var response = await locator<ApiService>().post(
    //   saveFcmToken,
    //   withTokenAsParam: true,
    //   body: data,
    // );

    await FirebaseMessaging.instance.setAutoInitEnabled(true);
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, sound: true, badge: true);
    callFireBase();
  }
}

void selectNotification(String? payload, RemoteMessage message) async {
  if (payload != null) {
    debugPrint('notification payload: $payload');
  }
  String? title = message.notification!.title;

  final data = message.data;
  log("Title: $title");
  log("Data: ${data.toString()}", name: "onMessageOpenedApp");
  Get.find<NavController>().toNamed(Routes.SINGLE_NOTICE,
      arguments: Notice(
        id: 0,
        published_by: '',
        title: message.data['title'],
        description: message.data['body'],
        created_at: message.sentTime,
        start_date:
            DateTime.parse(jsonDecode(message.data['meta'])['start_date']),
        end_date: DateTime.parse(jsonDecode(message.data['meta'])['end_date']),
      ));
}

void onDidReceiveLocalNotification(
    int id, String? title, String? body, String? payload) async {
  log('ios notification triggered');
  // showDialog(
  //   context: context,
  //   builder: (BuildContext context) => CupertinoAlertDialog(
  //     title: Text(title!),
  //     content: Text(body!),
  //     actions: [
  //       CupertinoDialogAction(
  //         isDefaultAction: true,
  //         child: Text('Ok'),
  //         onPressed: () async {
  //           Navigator.of(context, rootNavigator: true).pop();
  //           await Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //               builder: (context) => StudentDashboardScreen(),
  //             ),
  //           );
  //         },
  //       )
  //     ],
  //   ),
  // );
}

callFireBase() {
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    log('on tapped hanled');
    log(jsonDecode(event.data['meta'])['start_date']);

    Get.find<NavController>().toNamed(Routes.SINGLE_NOTICE,
        arguments: Notice(
          id: 0,
          published_by: '',
          title: event.data['title'],
          description: event.data['body'],
          created_at: event.sentTime,
          start_date:
              DateTime.parse(jsonDecode(event.data['meta'])['start_date']),
          end_date: DateTime.parse(jsonDecode(event.data['meta'])['end_date']),
        ));
  });

  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      message.messageId ?? '', // id
      message.data['title'], // title
      description: message.data['body'], // description
      importance: Importance.max,
    );

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    // If `onMessage` is triggered with a notification, construct our own
    // local notification to show to users using the created channel.
    AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/launcher_icon');
    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (val) {
      selectNotification(val.payload, message);
    });

    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              icon: 'launcher_icon',
              importance: Importance.max,
              priority: Priority.max,
            ),
          ));
    }

    // void onDidReceiveLocalNotification(
    //   int id, String title, String body, String payload) async {
    // // display a dialog with the notification details, tap ok to go to another page
    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) => CupertinoAlertDialog(
    //     title: Text(title),
    //     content: Text(body),
    //     actions: [
    //       CupertinoDialogAction(
    //         isDefaultAction: true,
    //         child: Text('Ok'),
    //         onPressed: () async {
    //           Navigator.of(context, rootNavigator: true).pop();
    //           await Navigator.push(
    //             context,
    //             MaterialPageRoute(
    //               builder: (context) => SecondScreen(payload),
    //             ),
    //           );
    //         },
    //       )
    //     ],
    //   ),
    // );

    if (message.data['action'] == 'GENERAL_NOTIFICATION') {
      //orderViewModel.start();
      Fluttertoast.showToast(
          msg: 'New notification received', backgroundColor: Colors.green);
      return Future<void>.delayed(const Duration(seconds: 1));
    }
  });
}
