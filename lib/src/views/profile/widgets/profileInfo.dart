import 'package:flutter/material.dart';
import 'package:my_peopler/src/models/models.dart';
import 'package:my_peopler/src/views/profile/widgets/profileRichText.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({Key? key, this.user}) : super(key: key);
  final User? user;

  String? _getGenderName(String? val){
    if(val == null){
      return null;
    }
    if(val == "f"){
      return "Female";
    }else if(val == "m"){
      return "Male";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
        elevation: 0,
        color: Colors.grey.shade300,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileRichText(label: "Employee ID: ",value: user?.id?.toString()),
              ProfileRichText(label: "Designation: ",value: user?.designation_name?.toString()),
              ProfileRichText(label: "Gender: ",value: _getGenderName(user?.gender)),
              ProfileRichText(label: "Contact No: ",value: user?.contact_no_one),
              ProfileRichText(label: "Joining Date: ",value: user?.joining_date),
            ],
          ),
        ),
      ),
    );
  }
}