import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/screens/UserList.dart';
import 'package:flutter_app/screens/RegisterUser.dart';
import 'package:flutter_app/screens/Login.dart';
import 'package:flutter_app/widgets/text_icon.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    /*final wordPair = WordPair.random();
    return Text(wordPair.asPascalCase);*/
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,

      ),
      home: Scaffold(
        appBar: AppBar(
          title: TextIcon('LoveMeter'),
          centerTitle: true,
        ),
        body: _buildHome(context),
      ),
    );
  }

  Widget _buildHome(context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text('TESTING'),
      const SizedBox(height: 30),
      const SizedBox(height: 30),
      TextButton(
        style: TextButton.styleFrom(
            textStyle: const TextStyle(fontSize: 20),
            padding: const EdgeInsets.all(16.0),
            primary: Colors.green,
            backgroundColor: Colors.purple),
        child: Text(
          'User List',
          style: TextStyle(fontSize: 20.0),
        ),
        onPressed: () => _goToUsersList(context),
      ),
      const SizedBox(height: 30),
      TextButton(
        style: TextButton.styleFrom(
            textStyle: const TextStyle(fontSize: 20),
            padding: const EdgeInsets.all(16.0),
            primary: Colors.black,
            backgroundColor: Colors.purple),
        child: Text(
          'Create Account ',
          style: TextStyle(fontSize: 20.0),
        ),
        onPressed: () => _createAccount(context),
      ),
      const SizedBox(height: 30),
      TextButton(
        style: TextButton.styleFrom(
            textStyle: const TextStyle(fontSize: 20),
            padding: const EdgeInsets.all(16.0),
            primary: Colors.red,
            backgroundColor: Colors.purple),
        child: const Text(
          'Login',
          style: TextStyle(fontSize: 20.0),
        ),
        onPressed: () => _loginAccount(context),
      ),
      const SizedBox(height: 30),
      TextButton(
        style: TextButton.styleFrom(
            textStyle: const TextStyle(fontSize: 20),
            padding: const EdgeInsets.all(16.0),
            primary: Colors.blue,
            backgroundColor: Colors.purple),
        child: Text(
          'Add five more User ',
          style: TextStyle(fontSize: 20.0),
        ),
        onPressed: () => _addFiveMoreUsers(context),
      )
    ]);
  }

  _goToUsersList(context) async {
    await Navigator.pushNamed(context, UserListPage.ROUTE_ID);
  }

  _addFiveMoreUsers(context) async {
    http.Response response =
        await http.get(Uri.http('10.0.2.2:4000', '/api/users/fake_create'));
    return response;
  }

  _createAccount(context) async {
    await Navigator.pushNamed(context, RegisterUserPage.ROUTE_ID);
  }

  _loginAccount(context) async {
    await Navigator.pushNamed(context, LoginPage.ROUTE_ID);
  }
}
