import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:interview/data/user.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Avatar extends StatelessWidget {
  final User user;
  const Avatar({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    try {
      if (user.avatar == null) {
        return CircleAvatar(
          child: Icon(FontAwesomeIcons.image),
        );
      }

      return CircleAvatar(
        backgroundImage: NetworkImage(user.avatar!),
      );
    } catch (e) {
      log(e.toString());
      return CircleAvatar(
        child: Icon(Icons.image),
      );
    }
  }
}
