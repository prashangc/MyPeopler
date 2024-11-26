import 'package:flutter/material.dart';

class ProfileTFF extends StatelessWidget {
  const ProfileTFF({
    Key? key,
    required this.name,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.hintText,
    this.icon,
    this.controller,
    this.validator,
    this.enabled,
    this.hideLabel = false,
  }) : super(key: key);
  final String name;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? hintText;
  final Widget? icon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool? enabled;
  final bool hideLabel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        !hideLabel
            ? Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
              )
            : Container(),
        hideLabel ? const SizedBox(height: 0) : const SizedBox(height: 10),
        TextFormField(
          controller: controller,
          validator: validator,
          obscureText: obscureText,
          maxLines: null,
          keyboardType: keyboardType,
          enabled: enabled,
          decoration: InputDecoration(
            hintText: hintText,
            icon: icon,
            fillColor: (enabled == null || enabled!) ? Colors.indigo[50] : Colors.grey.shade300,
            filled: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 15,vertical: 8),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(12)),
            
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),
        SizedBox(height: 10,)
      ],
    );
  }
}
