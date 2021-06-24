import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class RegisterUserPage extends StatefulWidget {
  RegisterUserPage() : super();

  static const String ROUTE_ID = '/register_user_screen';

  @override
  _RegisterUserPageState createState() => _RegisterUserPageState();
}

class _RegisterUserPageState extends State<RegisterUserPage> {
  Map<String, dynamic> data = {};
  List userData = [];

  String _email ='';
  String _password = '';
  final _formKey = GlobalKey<FormState>();

  void createUser() {
      Future<http.Response> response =
        http.post(Uri.http("10.0.2.2:4000","/api/users/create"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              'email': _email,
              'password': _password,
            }));
    response.then((value) => {
          print('create account...'),
          data = jsonDecode(value.body),
          if (data['status'] == "200")
            {
              print('Backend message, ${data['message']}!'),
              Navigator.pushNamed(context, '/')
            }
          else if (data['status'] == "500")
            {print('Backend message Error: , ${data['message']}!')}
        });
    response.catchError((onError) => {print('Servers Down!')});

    // print('Howdy, ${data['users']}!');
    // debugPrint(response);
  }

  @override
  initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Crete Account'),
        ),
        body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle:
                        TextStyle(color: Colors.black.withOpacity(0.6))),
                onSaved: (String? value) {
                  _email = value.toString();
                },
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the email';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Pasword',
                    labelStyle:
                        TextStyle(color: Colors.black.withOpacity(0.6))),
                onSaved: (String? value) {
                  _password = value.toString();
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the password';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }

                    _formKey.currentState!.save();
                    createUser();
                  },
                  child: Text('Submit'),
                ),
              ),
            ],
          ),
        ));
  }
}
