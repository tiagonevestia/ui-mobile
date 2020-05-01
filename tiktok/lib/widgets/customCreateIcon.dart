import 'package:flutter/material.dart';
import 'package:tiktok/utils/general.dart';

class CustomCreateIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.0,
      height: 30.0,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(left: 10.0),
            width: Sizes.CreateButtonWidth,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 250, 45, 108),
              borderRadius: BorderRadius.circular(7.0),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 10.0),
            width: Sizes.CreateButtonWidth,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 32, 211, 234),
              borderRadius: BorderRadius.circular(7.0),
            ),
          ),
          Center(
            child: Container(
              height: double.infinity,
              width: Sizes.CreateButtonWidth,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(7.0),
              ),
              child: Icon(Icons.add, size: 20.0),
            ),
          ),
        ],
      ),
    );
  }
}
