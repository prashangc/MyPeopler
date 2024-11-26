import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/sfaProductListController.dart';
import 'package:my_peopler/src/core/core.dart';
import 'package:my_peopler/src/core/pallete.dart';
import 'package:my_peopler/src/helpers/helpers.dart';
import 'package:my_peopler/src/models/sfa/sfa_product_order_report.dart';
import 'package:my_peopler/src/resources/color_manager.dart';
import 'package:my_peopler/src/routes/appPages.dart';
import 'package:my_peopler/src/views/customer_views/customerOrderListTile.dart';
import 'package:my_peopler/src/widgets/no_data_widget.dart';

class ProductOrderReportItemView extends StatefulWidget {
  const ProductOrderReportItemView(
      {Key? key,
      required this.orderId,
      required this.orderNumber,
      required this.orderStatus,
      required this.type,
      required this.totalAmount,
      required this.orderDate,
      required this.items,
      required this.reportDetails,
      required this.isCancel,
      required this.appTitle,
      required this.billedTo,
      required this.clientType,
      this.actionButton = true})
      : super(key: key);
  final String orderId;
  final String orderNumber;
  final String orderStatus;
  final double totalAmount;
  final DateTime orderDate;
  final List<OrderItem>? items;
  final ProductOrderReport? reportDetails;
  final int isCancel;
  final String appTitle;
  final String billedTo;
  final String type;
  final String clientType;
  final bool actionButton;

  @override
  State<ProductOrderReportItemView> createState() =>
      _ProductOrderReportItemViewState();
}

class _ProductOrderReportItemViewState
    extends State<ProductOrderReportItemView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('# ${widget.appTitle}'),
        centerTitle: true,
      ),
      body: GetBuilder<SfaProductListController>(builder: (controller) {
        return Column(
          children: [
          _buildHeaderCard(),
          Expanded(child: _buildOrderItemsList()),
          widget.clientType == 'Distributor' || widget.clientType == 'Dealer' ? _buildFooterCardAccToClientType(controller): _buildFooterCard(controller),
          ],
        );
      }),
      // persistentFooterButtons: [
      //   _buildCancelOrderButton(context),
      // ],
    );
  }

  _buildHeaderCard() {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Order #${widget.orderNumber}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
              Text(
                "Order Date: ${widget.orderDate.day}-${widget.orderDate.month}-${widget.orderDate.year}",
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                "Billed To: ${widget.billedTo} (${widget.clientType})",
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            child: ElevatedButton(
              onPressed: null,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                padding: EdgeInsets.all(8),
                enableFeedback: false,
                disabledForegroundColor: Colors.black,
                disabledBackgroundColor:
                    widget.orderStatus.toUpperCase() == 'APPROVED'
                        ? Colors.green
                        : widget.orderStatus.toUpperCase() == 'PENDING'
                            ? Color.fromARGB(223, 222, 149, 2)
                            : widget.orderStatus.toUpperCase() == 'CANCEL'
                                ? Colors.red
                                : ColorManager.primaryOpacity70,
              ),
              child: Text(
                widget.orderStatus.toUpperCase(),
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildOrderItemsList() {
    if (widget.items!.isEmpty) {
      return NoDataWidget();
    }
    return ListView.separated(
      itemCount: widget.items!.length,
      primary: false,
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      separatorBuilder: (context, index) {
        return Divider(
          thickness: 0.5,
          indent: 15,
          endIndent: 15,
        );
      },
      itemBuilder: (itemBuilder, index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: _buildCartItemRow(widget.items![index]),
        );
      },
    );
  }

  _buildFooterCard(SfaProductListController controller) {
    return Container(
      width: double.infinity,
      color: Colors.grey[200],
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Spacer(),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                      fontWeight: FontWeight.normal, color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                        text: "Grand Total: ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 20)),
                    TextSpan(
                      text: "Rs. ${(widget.totalAmount)}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          widget.orderStatus == 'pending' && widget.type == 'own'
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    widget.actionButton
                        ? _buildApproveOrderButton(context, controller)
                        : SizedBox.shrink(),
                    widget.actionButton
                        ? _buildCancelOrderButton(context, controller)
                        : SizedBox.shrink(),
                  ],
                )
              : SizedBox.shrink(),
          SizedBox(
            height: 10,
          ),
          widget.orderStatus == 'pending' && widget.type == 'own'
              ? widget.actionButton
                  ? _buildEditOrderButton(context, controller)
                  : SizedBox.shrink()
              : SizedBox.shrink(),
          SizedBox(
            height: 10,
          ),
          ((widget.orderStatus == 'approved' ||
                      widget.orderStatus == 'partial_dispatch' || widget.orderStatus == 'pending') && widget.type == 'own')
              ? widget.actionButton
                  ? _buildDispatchButton()
                  : SizedBox.shrink()
              : SizedBox.shrink(),
              SizedBox(
            height: 10,
          ),
          _buildPrintButton(context, controller)
        ],
      ),
    );
  }

   _buildFooterCardAccToClientType(SfaProductListController controller) {
    return Container(
      width: double.infinity,
      color: Colors.grey[200],
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Spacer(),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                      fontWeight: FontWeight.normal, color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                        text: "Grand Total: ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 20)),
                    TextSpan(
                      text: "Rs. ${(widget.totalAmount)}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          widget.orderStatus == 'pending'
              ? widget.actionButton
                  ? _buildEditOrderButton(context, controller)
                  : SizedBox.shrink()
              : SizedBox.shrink(),
          SizedBox(
            height: 10,
          ),
          _buildPrintButton(context, controller)
        ],
      ),
    );
  }

  _buildCancelOrderButton(
      BuildContext context, SfaProductListController controller) {
    return widget.isCancel == 1
        ? SizedBox.shrink()
        : SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width / 2.2,
            child: TextButton.icon(
              icon: Icon(
                Icons.close,
                color: Colors.white,
                size: 18,
              ),
              onPressed: () {
                MessageHelper.showInfoAlert(
                    context: context,
                    title: 'Cancelling Order #${widget.orderNumber}',
                    desc: 'Are you sure?',
                    okBtnText: 'Yes',
                    cancelBtnText: 'No',
                    btnCancelOnPress: () {},
                    btnOkOnPress: () async {
                      var message =
                          await controller.changeOrderStatus(OrderStatus(
                        status: 'cancel',
                        orderId: int.parse(widget.orderId),
                      ));

                      MessageHelper.showInfoAlert(
                          context: context,
                          title: message,
                          okBtnText: 'Ok',
                          btnOkOnPress: () async {
                            WidgetsBinding.instance
                                .addPostFrameCallback((_) async {
                              await Get.find<SfaProductListController>()
                                  .getSfaOrdersReport(
                                      dispatchable: 0, type: widget.type);
                              Get.back();
                            });
                          });
                    });
              },
              style: ElevatedButton.styleFrom(
                  elevation: 2, backgroundColor: Colors.red),
              label: Text(
                "Cancel",
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
  }

  _buildEditOrderButton(
      BuildContext context, SfaProductListController controller) {
    return widget.isCancel == 1
        ? SizedBox.shrink()
        : SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: TextButton.icon(
              icon: Icon(
                Icons.edit_outlined,
                color: Colors.white,
                size: 25,
              ),
              onPressed: () {
                Get.toNamed(Routes.PRODUCT_ORDER_REPORT_EDIT_VIEW,
                    arguments: widget.reportDetails);
              },
              style: ElevatedButton.styleFrom(
                  elevation: 2, backgroundColor: Colors.blue),
              label: Text(
                "Edit",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          );
  }

  _buildPrintButton(BuildContext context, SfaProductListController controller) {
    if (controller.isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: TextButton.icon(
        icon: Icon(
          Icons.print_outlined,
          color: Colors.white,
          size: 25,
        ),
        onPressed: () async {
          File file = await controller.printOrderSlip(widget.orderId);
          Get.toNamed(Routes.PDF_SCREEN, arguments: [file.path,file]);
        },
        style: ElevatedButton.styleFrom(
            elevation: 2, backgroundColor: ColorManager.primaryCol),
        label: Text(
          "Print",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }

  _buildApproveOrderButton(
      BuildContext context, SfaProductListController controller) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2.2,
      height: 50,
      child: TextButton.icon(
        icon: Icon(
          Icons.done,
          color: Colors.white,
          size: 18,
        ),
        onPressed: () async {
          MessageHelper.showInfoAlert(
              context: context,
              title: 'Approving Order #${widget.orderNumber}',
              desc: 'Are you sure?',
              okBtnText: 'Yes',
              cancelBtnText: 'No',
              btnCancelOnPress: () {},
              btnOkOnPress: () async {
                var message = await controller.changeOrderStatus(OrderStatus(
                  status: 'approved',
                  orderId: int.parse(widget.orderId),
                ));

                MessageHelper.showInfoAlert(
                    context: context,
                    title: message,
                    okBtnText: 'Ok',
                    btnOkOnPress: () {
                      WidgetsBinding.instance.addPostFrameCallback((_) async {
                        await Get.find<SfaProductListController>()
                            .getSfaOrdersReport(
                                dispatchable: 0, type: widget.type);
                        Get.back();
                      });
                    });
              });
        },
        style: ElevatedButton.styleFrom(
            elevation: 2, backgroundColor: Colors.green),
        label: Text(
          "Approve",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  _buildFullDispatchButton(
      BuildContext context, SfaProductListController controller) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2.2,
      height: 50,
      child: TextButton.icon(
        icon: Icon(
          Icons.hourglass_full_outlined,
          color: Colors.white,
          size: 18,
        ),
        onPressed: () async {
          MessageHelper.showInfoAlert(
              context: context,
              title: 'Full-Dispatching Order #${widget.orderNumber}',
              desc: 'Are you sure?',
              okBtnText: 'Yes',
              cancelBtnText: 'No',
              btnCancelOnPress: () {},
              btnOkOnPress: () async {
                //   var message = await controller.changeOrderStatus(OrderStatus(
                //     status: 'approved',
                //     orderId: int.parse(widget.orderId),
                //   ));

                //   MessageHelper.showInfoAlert(
                //     context: context,
                //    title: message,
                //    okBtnText: 'Ok',
                //    btnOkOnPress: () {
                //     WidgetsBinding.instance.addPostFrameCallback((_) async {
                //           await Get.find<SfaProductListController>()
                //           .getSfaOrdersReport(dispatchable: 0);
                //           Get.back();
                //     });
                //    }
                //    );
              });
        },
        style: ElevatedButton.styleFrom(
            elevation: 2, backgroundColor: Colors.blue),
        label: Text(
          "Full Dispatch",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  _buildPartialDispatchButton(
      BuildContext context, SfaProductListController controller) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2.2,
      height: 50,
      child: TextButton.icon(
        icon: Icon(
          Icons.hourglass_bottom_sharp,
          color: Colors.white,
          size: 18,
        ),
        onPressed: () async {
          MessageHelper.showInfoAlert(
              context: context,
              title: 'Partial-Dispatching Order #${widget.orderNumber}',
              desc: 'Are you sure?',
              okBtnText: 'Yes',
              cancelBtnText: 'No',
              btnCancelOnPress: () {},
              btnOkOnPress: () async {
                //   var message = await controller.changeOrderStatus(OrderStatus(
                //     status: 'approved',
                //     orderId: int.parse(widget.orderId),
                //   ));

                //   MessageHelper.showInfoAlert(
                //     context: context,
                //    title: message,
                //    okBtnText: 'Ok',
                //    btnOkOnPress: () {
                //     WidgetsBinding.instance.addPostFrameCallback((_) async {
                //           await Get.find<SfaProductListController>()
                //           .getSfaOrdersReport(dispatchable: 0);
                //           Get.back();
                //     });
                //    }
                //    );
              });
        },
        style: ElevatedButton.styleFrom(
            elevation: 2, backgroundColor: ColorManager.lightGreen),
        label: Text(
          "Partial Dispatch",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  _buildCartItemRow(OrderItem items) {
    return Container(
      clipBehavior: Clip.antiAlias,
      height: 110,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.0),
          color: Pallete.cardWhite,
          boxShadow: [
            BoxShadow(
                blurRadius: 1,
                spreadRadius: 0.5,
                color: Colors.black12,
                offset: Offset(0, 1))
          ]),
      padding: EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  items.productName.toString(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox.shrink(),
                    // Text(
                    //   'Available Qty: ${items.availableQty.toString()}',
                    //   style: TextStyle(
                    //     fontSize: 14,
                    //     fontWeight: FontWeight.normal,
                    //     color: Colors.black,
                    //   ),
                    // ),
                    Text(
                      'S.P: ${items.sellingPrice.toString()}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Ask Qty: ${items.qty.toString()}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Total: ${items.rate.toString()}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                items.dispatchQty != "null"
                    ? Text(
                        'Dispatch Qty: ${items.dispatchQty}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      )
                    : SizedBox.shrink(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildDispatchButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: SizedBox(
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: TextButton.icon(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue[600])),
          onPressed: () {
            Get.toNamed(Routes.PRODUCT_ORDER_REPORT_DISPATCH_VIEW,arguments: widget.reportDetails);
          },
          icon: Icon(
            Icons.hourglass_empty_outlined,
            color: Colors.white,
          ),
          label: Text(
            'Dispatch',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }

 
}
