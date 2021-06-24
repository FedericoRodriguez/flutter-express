import 'package:flutter/widgets.dart';

import 'package:flutter/material.dart';

class TextIcon extends StatelessWidget {
  TextIcon(this.text);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(text),
        Icon(
          Icons.favorite,
          color: Colors.red,
          size: 28.0,
        )
      ],
    );
    //throw UnimplementedError();
  }
}
