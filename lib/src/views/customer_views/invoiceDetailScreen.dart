
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_peopler/src/core/core.dart';

class InvoiceDetailScreen extends StatefulWidget {
  const InvoiceDetailScreen(
      {Key? key,
      required this.orderId,
      required this.orderNumber,
      required this.orderStatus,
      required this.totalAmount,
      required this.orderDate,
      required this.items,
      required this.isCancel})
      : super(key: key);
  final String orderId;
  final String orderNumber;
  final String orderStatus;
  final double totalAmount;
  final DateTime orderDate;
  final List<dynamic>? items;
  final int isCancel;

  @override
  State<InvoiceDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<InvoiceDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invoice Details'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildHeaderCard(),
          Expanded(child: _buildOrderItemsList()),
          _buildFooterCard(),
        ],
      ),
      // persistentFooterButtons: [
      //   //_buildCancelOrderButton(context),
      //   // _buildViewTrackButton(context)
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
                "Invoice #${widget.orderNumber}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
              Text(
                "Placed on ${widget.orderDate.day}-${widget.orderDate.month}-${widget.orderDate.year}",
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
         
        ],
      ),
    );
  }

  _buildOrderItemsList() {
    return ListView.separated(
      itemCount: 5,
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

  _buildFooterCard() {
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
                    TextSpan(text: "Total: "),
                    TextSpan(
                      text: "Rs. ${(widget.totalAmount).toInt()}",
                      style: TextStyle(
                          fontWeight: FontWeight.normal, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
       
        ],
      ),
    );
  }

  _buildCartItemRow(dynamic items) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(14.0),
        color: Pallete.cardWhite,
        boxShadow: [
               BoxShadow(
                  blurRadius: 1, 
                  spreadRadius: 0.5, 
                  color: Colors.black12,
                  offset: Offset(0,1)
                  )
        ]
      ),
      
      padding: EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImage(
              imageUrl: items.image ?? '',
              width: 100,
              height: 100,
              fit: BoxFit.cover,
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
                  items!.productName.toString(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Rs. ${items.rate.toString()}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'x ${items.qty.toString()}',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
