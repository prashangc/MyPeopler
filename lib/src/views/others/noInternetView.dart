import 'package:flutter/material.dart';
import 'package:my_peopler/src/core/pallete.dart';

class NoInternetView extends StatelessWidget {
  const NoInternetView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "No Internet\nPlease connect to internet.",
          style: TextStyle(
            fontSize: 22,
            color: Pallete.primaryCol,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}