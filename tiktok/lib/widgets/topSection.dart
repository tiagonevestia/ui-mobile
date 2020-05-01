import 'package:flutter/material.dart';

class TopSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      alignment: Alignment(0.0, 1.0),
      padding: EdgeInsets.only(bottom: 17.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text('Following'),
          SizedBox(width: 15.0),
          Text(
            'For you',
            style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
