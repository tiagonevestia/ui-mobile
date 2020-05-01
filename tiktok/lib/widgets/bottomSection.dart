import 'package:flutter/material.dart';
import 'package:tiktok/utils/general.dart';

import 'customCreateIcon.dart';

class BottomSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            Icons.home,
            size: Sizes.NavigationIconSize,
            color: Colors.white,
          ),
          Icon(
            Icons.search,
            size: Sizes.NavigationIconSize,
            color: Colors.white,
          ),
          CustomCreateIcon(),
          Icon(
            Icons.message,
            size: Sizes.NavigationIconSize,
            color: Colors.white,
          ),
          Icon(
            Icons.person_outline,
            size: Sizes.NavigationIconSize,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
