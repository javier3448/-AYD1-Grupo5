import 'package:flutter/material.dart';

class Cursos extends StatefulWidget {
  Cursos({Key key}) : super(key: key);

  @override
  _CursosState createState() => _CursosState();
}

class _CursosState extends State<Cursos> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
          child: Text("Mis Cursos actualizar"),
        ),
      ),
    );
  }
}
