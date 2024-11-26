// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:my_peopler/src/controllers/authController.dart';
// import 'package:my_peopler/src/core/constants/userState.dart';
// import 'package:my_peopler/src/views/auth/loginView.dart';
// import 'package:my_peopler/src/views/navView.dart';

// class Wrapper extends StatelessWidget {
//   const Wrapper({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<AuthController>(builder: (authController) {
//       return AnimatedSwitcher(
//         duration: 200.milliseconds,
//         transitionBuilder: (child, animation) {
//           return SlideTransition(
//             position: Tween<Offset>(
//               begin: const Offset(1.0, 0.0),
//               end: Offset.zero,
//             ).animate(animation),
//             child: child,
//           );
//         },
//         child: (authController.status == UserState.AUTHENTICATED)
//             ? NavView()
//             : LoginView(),
//       );
//     });
//   }
// }
