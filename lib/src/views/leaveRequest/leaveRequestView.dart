import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/controllers.dart';
import 'package:my_peopler/src/core/pallete.dart';
import 'package:my_peopler/src/resources/color_manager.dart';
import 'package:my_peopler/src/routes/appPages.dart';
import 'package:my_peopler/src/views/leaveRequest/newLeaveRequestView.dart';
import 'package:my_peopler/src/views/leaveRequest/widgets/leaveApplications.dart';
import 'package:my_peopler/src/widgets/myDrawer.dart';
import 'package:my_peopler/src/widgets/no_data_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class LeaveRequetView extends StatefulWidget {
  const LeaveRequetView({super.key});

  @override
  State<LeaveRequetView> createState() => _LeaveRequetViewState();
}

class _LeaveRequetViewState extends State<LeaveRequetView> {
  final RefreshController refreshController = RefreshController();
  @override
  void initState() {
    super.initState();
    Get.find<LeaveController>().callAllApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            tooltip: 'Request Leave',
            heroTag: "Request Leave",
            backgroundColor: ColorManager.primaryCol,
            onPressed: () async {
              await Get.bottomSheet(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                NewLeaveRequestView(),
              );
              // Get.find<NavController>().toNamed(Routes.LEAVE_REQUEST);
            },
            child: Icon(Icons.add),
          ),
          SizedBox(
            height: kToolbarHeight + 10,
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      appBar: AppBar(
        backgroundColor: Pallete.primaryCol,
        elevation: 0,
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
        title: Text("Leave Request"),
        centerTitle: true,
        actions: [
          IconButton(
            splashRadius: 22,
            onPressed: () {
              Get.toNamed(Routes.REMAINING_LEAVE);
              //Get.find<NavController>().toNamed(Routes.REMAINING_LEAVE);
            },
            icon: Icon(Icons.hourglass_top_rounded),
          ),
        ],
      ),
      body: SmartRefresher(
        controller: refreshController,
        onRefresh: () async {
          await Get.find<LeaveController>().getLeaves();
          refreshController.refreshCompleted();
        },
        child: GetBuilder<LeaveController>(builder: (leaveController) {
          if (leaveController.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (leaveController.leaves.isEmpty) {
            return NoDataWidget();
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
              child: Column(
                children: [
                  // Leave Request
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "My Leave Request",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      )
                    ],
                  ),
                  LeaveApplications(
                    leaves: leaveController.leaves,
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
