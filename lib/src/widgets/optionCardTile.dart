import 'package:flutter/material.dart';
import 'package:my_peopler/src/core/core.dart';
import 'package:my_peopler/src/widgets/widgets.dart';

class OptionTileCard extends StatelessWidget {
  const OptionTileCard({Key? key, required this.title, required this.icon, required this.onTap,  this.hideArrow = false}) : super(key: key);
   final String title;
    final IconData icon;
    final Function()? onTap;
    final bool hideArrow;
  @override
  Widget build(BuildContext context) {
    return SplashWidget(
      splashColor: Pallete.primaryCol,
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
      contentPadding: EdgeInsets.all(10),
      bgCol: Colors.grey.shade300,
      shadowColor: Pallete.shadowCol,
      radius: 8,
      onTap: onTap,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Icon(
              icon,
              color: Pallete.primaryCol,
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 14),
            ),
          ),
          Visibility(
            visible: !hideArrow,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Icon(
                Icons.keyboard_arrow_right,
              ),
            ),
          ),
        ],
      ),
    );
  }
}