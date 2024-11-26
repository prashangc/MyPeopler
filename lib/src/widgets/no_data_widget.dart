import 'package:flutter/material.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({super.key,this.title = 'data'});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
       Image.asset("assets/images/no_data_found.jpeg"),
      ],
    );
  }
}

class NoSearchResultWidget extends StatelessWidget {
  const NoSearchResultWidget({super.key,this.title = 'data'});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Image.asset(
     "assets/images/no_data_found.jpeg",
     height: MediaQuery.of(context).size.height/2.5,
     width: MediaQuery.of(context).size.width,
     );
  }
}