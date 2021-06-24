import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'dart:convert';

class ViewUserPage extends StatefulWidget {
  ViewUserPage() : super();

  static const String ROUTE_ID = '/view_user_screen';

  @override
  _ViewUserPageState createState() => _ViewUserPageState();
}

class _ViewUserPageState extends State<ViewUserPage> {

  List userData = [];
  String _emailSelected ='';



  @override
  initState() {
    super.initState();
  }


  Widget build(BuildContext context) {
    final data = (ModalRoute.of(context)!.settings.arguments as Map)['userSelected'];

    return Scaffold(
      appBar: AppBar(
        title: Text('View Users'),
      ),
      body: Text('Your are in teh View User Detail of:  ${data['email']} !!'),
    );
  }
}
