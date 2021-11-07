import 'package:flutter/widgets.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app/screens/Login.dart';
import 'package:flutter_app/screens/home.dart';

class IconAccount extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        FutureBuilder(
            future: FlutterSession().get('authToken'),
            builder: (context,snapshot){
              if (snapshot.hasData && snapshot.data != '') {
                return IconButton(
                    onPressed: () {_logoutAccount(context);} ,
                    icon: Icon(Icons.logout,color: Colors.greenAccent,));
              } else {
                return IconButton(
                    onPressed: () {  _gotoLogin(context);} ,
                    icon: Icon(Icons.account_circle_outlined,color: Colors.greenAccent));
              }
            }),
      ],
    );
    //throw UnimplementedError();
  }
  _gotoLogin(context) async {
    await Navigator.pushNamed(context, LoginPage.ROUTE_ID);
  }
  _logoutAccount(context) async {
    FlutterSession().set('authToken', '');
    FlutterSession().set('isAdmin', '');
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    await Navigator.pushReplacementNamed(context, HomePage.ROUTE_ID);
  }
}
