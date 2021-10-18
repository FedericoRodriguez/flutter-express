import 'package:flutter/widgets.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:flutter/material.dart';

class TextWelcome extends StatelessWidget {
  bool named;
  TextWelcome(this.named);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        FutureBuilder(
            future: FlutterSession().get('authToken'),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != '' && this.named) {
                return  Expanded(flex: 1,
                  child: Text('Hi, ${snapshot.data.toString()}',style: TextStyle(fontWeight: FontWeight.bold, color: Colors.greenAccent, fontSize:32,),),
                );
              } else if (snapshot.hasData && snapshot.data != '') {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.favorite,
                      color: Colors.greenAccent,
                      size: 15.0,
                    ),
                    Icon(
                      Icons.favorite,
                      color: Colors.greenAccent,
                      size: 15.0,
                    ),
                    Icon(
                      Icons.favorite,
                      color: Colors.greenAccent,
                      size: 15.0,
                    )
                  ],
                );
              }
              return Text('');

            }),
      ],
    );
    //throw UnimplementedError();
  }
}
