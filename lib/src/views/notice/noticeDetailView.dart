import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/navController.dart';
import 'package:my_peopler/src/models/models.dart';
import 'package:my_peopler/src/utils/utils.dart';

class NoticeDetailView extends StatelessWidget {
  const NoticeDetailView({Key? key, required this.notice}) : super(key: key);
  final Notice notice;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notice Detail"),
        leading: IconButton(
          onPressed: () {
            Get.find<NavController>().back();
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.centerRight,
                child: Text(
                  "From: ${MyDateUtils.getDateOnly(notice.start_date)}\nTo: ${MyDateUtils.getDateOnly(notice.end_date)}",
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.end,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                notice.title ?? "",
                style: Theme.of(context).textTheme.displayLarge,
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 1.3,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                notice.description??"",
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
