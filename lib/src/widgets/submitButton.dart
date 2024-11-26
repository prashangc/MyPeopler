import 'package:flutter/material.dart';
import 'package:my_peopler/src/core/pallete.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    Key? key,
    required this.onPressed,
    required this.label,
    this.hPad = 15,
    this.vPad = 15,
    this.radius = 8,
    this.isLoading = false,
    this.color

  }) : super(key: key);
  final void Function()? onPressed;
  final String label;
  final double hPad;
  final double vPad;
  final double radius;
  final bool isLoading;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: vPad),
      child: SizedBox(
        width: double.maxFinite,
        height: 48,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? Pallete.primaryCol,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
          ),
          child: isLoading
              ? CircularProgressIndicator()
              : Text(
                  label,
                  style: TextStyle(fontSize: 18),
                ),
        ),
      ),
    );
  }
}
