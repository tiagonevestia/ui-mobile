import 'package:flutter/material.dart';

import 'actionsToolbar.dart';
import 'videoDescription.dart';

class MiddleSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          VideoDescription(),
          ActionsToolbar(),
        ],
      ),
    );
  }
}
