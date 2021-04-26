import 'package:app_students/src/pages/controlador.dart';
import 'package:app_students/src/pages/login.dart';
import 'package:app_students/src/pages/tabs.dart';
import 'package:app_students/src/pages/cursos.dart';
import 'package:app_students/src/pages/adminTabs.dart';
import 'package:app_students/src/pages/estudiantes.dart';
import 'package:app_students/src/pages/cursosAdmin.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Students App',
      initialRoute: 'cursosAdmin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Color.fromRGBO(15, 45, 80, 1),
          accentColor: Colors.redAccent),
      routes: {
        'login': (BuildContext context) => login_page(),
        'tans': (BuildContext context) => tabs_page(),
        'controlador': (BuildContext context) => Controller_page(),
        'cursitos': (BuildContext context) => Cursos(),
        'controladorAdmin': (BuildContext context) => Admin_Tabs(),
        'cursosAdmin': (BuildContext context) => CursosAdmin(),
        'estudiantes': (BuildContext context) => Estudiantes()
      },
    );
  }
}
