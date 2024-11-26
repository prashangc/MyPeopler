import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:my_peopler/src/controllers/customer/customerProductListController.dart';
import 'package:my_peopler/src/views/customer_views/customerOrderListTile.dart';
import 'package:my_peopler/src/widgets/no_data_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CustomerOrderHistory extends StatefulWidget {
  const CustomerOrderHistory({super.key});

  @override
  State<CustomerOrderHistory> createState() => _CustomerOrderHistoryState();
}

class _CustomerOrderHistoryState extends State<CustomerOrderHistory> {
  final refreshController = RefreshController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Order History'),
        ),
        body: GetBuilder<CustomerProductListController>(builder: (controller) {
          if (controller.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (controller.customerOrderHistoryModel == null) {
            return NoDataWidget();
          }
          return  Column(
              children: [
                Expanded(
                  child: SmartRefresher(
            controller: refreshController,
            onRefresh: () async {
              controller.getCustomerOrderHistory();
              refreshController.refreshCompleted();
            },
            child: ListView.builder(
                      itemCount: controller.customerOrderHistoryModel!.data!.length,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return CustomerOrderListTile(
                            data: controller.customerOrderHistoryModel!.data![index]);
                      },
                    ),
                  ),
                ),
                SizedBox(height: kToolbarHeight+10,)
              ],
        
          );
        }));
  }
}
