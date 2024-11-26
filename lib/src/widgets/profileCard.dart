import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_peopler/src/helpers/helpers.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({Key? key, required this.imgUrl, this.radius = 45})
      : super(key: key);
  final String imgUrl;
  final double radius;
  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.black,
      elevation: 15,
      shape: CircleBorder(),
      child: CircleAvatar(
        radius: radius,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: CachedNetworkImage(
            imageUrl: imgUrl,
            height: radius * 2,
            width: radius * 2,
            errorWidget: (context, url, error) {
              return Center(
                child: Text(
                  StorageHelper.userName?[0]??"P",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 22,
                  ),
                ),
              );
            },
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
