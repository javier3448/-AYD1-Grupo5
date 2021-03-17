import 'package:flutter/material.dart';

class Cursos extends StatefulWidget {
  Cursos({Key key}) : super(key: key);

  @override
  _CursosState createState() => _CursosState();
}

class _CursosState extends State<Cursos> {
  Widget MiCurso(codigo, nombre, seccion, hInicio, hFinal) {
    return ExpansionTile(
      title: Text(nombre),
      subtitle: Text("Inicia: " + hInicio + "  -  Finaliza:" + hFinal),
      leading: CircleAvatar(
        child: Text(codigo),
        backgroundColor: Color.fromRGBO(15, 40, 80, 1),
      ),
      trailing: Icon(Icons.expand_more_rounded),
      children: [
        Column(
          children: [
            Text(
              codigo + " - " + nombre,
              style: TextStyle(
                  fontSize: 23.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              "Seccion: " + seccion,
              style: TextStyle(fontSize: 20.0, color: Colors.white),
            ),
            Divider(height: 20.0)
          ],
        )
      ],
      backgroundColor: Color.fromRGBO(15, 40, 80, 1),
      initiallyExpanded: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: null,
      body: Container(
        child: Center(
          child: Container(
            child: ListView(
              children: [
                Container(
                  child: Text(
                    "MIS CURSOS",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                        fontStyle: FontStyle.italic),
                  ),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Color.fromRGBO(15, 40, 80, 1)),
                  margin: EdgeInsets.all(25.0),
                  padding: EdgeInsets.all(40.0),
                ),
                MiCurso("275", "Progra 1", "A-", "12:00", "1:40"),
                MiCurso("275", "Progra 1", "A-", "12:00", "1:40"),
                MiCurso("275", "Progra 1", "A-", "12:00", "1:40"),
                MiCurso("275", "Progra 1", "A-", "12:00", "1:40"),
                MiCurso("275", "Progra 1", "A-", "12:00", "1:40"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
