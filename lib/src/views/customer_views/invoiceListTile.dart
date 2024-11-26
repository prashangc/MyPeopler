
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/core/core.dart';
import 'package:my_peopler/src/views/customer_views/invoiceDetailScreen.dart';

class Item{
  String image;
  String productName;
  String qty;
  String rate;
  Item(this.image,this.productName,this.qty,this.rate);
}

class InvoiceListTile extends StatefulWidget {
  const InvoiceListTile({Key? key, }) : super(key: key);

  @override
  State<InvoiceListTile> createState() => _OrderListTileState();
}

class _OrderListTileState extends State<InvoiceListTile> {
  int mainIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        color: Colors.white,
        child: InkWell(
          onTap: () {
            Get.to(
                () => InvoiceDetailScreen(
                      isCancel: 0,
                      items: [
                        Item('','Rice','1','100'),
                        Item('','Rice','1','100'),
                        Item('','Rice','1','100'),
                        Item('','Rice','1','100'),
                        Item('','Rice','1','100'),
                      ],
                      orderId: '1',
                      orderNumber: '100',
                      orderStatus: "processing",
                      totalAmount: 1000.0,
                      orderDate: DateTime.now(),
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
                  height: 10,
                ),
                Row(
                  children: [
                    Text('Invoice - #1',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildCartItemRow(Item items) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: CachedNetworkImage(
            imageUrl: items.image ?? '',
            width: 100,
            height: 80,
            fit: BoxFit.contain,
            errorWidget: (context, url, error) {
              return Image.asset(
                MyAssets.award,
                fit: BoxFit.cover,
              );
            },
          ),
        ),
        SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                items.productName.toString(),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Rs. ${items.rate}",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "x ${items.qty}",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
