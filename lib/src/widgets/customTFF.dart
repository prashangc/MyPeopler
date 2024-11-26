import 'package:flutter/material.dart';
import 'package:my_peopler/src/core/pallete.dart';

class CustomTFF extends StatefulWidget {
   CustomTFF(
      {Key? key,
      this.controller,
      this.labelText,
      this.hintText,
      this.obscureText = false,
      this.validator,
      this.radius = 4,
      this.hPad = 15,
      this.vPad = 15,
      this.floatLabel = true,
      this.maxLines = 1,
      this.onChanged,
      this.onTap,
      this.keyboardType,
      this.readOnly = false,
      this.isLast = false})
      : super(key: key);
   TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final bool obscureText;
  final String? Function(String?)? validator;
  final double radius;
  final double hPad;
  final double vPad;
  final bool floatLabel;
  final int? maxLines;
  final Function(String)? onChanged;
  final void Function()? onTap;
  final bool isLast;
  final bool readOnly;
  final TextInputType? keyboardType;

  @override
  State<CustomTFF> createState() => _CustomTFFState();
}

class _CustomTFFState extends State<CustomTFF> {
  bool? showPass;
  @override
  void initState() {
    showPass = widget.obscureText;
    super.initState();
  }


  _toggleVisibility() {
    setState(() {
      showPass = !showPass!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: widget.hPad, vertical: widget.vPad),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: widget.controller,
              obscureText: showPass!,
              maxLines: widget.maxLines,
              cursorColor: Pallete.primaryCol,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: widget.validator,
              onChanged: widget.onChanged,
              onTap: widget.onTap,
              readOnly: widget.readOnly,
              keyboardType: widget.labelText=='Username'?TextInputType.emailAddress  : widget.keyboardType,
              textInputAction:
                  widget.isLast ? TextInputAction.done : TextInputAction.next,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.radius)),
                    hintText: widget.hintText,
                labelText: widget.labelText,
                labelStyle: TextStyle(color: Pallete.primaryCol),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.radius),
                  borderSide: BorderSide(color: Pallete.primaryCol, width: 1.0),
                ),
                fillColor: Colors.indigo.shade50,
                filled: true,
                floatingLabelBehavior: widget.floatLabel
                    ? FloatingLabelBehavior.auto
                    : FloatingLabelBehavior.never,
                focusColor: Pallete.primaryCol,
                suffixIcon: widget.obscureText
                    ? IconButton(
                        onPressed: _toggleVisibility,
                        icon: Icon(
                          !showPass! ? Icons.visibility : Icons.visibility_off,
                          color: Pallete.primaryCol,
                        ),
                      )
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
