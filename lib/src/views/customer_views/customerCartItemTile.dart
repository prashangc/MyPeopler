
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_peopler/src/core/core.dart';

class CustomerCartItemTile extends StatelessWidget {
  const CustomerCartItemTile({
    Key? key, required this.imageUrl, required this.name, required this.price, required this.quantity, this.deleteFromCart, this.increment, this.decrement,
  }) : super(key: key);
  final String imageUrl;
  final String name;
  final double price;
  final int quantity;
  final void Function()? deleteFromCart;
  final void Function()? increment;
  final void Function()? decrement;
  @override
  Widget build(BuildContext context) {
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
      
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      
      child: IntrinsicHeight(
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: imageUrl,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) {
                return Icon(Icons.shopping_bag_outlined,size: 90,);
              },
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 14),
                          ),
                        ),
                        SizedBox(
                          width: 50,
                          child: IconButton(
                            onPressed: deleteFromCart,
                            color: Colors.grey[600],
                            icon: Icon(Icons.delete),
                            iconSize: 20,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text("Price: "),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          price.toStringAsFixed(0),
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text("Sub Total: "),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Rs. ${(quantity * price).toStringAsFixed(0)}",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w300,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            InkWell(
                              onTap: decrement,
                              //splashColor: Colors.redAccent.shade200,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: Colors.grey[600]
                                    ),
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(quantity.toString()),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            InkWell(
                              onTap: increment,
                              // splashColor: Colors.indigo,  
                              child: Container(
                                decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(4),
                                     color: Colors.grey[600]),
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
