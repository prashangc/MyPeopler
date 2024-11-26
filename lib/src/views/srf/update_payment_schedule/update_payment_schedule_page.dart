import 'package:flutter/material.dart';

class UpdatePaymentSchedule extends StatefulWidget {
  final int? itemId;
  const UpdatePaymentSchedule({super.key, this.itemId});

  @override
  State<UpdatePaymentSchedule> createState() => _UpdatePaymentScheduleState();
}

class _UpdatePaymentScheduleState extends State<UpdatePaymentSchedule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update'),
        centerTitle: true,
      ),
      body: Container(),
    );
  }
}