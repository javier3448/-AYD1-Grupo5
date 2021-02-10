import 'package:app_students/src/pages/tabs.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Students App',
      initialRoute: 'tab',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Color.fromRGBO(15, 45, 80, 1),
          accentColor: Color.fromRGBO(250, 164, 177, 1)),
      routes: {'tab': (BuildContext context) => tabs_page()},
    );
  }
}
