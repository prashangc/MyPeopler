import 'package:flutter/material.dart';

class ProfileRichText extends StatelessWidget {
  const ProfileRichText({Key? key, required this.label, this.value})
      : super(key: key);
  final String label;
  final String? value;
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: value != null,
      child: RichText(
        text: TextSpan(
          style: TextStyle(fontSize: 16, color: Colors.black),
          children: [
            TextSpan(
                text: label, style: TextStyle(fontWeight: FontWeight.w600)),
            TextSpan(
              text: value,
            ),
          ],
        ),
      ),
    );
  }
}
