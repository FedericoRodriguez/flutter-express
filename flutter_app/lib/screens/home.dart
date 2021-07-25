import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/screens/UserList.dart';
import 'package:flutter_app/screens/RegisterUser.dart';
import 'package:flutter_app/widgets/text_icon.dart';
import 'package:flutter_app/widgets/text_welcome.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:flutter_app/widgets/icon_account.dart';

class HomePage extends StatefulWidget {
  HomePage() : super();
  static const String ROUTE_ID = '/home_screen';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    /*final wordPair = WordPair.random();
    return Text(wordPair.asPascalCase);*/
    return Scaffold(
      appBar: AppBar(
        title: TextIcon('LoveMeter'),
        centerTitle: true,
        elevation: 4,
        actions: [IconAccount()],
        leading: TextWelcome(),
        leadingWidth:130,
      ),
      body: _buildHome(context),
    );
  }

  Widget _buildHome(context) {
    return FutureBuilder(
        future: FlutterSession().get('authToken'),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != '') {
            //snapshot.connectionState //ConnectionState.done ///ConnectionState.waiting
            print('Home Logged in: , ${snapshot.data}!');
            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                        primary: Colors.blue,
                        backgroundColor: Colors.purple),
                    child: Text(
                      'Add five more User ',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    onPressed: () => _addFiveMoreUsers(context),
                  ),
                ]);
          } else {
            return Text('Please Sign in. Click on the account icon.');
          }
        });
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
/*
  _logoutAccount(context) async {
    FlutterSession().set('authToken', '');
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    await Navigator.pushReplacementNamed(context, LoginPage.ROUTE_ID);
  }
  */
}
