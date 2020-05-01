import 'package:flutter/material.dart';
import 'package:tiktok/utils/general.dart';

class PlusIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: ((Sizes.ActionWidgetSize / 2) - (Sizes.PlusIconSize / 2)),
      child: Container(
        height: Sizes.PlusIconSize,
        width: Sizes.PlusIconSize,
        decoration: BoxDecoration(
          color: Color(0xFFFF2B54),
          borderRadius: BorderRadius.circular(Sizes.PlusIconSize),
        ),
        child: Icon(Icons.add, color: Colors.white, size: 16.0),
      ),
    );
  }
}
