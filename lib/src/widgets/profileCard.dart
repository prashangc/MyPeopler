import 'package:flutter/material.dart';
import 'package:my_peopler/src/views/profile/myCachedNetworkImage.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key, required this.imgUrl, this.radius = 45});
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
          child: myCachedNetworkImageCircle(
            radius * 2,
            radius * 2,
            imgUrl,
            BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
