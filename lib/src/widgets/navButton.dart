import 'package:flutter/material.dart';

class NavButton extends StatelessWidget {
  const NavButton(
      {Key? key,
      required this.onPressed,
      required this.icon,
      required this.label, required this.selected})
      : super(key: key);
  final void Function() onPressed;
  final IconData icon;
  final String label;
  final bool selected;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: 20,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onPressed: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: selected ? 22: 20,
            color: !selected?Colors.white.withOpacity(0.85):Colors.white,
          ),
          Text(
            label,
            style: TextStyle(color: !selected?Colors.white.withOpacity(0.85):Colors.white,fontSize: 9.0),
          )
        ],
      ),
    );
  }
}
