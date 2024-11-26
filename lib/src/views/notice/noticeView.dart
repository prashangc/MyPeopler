import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/controllers.dart';
import 'package:my_peopler/src/widgets/myDrawer.dart';
import 'package:my_peopler/src/widgets/no_data_widget.dart';
import 'package:my_peopler/src/widgets/noticeCard.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NoticeView extends StatefulWidget {
  NoticeView({Key? key}) : super(key: key);

  @override
  State<NoticeView> createState() => _NoticeViewState();
}

class _NoticeViewState extends State<NoticeView> {
  final RefreshController refreshController = RefreshController();

  final RefreshController listRefresher = RefreshController();

  @override
  void initState() {
     WidgetsBinding.instance.addPostFrameCallback((_) async{
      await Get.find<NoticeController>().refreshNotices();
     });
    
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.find<NavController>().changeView(2,isCustomerView: false);
        return true;
      },
      child: Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          leading: Builder(builder: (context) {
            return IconButton(
              onPressed: () {
                // Get.back(id: NavigatorId.nestedNavigationNavigatorId);
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(
                Icons.menu,
              ),
            );
          }),
          automaticallyImplyLeading: false,
          title: Text("All Notices"),
        ),
        body: SmartRefresher(
          controller: refreshController,
          onRefresh: () async {
            await Get.find<NoticeController>().refreshNotices();
            refreshController.refreshCompleted();
          },
          child: GetX<NoticeController>(builder: (noticeController) {
            if (noticeController.isRefreshing.value) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (noticeController.notices.isEmpty) {
              return NoDataWidget();
            }
            return SmartRefresher(
              controller: listRefresher,
              onRefresh: () async {
                await Get.find<NoticeController>().refreshNotices();
                listRefresher.refreshCompleted();
              },
              child: ListView.builder(
                itemCount: noticeController.notices.length,
                itemBuilder: (context, i) {
                  if (i == noticeController.notices.length - 1) {
                    return Column(
                      children: [
                        NoticeCard(
                          hPad: 15,
                          notice: noticeController.notices[i],
                        ),
                        SizedBox(
                          height: 60,
                        )
                      ],
                    );
                  } else {
                    return NoticeCard(
                      hPad: 15,
                      notice: noticeController.notices[i],
                    );
                  }
                },
              ),
            );
          }),
        ),
      ),
    );
  }
}
