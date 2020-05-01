import 'package:flutter/material.dart';
import 'package:tiktok/utils/general.dart';

import 'plusIcon.dart';
import 'profilelPicture.dart';

class FollowAction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      width: Sizes.ActionWidgetSize,
      height: Sizes.ActionWidgetSize,
      child: Stack(
        children: [
          ProfilePicture(),
          PlusIcon(),
        ],
      ),
    );
  }
}
