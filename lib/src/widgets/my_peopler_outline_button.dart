import 'package:flutter/material.dart';

class MyPeoplerOutlineButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  const MyPeoplerOutlineButton({super.key, this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      
      onPressed: onPressed,
      child: Text(text),);
  }
}