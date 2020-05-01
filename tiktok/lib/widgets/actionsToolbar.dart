import 'package:flutter/material.dart';

import 'followAction.dart';
import 'musicPlayerAction.dart';
import 'socialIcon.dart';

class ActionsToolbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FollowAction(),
          SocialIcon(title: '510.8k', icon: Icons.favorite),
          SocialIcon(title: '188', icon: Icons.message),
          SocialIcon(title: 'Share', icon: Icons.share),
          MusicPlayerAction(),
        ],
      ),
    );
  }
}
