import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter/material.dart';

class FeelsIcon extends StatelessWidget {
  FeelsIcon(this.feelState);
  final String feelState;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        feelState == '0'
            ? Icon(
          Icons.delete,
          color: Colors.red,
          size: 54.0,
        )
            : feelState == '25'
            ? Icon(
          Icons.mood_bad,
          color: Colors.amber,
          size: 54.0,
        )
            : feelState == '50'
            ? Icon(
          Icons.tag_faces,
          color: Colors.green,
          size: 54.0,
        )
            : feelState == '75'
            ? Icon(
          Icons.favorite_outline,
          color: Colors.green,
          size: 54.0,
        )
            : feelState == '100'
            ? Icon(
          Icons.favorite,
          color: Colors.red,
          size: 54.0,
        )
            : Icon(
          Icons.hourglass_empty,
          color: Colors.black,
          size: 54.0,
        )
      ],
    );
    //throw UnimplementedError();
  }
}
