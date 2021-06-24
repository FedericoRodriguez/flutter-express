import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:flutter_app/screens/ViewUser.dart';

import 'dart:convert';

class UserListPage extends StatefulWidget {
  UserListPage() : super();

  static const String ROUTE_ID = '/user_list_screen';

  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  Map<String, dynamic> data = {};
  List userData = [];
  String _emailSelected ='';


  getUsers() async {
    http.Response response =
        await http.get(Uri.http('10.0.2.2:4000', '/api/users'));
    data = jsonDecode(response.body);
    setState(() {
      userData = data['users'];
    });
    // print('Howdy, ${data['users']}!');
    //debugPrint(response.body);
  }
  void getOneUser(index)  {
    String _email = userData[index]["email"];
    Future<http.Response> response =
    http.get(Uri.parse('http://10.0.2.2:4000/api/users?email=${_email}'));
    response.then((value) => {
      print('Get user  account...'),
      data = jsonDecode(value.body),
      if (data['status'] == "200")
        {
          print('Dataaaaaa, ${data['data']['email']}!'),
          print('Backend message, ${data['message']}!'),
           Navigator.pushNamed(context, ViewUserPage.ROUTE_ID, arguments: {'userSelected': data['data']}),
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
    getUsers();
  }
  _viewUser(context, index) async {
    getOneUser(index);
  }

  _deleteUser(context, index) async {
    debugPrint("Remove User Index: " + index.toString());
    String _email = userData[index]["email"];
    Future<http.Response> response =
        http.delete(Uri.http("10.0.2.2:4000", "/api/users/delete"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              'email': _email,
            }));
    response.then((value) => {
          print('delete user...'),
          if (value.statusCode == 404)
            {
              print('Error Backend NOT Found'),
            }
          else
            {
              if (value.statusCode == 200)
                {
                  data = jsonDecode(value.body),
                  if (data['status'] == "200")
                    {
                      print('Backend message, ${data['message']}!'),
                      //Navigator.pushNamed(context, '/')
                      getUsers(),
                    }
                  else if (data['status'] == "500")
                    {print('Backend message Error: , ${data['message']}!')}
                  else
                    {print('Other Backend message Error')}
                }
              else
                {print('Other Backend message Error')}
            }
        });
    response.catchError((onError) => {
          print('Servers Down!'),
        });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users List'),
      ),
      body: ListView.builder(
        itemCount: userData == null ? 0 : userData.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text("$index | ${userData[index]["email"]}"),
                ),
                IconButton(
                  icon: new Icon(Icons.person),
                  highlightColor: Colors.pink,
                  color: Colors.purple,
                  onPressed: () {
                    _viewUser(context, index);
                  },
                ),
                IconButton(
                  icon: new Icon(Icons.delete_forever),
                  highlightColor: Colors.pink,
                  color: Colors.purple,
                  onPressed: () {
                    _deleteUser(context, index);
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
