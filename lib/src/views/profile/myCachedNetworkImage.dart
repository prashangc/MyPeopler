import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_peopler/src/core/pallete.dart';

Widget myCachedNetworkImage(
  myWidth,
  myHeight,
  myImage,
  borderRadius,
  fit,
) {
  return CachedNetworkImage(
    width: myWidth,
    height: myHeight,
    imageUrl: myImage ?? '',
    imageBuilder: (context, imageProvider) => Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.cover,
          alignment: FractionalOffset.topCenter,
        ),
      ),
    ),
    placeholder: (context, url) => Center(
        child: CircularProgressIndicator(
      color: Pallete.primaryCol,
      strokeWidth: 1.5,
      backgroundColor: Pallete.white,
    )),
    errorWidget: (context, url, error) => Icon(
      Icons.perm_identity,
      size: 36.0,
    ),
  );
}

Widget myCachedNetworkImageCircle(
  myWidth,
  myHeight,
  myImage,
  fit,
) {
  return CachedNetworkImage(
    width: myWidth,
    height: myHeight,
    imageUrl: myImage ?? '',
    imageBuilder: (context, imageProvider) => Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[100],
        image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.cover,
          alignment: FractionalOffset.topCenter,
        ),
      ),
    ),
    placeholder: (context, url) => Center(
        child: CircularProgressIndicator(
      color: Pallete.primaryCol,
      strokeWidth: 1.5,
      backgroundColor: Pallete.white,
    )),
    errorWidget: (context, url, error) => Icon(
      Icons.perm_identity,
      size: 36.0,
    ),
  );
}
