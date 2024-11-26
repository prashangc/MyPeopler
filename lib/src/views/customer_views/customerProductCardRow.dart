
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/core/core.dart';
import 'package:my_peopler/src/views/customer_views/customerProductCard.dart';

class CustomerProductCardRow extends StatelessWidget {
  const CustomerProductCardRow({Key? key, required this.product,this.onTapAddIcon}) : super(key: key);
  final Product product;
  final void Function()? onTapAddIcon;
  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
          onTap: () {
         
          },
          child: SizedBox(
            height: 80,
            width: MediaQuery.of(context).size.width,
            child: ListTile(
              tileColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(horizontal: 12),
              minVerticalPadding: 12,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              title: Text(
                product.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              isThreeLine: true,
              leading: Container(
                height: 80,
                width: 60,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.white,
                ),
                child: CachedNetworkImage(
                  imageUrl: product.image ?? "",
                  width: double.maxFinite,
                  fit: BoxFit.contain,
                  height: 80,
                  errorWidget: (context, url, error) {
                    return Icon(Icons.shopping_bag_outlined,size: 40,color: Colors.black,);
                  },
                ),
              ),
              subtitle: Text(
                'Rs. ${product.price.toString()}',
                style: TextStyle(
                  fontSize: 11,
                ),
              ),
              trailing: Container(
               height: 56,
               width: 70,
               padding: EdgeInsets.only(top: 2, right: 0),
               alignment: Alignment.center,
               decoration: BoxDecoration(
                   color: Pallete.primaryCol,
                   borderRadius: BorderRadius.circular(4.0)),
               child: InkWell(
                 onTap: onTapAddIcon,
                 child: Icon(
                   Icons.add,
                   size: 16,
                   color: Colors.white,
                 ),
               ),
                                ),
            ),
          )),
    );
  }
}
