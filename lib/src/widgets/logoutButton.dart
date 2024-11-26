import 'package:flutter/material.dart';
import 'package:my_peopler/src/core/pallete.dart';
import 'package:my_peopler/src/widgets/splashWidget.dart';

class LogoutBtn extends StatelessWidget {
  const LogoutBtn({Key? key,required this.onTap}) : super(key: key);
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return SplashWidget(
      onTap: onTap,
      splashColor: Colors.grey.shade200,
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      contentPadding: EdgeInsets.all(5),
      shadowColor: Colors.black,
      radius: 9,
      bgCol: Pallete.primaryCol,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Icon(
              Icons.power_settings_new,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
            child: Text(
              "Logout",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}