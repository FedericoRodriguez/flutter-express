import 'package:flutter/material.dart';
import 'package:flutter_app/theme/style.dart';
import 'package:flutter_app/utils/Routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      showSemanticsDebugger: false,
      title: 'LoveMeter Home',
      theme: appTheme(),
      routes: Routes.routes(),
      initialRoute: Routes.initScreen(),
      //  home: HomePage(), //RandomWords(),
    );
  }
}
