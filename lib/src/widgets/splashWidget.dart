import 'package:flutter/material.dart';

class SplashWidget extends StatelessWidget {
  const SplashWidget({
    Key? key,
    required this.child,
    required this.onTap,
    required this.splashColor,
    required this.margin,
    required this.contentPadding,
    required this.shadowColor,
    required this.radius,
    required this.bgCol, this.border, this.elevation = 0,
  }) : super(key: key);
  final Widget child;
  final void Function()? onTap;
  final Color splashColor;
  final Color shadowColor;
  final EdgeInsetsGeometry margin;

  final EdgeInsetsGeometry contentPadding;
  final double radius;
  final Color bgCol;
  final BoxBorder? border;
  final double? elevation;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: margin,
      elevation: elevation,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
      ),
      child: Container(
        // margin: margin,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: bgCol,
          border: border
        ),
        child: Material(
          color: Colors.transparent,
          shadowColor: shadowColor,
          borderRadius: BorderRadius.circular(radius),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(radius),
            splashColor: splashColor,
            child: Padding(
              padding: contentPadding,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
