import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/controllers.dart';
import 'package:my_peopler/src/core/constants/myAssets.dart';
import 'package:my_peopler/src/core/pallete.dart';
import 'package:my_peopler/src/models/models.dart';
import 'package:my_peopler/src/utils/utils.dart';
import 'package:my_peopler/src/widgets/myDrawer.dart';
import 'package:my_peopler/src/widgets/no_data_widget.dart';
import 'package:my_peopler/src/widgets/splashWidget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AwardsView extends StatefulWidget {
  AwardsView({Key? key}) : super(key: key);

  @override
  State<AwardsView> createState() => _AwardsViewState();
}

class _AwardsViewState extends State<AwardsView> {
  final RefreshController refreshController = RefreshController();

  final RefreshController listRefresher = RefreshController();

  @override
  void initState() {
    super.initState();
    Get.find<AwardController>().refreshAward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(
                Icons.menu,
              ),
            );
          },
        ),
        title: Text("Awards"),
        automaticallyImplyLeading: false,
      ),
      body: SmartRefresher(
        controller: refreshController,
        onRefresh: () async {
          await Get.find<AwardController>().refreshAward();
          refreshController.refreshCompleted();
        },
        child: GetBuilder<AwardController>(builder: (awardControler) {
          if (awardControler.isRefreshing.value) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }else if(awardControler.awards.isEmpty){
            return NoDataWidget();
          }
          return SmartRefresher(
            controller: listRefresher,
            onRefresh: () async {
              await Get.find<AwardController>().refreshAward();
              listRefresher.refreshCompleted();
            },
            child: ListView.builder(
              itemCount: awardControler.awards.length,
              itemBuilder: (context, index) {
                return AwardCardTile(
                  award: awardControler.awards[index],
                );
              },
            ),
          );
        }),
      ),
    );
  }
}

class AwardCardTile extends StatelessWidget {
  const AwardCardTile({Key? key, required this.award}) : super(key: key);
  final Award award;
  @override
  Widget build(BuildContext context) {
    return SplashWidget(
      onTap: null,
      shadowColor: Colors.black,
      splashColor: Pallete.primaryCol,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      radius: 8,
      bgCol: Colors.white,
      elevation: 3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 40,
                height: 40,
                child: Image.asset(MyAssets.award),
              )
            ],
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      award.gift_item ?? "",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      "${award.select_month?.day ?? ""}\n${MyDateUtils.getMonthName(award.select_month?.month ?? 0)}",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  award.description ?? "",
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.justify,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 5,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Chip(
                //       backgroundColor: Colors.yellow.shade50,
                //       label: Text(
                //         "published",
                //         style: TextStyle(
                //             fontSize: 11,
                //             color: Colors.green,
                //             fontWeight: FontWeight.w400),
                //       ),
                //       padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
