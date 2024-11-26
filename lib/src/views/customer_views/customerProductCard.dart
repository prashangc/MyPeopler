import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_peopler/src/core/core.dart';

class Product {
  String name;
  String price;
  String image;
  Product(this.name, this.price, this.image);
}

class CustomerProductCard extends StatelessWidget {
  const CustomerProductCard({Key? key, required this.product, this.icon,this.onTapAddIcon})
      : super(key: key);
  final Product product;
  final IconData? icon;
  final void Function()? onTapAddIcon;
  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: Colors.white,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () {},
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Stack(
                    children: [
                      Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.white,
                        ),
                        child: CachedNetworkImage(
                          imageUrl: product.image ?? "",
                          width: double.maxFinite,
                          fit: BoxFit.cover,
                          height: double.maxFinite,
                          errorWidget: (context, url, error) {
                            return Icon(Icons.shopping_bag_outlined,size: 90,);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 3.0, vertical: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 14.0,
                            ),
                          ),
                          Text(
                            "Rs. ${product.price}",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: onTapAddIcon,
                      child: Container(
                        height: 30,
                        width: 30,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Pallete.primaryCol,
                            borderRadius: BorderRadius.circular(4.0)),
                        child: Icon(
                          Icons.add,
                          size: 18.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
