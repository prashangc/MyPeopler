import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/controllers.dart';
import 'package:my_peopler/src/core/pallete.dart';
import 'package:my_peopler/src/models/models.dart';
import 'package:my_peopler/src/routes/appPages.dart';
import 'package:my_peopler/src/utils/utils.dart';
import 'package:my_peopler/src/widgets/myDrawer.dart';
import 'package:my_peopler/src/widgets/no_data_widget.dart';
import 'package:my_peopler/src/widgets/splashWidget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HolidayView extends StatefulWidget {
  HolidayView({Key? key}) : super(key: key);

  @override
  State<HolidayView> createState() => _HolidayViewState();
}

class _HolidayViewState extends State<HolidayView> {
  final RefreshController refreshController = RefreshController();

  final RefreshController listRefresher = RefreshController();

  @override
  void initState() {
    Get.find<HolidayController>().refreshHolidays();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: Icon(
              Icons.menu,
            ),
          );
        }),
        title: Text("Holiday"),
        automaticallyImplyLeading: false,
      ),
      body: SmartRefresher(
        controller: refreshController,
        onRefresh: () async {
          await Get.find<HolidayController>().refreshHolidays();
          refreshController.refreshCompleted();
        },
        child: GetBuilder<HolidayController>(builder: (holidayController) {
          if (holidayController.isRefreshing.value) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }else if(holidayController.holidays.isEmpty){
            return NoDataWidget();
          }
          return SmartRefresher(
            controller: listRefresher,
            onRefresh: () async {
              await Get.find<HolidayController>().refreshHolidays();
              listRefresher.refreshCompleted();
            },
            child: ListView.builder(
              itemCount: holidayController.holidays.length,
              itemBuilder: (context, index) {
                return HolidayCard(
                  holiday: holidayController.holidays[index],
                );
              },
            ),
          );
        }),
      ),
    );
  }
}

class HolidayCard extends StatelessWidget {
  const HolidayCard({Key? key, required this.holiday}) : super(key: key);
  final Holiday holiday;
  @override
  Widget build(BuildContext context) {
    return SplashWidget(
      onTap: () {
        Get.find<NavController>().toNamed(Routes.SINGLE_HOLIDAY, arguments: holiday);
      },
      splashColor: Pallete.primaryCol,
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      shadowColor: Colors.black,
      radius: 8,
      bgCol: Colors.white,
      elevation: 5,
      child: Column(
         mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      holiday.holidayName ?? "",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  
                  
                  ],
                ),
              ),
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Container(
                           alignment: Alignment.centerRight,
                           child: Column(
                             mainAxisAlignment: MainAxisAlignment.start,
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                  Text(
                    "Start Date: ${MyDateUtils.getDateOnly(holiday.startDate)}",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(
                  "End Date: ${MyDateUtils.getDateOnly(holiday.endDate)}",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                             ],
                           ),
                         ),
               )
            ],
          ),
         
        ],
      ),
    );
  }
}
