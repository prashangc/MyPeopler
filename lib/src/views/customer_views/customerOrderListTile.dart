
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/core/core.dart';
import 'package:my_peopler/src/models/customer/order_history/customer_order_history_model.dart';
import 'package:my_peopler/src/views/customer_views/customerOrderDetailView.dart';

class OrderItem{
  String? image;
  String? productName;
  String? qty;
  String? rate;
  String? availableQty;
  String? sellingPrice;
  String? dispatchQty;
  OrderItem({this.image,this.productName,this.qty,this.rate,this.availableQty,this.sellingPrice,this.dispatchQty});
}

class CustomerOrderListTile extends StatefulWidget {
  const CustomerOrderListTile({Key? key,required this.data}) : super(key: key);
  final CustomerOrderHistoryData data;
  @override
  State<CustomerOrderListTile> createState() => _OrderListTileState();
}

class _OrderListTileState extends State<CustomerOrderListTile> {
  int grandTotal = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        color: Colors.white,
        child: InkWell(
          onTap: () {
            Get.to(
                () => CustomerOrderDetailScreen(
                      isCancel: 0,
                      items: widget.data.items!.isNotEmpty?
                      [...widget.data.items!.map((e) => OrderItem(
                        image:MyAssets.sfa,
                        productName:e.productName?? '',
                        qty:e.askQty.toString(),
                        rate:e.total.toString()
                    ))]:[],
                      orderId: widget.data.id.toString(),
                      orderNumber: widget.data.orderNumber.toString(),
                      orderStatus: "Order Placed",
                      totalAmount: widget.data.total?.toDouble() ?? 0.0,
                      orderDate: widget.data.createdAt ?? DateTime.now(),
                    ),
                transition: Transition.cupertino);
          },
          radius: 12,
          splashColor: Colors.indigo.shade100,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                 SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text('Order - #${widget.data.orderNumber}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
