import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class LoginPage extends StatefulWidget {
  LoginPage() : super();

  static const String ROUTE_ID = '/login_user_screen';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Map<String, dynamic> data = {};
  List userData = [];

  String _email = '';
  String _password = '';
  bool _errorFromBackend = false;
  final _formKey = GlobalKey<FormState>();

  void loginUser() {
    Future<http.Response> response =
        http.post(Uri.http("10.0.2.2:4000", "/api/users/login"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              'email': _email,
              'password': _password,
            }));
    response.then((value) => {
          print('Login account...'),
          data = jsonDecode(value.body),
          if (data['status'] == "200")
            {
              this._errorFromBackend = false,
              print('Dataaaaaa, ${data['data']}!'),
              print('Backend message, ${data['message']}!'),
            }
          else if (data['status'] == "500")
            {print('Backend message Error: , ${data['message']}!')}
          else if (data['status'] == "401")
            {
              print('Backend message Error: , ${data['message']}!'),
              this._errorFromBackend = true,
              _formKey.currentState!.validate(),
            }
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
          title: Text('Login'),
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
                  if (_errorFromBackend) {
                    return 'Invalid Email';
                  }
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
                  if (_errorFromBackend) {
                    return 'Invalid Password';
                  }
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
                    loginUser();
                  },
                  child: Text('Submit'),
                ),
              ),
            ],
          ),
        ));
  }
}
