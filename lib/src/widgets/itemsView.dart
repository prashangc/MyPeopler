
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/core/core.dart';
import 'package:my_peopler/src/core/pallete.dart';
import 'package:my_peopler/src/views/customer_views/customerOrderListTile.dart';
import 'package:my_peopler/src/widgets/no_data_widget.dart';

class ItemsView extends StatefulWidget {
  const ItemsView(
      {Key? key,
      required this.orderId,
      required this.orderNumber,
      required this.orderStatus,
      required this.totalAmount,
      required this.orderDate,
      required this.items,
      required this.isCancel,
      required this.appTitle
      })
      : super(key: key);
  final String orderId;
  final String orderNumber;
  final String orderStatus;
  final double totalAmount;
  final DateTime orderDate;
  final List<OrderItem>? items;
  final int isCancel;
  final String appTitle;

  @override
  State<ItemsView> createState() => _ItemsViewState();
}

class _ItemsViewState extends State<ItemsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title: Text(widget.appTitle),
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
                "Order #${widget.orderNumber}",
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            child: ElevatedButton(
              onPressed: null,
              style: ElevatedButton.styleFrom(
                  backgroundColor: widget.isCancel == 1
                      ? Colors.grey[300]
                      : Colors.grey[300],
                  foregroundColor: Colors.black,
                  padding: EdgeInsets.all(8),
                  enableFeedback: false,
                  disabledForegroundColor: Colors.black,
                  disabledBackgroundColor: widget.isCancel == 1
                      ? Colors.grey[300]
                      : Colors.grey[300]),
              child: Text(
                widget.isCancel == 1 ? 'Cancelled' : "Order Placed",
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildOrderItemsList() {
    if(widget.items!.isEmpty){
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
                    TextSpan(text: "Total: ", style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black,fontSize: 20)),
                    TextSpan(
                      text: "Rs. ${(widget.totalAmount)}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black,fontSize: 20),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          //TODO:[SPANDAN] ARUN SIR told no need of cancel button
         // _buildCancelOrderButton(context),
        ],
      ),
    );
  }

  // _buildViewTrackButton(BuildContext context) {
  _buildCancelOrderButton(BuildContext context) {
    return widget.isCancel == 1
        ? SizedBox.shrink()
        : SizedBox(
            width: MediaQuery.of(context).size.width / 2.2,
            child: ElevatedButton(
              onPressed: () {
                
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              child: Text(
                "Cancel Order",
                style: TextStyle(color: Colors.black),
              ),
            ),
          );
  }

  _buildCartItemRow(OrderItem items) {
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
              errorWidget: (context, url, error) {return Icon(Icons.shopping_bag_outlined,size: 90,);
               
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
