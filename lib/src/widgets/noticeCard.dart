import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/navController.dart';
import 'package:my_peopler/src/core/pallete.dart';
import 'package:my_peopler/src/models/models.dart';
import 'package:my_peopler/src/routes/appPages.dart';
import 'package:my_peopler/src/utils/utils.dart';
import 'package:my_peopler/src/widgets/splashWidget.dart';

class NoticeCard extends StatelessWidget {
  const NoticeCard({
    Key? key,
    this.hPad = 0,
    required this.notice,
  }) : super(key: key);

  final Notice notice;

  final double hPad;
  @override
  Widget build(BuildContext context) {
    return SplashWidget(
      onTap: () {
        Get.find<NavController>().toNamed(Routes.SINGLE_NOTICE, arguments: notice);
      },
      shadowColor: Colors.black,
      splashColor: Pallete.primaryCol,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: hPad),
      contentPadding: EdgeInsets.symmetric(horizontal: 10),
      radius: 8,
      bgCol: Colors.white,
      elevation: 3,
      border: Border.all(color: Pallete.primaryCol.withOpacity(0.7)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notice.title??"",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    notice.description??"",
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.justify,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    MyDateUtils.getDateOnly(notice.start_date),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 15,
          )
        ],
      ),
    );
  }
}
