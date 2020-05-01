import 'package:flutter/material.dart';

class SocialIcon extends StatelessWidget {
  final String title;
  final IconData icon;

  const SocialIcon({Key key, this.title, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15.0),
      width: 60.0,
      height: 60.0,
      child: Column(
        children: [
          Icon(icon, size: 40.0, color: Colors.grey[300]),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(title, style: TextStyle(fontSize: 12.0)),
          ),
        ],
      ),
    );
  }
}
