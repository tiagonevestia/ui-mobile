import 'package:flutter/material.dart';

import 'widgets/bottomSection.dart';
import 'widgets/middleSection.dart';
import 'widgets/topSection.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          TopSection(),
          MiddleSection(),
          BottomSection(),
        ],
      ),
    );
  }
}
