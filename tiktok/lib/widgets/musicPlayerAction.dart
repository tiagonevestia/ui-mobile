import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tiktok/utils/general.dart';

class MusicPlayerAction extends StatelessWidget {
  LinearGradient get musicGradient => LinearGradient(
        colors: [
          Colors.grey[800],
          Colors.grey[900],
          Colors.grey[900],
          Colors.grey[800]
        ],
        stops: [0.0, 0.4, 0.6, 1.0],
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40.0),
      height: Sizes.ActionWidgetSize,
      width: Sizes.ActionWidgetSize,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(11.0),
            height: Sizes.ProfileImageSize,
            width: Sizes.ProfileImageSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Sizes.ProfileImageSize / 2),
              gradient: musicGradient,
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
        ],
      ),
    );
  }
}
