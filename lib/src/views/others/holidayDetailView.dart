import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/navController.dart';
import 'package:my_peopler/src/models/models.dart';
import 'package:my_peopler/src/utils/utils.dart';

class HolidayDetailView extends StatelessWidget {
  const HolidayDetailView({Key? key, required this.holiday}) : super(key: key);
  final Holiday holiday;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Holiday Detail"),
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Container(
                    height: 50,
                    width: 200,
                alignment: Alignment.centerLeft,
                child: Text(
                  holiday.holidayName??"",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black,fontSize: 20.0,fontWeight: FontWeight.bold)
                ),
              ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Column(
                      children: [
                        Text(
                          "Start Date: ${MyDateUtils.getDateOnly(holiday.startDate)}",
                          style: Theme.of(context).textTheme.bodySmall,
                          textAlign: TextAlign.end,
                        ),
                         Text(
                          "End Date: ${MyDateUtils.getDateOnly(holiday.endDate)}",
                          style: Theme.of(context).textTheme.bodySmall,
                          textAlign: TextAlign.end,
                        ),
                      ],
                    ),
                  ),
                ],
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
                holiday.description??"",
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
