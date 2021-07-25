import 'package:flutter_app/screens/UserList.dart';
import 'package:flutter_app/screens/home.dart';
import 'package:flutter_app/screens/RegisterUser.dart';
import 'package:flutter_app/screens/Login.dart';
import 'package:flutter_app/screens/ViewUser.dart';

class Routes {
  static routes() {
    return {
     // '/': (context) => HomePage(),
      HomePage.ROUTE_ID: (context) => HomePage(),
      LoginPage.ROUTE_ID: (context) =>LoginPage(),
      UserListPage.ROUTE_ID: (context) => UserListPage(),
      RegisterUserPage.ROUTE_ID: (context) => RegisterUserPage(),
      ViewUserPage.ROUTE_ID: (context) => ViewUserPage(),
    };
  }

  static initScreen() {
    return '/';
  }
}
