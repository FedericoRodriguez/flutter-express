import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/screens/UserList.dart';
import 'package:flutter_app/screens/RegisterUser.dart';
import 'package:flutter_app/widgets/text_icon.dart';
import 'package:flutter_app/widgets/text_welcome.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:flutter_app/widgets/icon_account.dart';
import 'package:flutter_app/screens/RealationSlider.dart';

class HomePage extends StatefulWidget {
  HomePage() : super();
  static const String ROUTE_ID = '/home_screen';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  late Future userLoggedIn;
  late Future isAdmin;
  Map<String, dynamic> data = {};


  @override
  void initState() {
    super.initState();
    userLoggedIn = _getUserToken();
    isAdmin = _getIsAdmin();
  }


  _getUserToken() async{
    return FlutterSession().get('authToken');
  }

  _getIsAdmin() async{
  return  FlutterSession().get('isAdmin');
  }

  void _onItemTapped(int index) {

    isAdmin.then((res){
      if(res != null && res == true){
        setState(() {
          _selectedIndex = index;
          //routing
          index == 1
              ? _createAccount(context)
              : index == 2
              ? _goToUsersList(context)
              : false;
        });
      } else {
        setState(() {
          _selectedIndex = index;
          //routing
          index == 1
              ? _goToUsersList(context)
              :false;
        });
      }
    });



  }

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
        leading: TextWelcome(false),
        leadingWidth: 130,
      ),
      body: _buildHome(context),
      bottomNavigationBar: FutureBuilder(
          future: Future.wait([userLoggedIn,isAdmin]),
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }
            var token = snapshot.data![0];
            var admin = snapshot.data![1];

            if (token != null && admin == true) {
              return BottomNavigationBar(
                  items: const <BottomNavigationBarItem>[

                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Home',
                    ),

                    BottomNavigationBarItem(
                      icon: Icon(Icons.add),
                      label: 'User',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.view_list_outlined),
                      label: 'Users',
                    ),

                  ],
                  currentIndex: _selectedIndex,
                  selectedItemColor: Colors.greenAccent,
                  unselectedItemColor: Colors.greenAccent,
                  onTap: _onItemTapped,
                  backgroundColor: Colors.purple);
            } else if(token != null  && admin != true) {
              return BottomNavigationBar(
                  items: const <BottomNavigationBarItem>[

                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.view_list_outlined),
                      label: 'Users',
                    ),

                  ],
                  currentIndex: _selectedIndex,
                  selectedItemColor: Colors.greenAccent,
                  unselectedItemColor: Colors.greenAccent,
                  onTap: _onItemTapped,
                  backgroundColor: Colors.purple);
            }
            return Text('');
          }),
    );
  }

  Widget _buildHome(context) {
    return FutureBuilder(
        future: Future.wait([userLoggedIn,isAdmin]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          var token = snapshot.data![0];
          var admin = snapshot.data![1];
          print('TOKEN: , ${token}!');
          print('ADMIN: , ${admin}!');
          if (token != null && admin == true) {
            //snapshot.connectionState //ConnectionState.done ///ConnectionState.waiting
            print('Home Logged in: , ${snapshot.data}!');
            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextWelcome(true),
                  SizedBox(height: 100),
                  RelationSlider(),
                  TextButton(
                    style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20),
                        padding: const EdgeInsets.all(16.0),
                        primary: Colors.greenAccent,
                        backgroundColor: Colors.purple),
                    child: Text(
                      'Add five more User ',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    onPressed: () => _addFiveMoreUsers(context),
                  ),
                ]);
          } else if(token != null && admin != true) {
            //snapshot.connectionState //ConnectionState.done ///ConnectionState.waiting
            print('Home Logged in: , ${snapshot.data}!');
            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextWelcome(true),
                  SizedBox(height: 100),
                  RelationSlider(),
                ]);
          } else {
            return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 120),
                  Text('Please Sign in. Click on the account icon.')
                ]);
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
