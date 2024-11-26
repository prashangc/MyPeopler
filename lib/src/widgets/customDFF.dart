import 'package:flutter/material.dart';

class CustomDFF extends StatelessWidget {
  const CustomDFF(
      {Key? key,
      required this.name,
      required this.items,
      required this.onChanged,required this.value,  this.hideLabel = false})
      : super(key: key);

  final String name;
  final String? value;
  final List<DropdownMenuItem<String>>? items;
  final void Function(String?)? onChanged;
  final bool hideLabel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: !hideLabel,
          child: Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 60,
          child: DropdownButtonFormField<String>(
            items: items,
            value: value,
            onChanged: onChanged,
            isExpanded: true,
            focusColor: Colors.white,
            borderRadius: BorderRadius.circular(12),
            icon: const Icon(Icons.keyboard_arrow_down_rounded),
            decoration: InputDecoration(
              fillColor: Colors.indigo.shade50,
              filled: true,
              
              contentPadding: EdgeInsets.symmetric(horizontal: 15),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            validator: (val){
              if(val == null || val == ""){
                return "Please select $name";
              }
              return null;
            },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
        ),
      ],
    );
  }
}