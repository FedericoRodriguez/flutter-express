import 'package:flutter/widgets.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:flutter/material.dart';

class TextWelcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        FutureBuilder(
            future: FlutterSession().get('authToken'),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != '') {
                return  Expanded(flex: 1,
                  child: Text('Hi, ${snapshot.data.toString()}'),
                );
              }
              return Text('');
            }),
      ],
    );
    //throw UnimplementedError();
  }
}
