import 'package:app_students/src/pages/login.dart';
import 'package:app_students/src/pages/tabs.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Students App',
      initialRoute: 'login',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Color.fromRGBO(15, 45, 80, 1),
          accentColor: Color.fromRGBO(250, 164, 177, 1)),
      routes: {
        'login': (BuildContext context) => login_page(),
        'tans': (BuildContext context) => tabs_page()
      },
    );
  }
}
