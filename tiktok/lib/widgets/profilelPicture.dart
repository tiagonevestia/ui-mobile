import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tiktok/utils/general.dart';

class ProfilePicture extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: (Sizes.ActionWidgetSize / 2) - (Sizes.ProfileImageSize / 2),
      child: Container(
        padding: EdgeInsets.all(1.0),
        height: Sizes.ProfileImageSize,
        width: Sizes.ProfileImageSize,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Sizes.ProfileImageSize / 2),
        ),
        child: CachedNetworkImage(
          imageUrl:
              'https://ca.slack-edge.com/TAUJCPJUC-UAVFTGG02-e1a9009369a1-512',
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Sizes.ProfileImageSize),
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
