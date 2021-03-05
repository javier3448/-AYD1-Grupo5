import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:app_students/src/pages/session.dart';
import 'dart:async';
import 'dart:convert';

class Home_page extends StatefulWidget {
  Home_page({Key key}) : super(key: key);

  _Home_pageState createState() => _Home_pageState();
}

class _Home_pageState extends State<Home_page> {
  List<Curso> listadoCursos = new List<Curso>();

  List<Widget> obtenerCursos() {
    //apiCursos();

    List<Widget> hijos = new List<Widget>();
    listadoCursos.forEach((element) {
      hijos.add(_BCurso(
          element.nombre,
          element.codigo.toString(),
          element.seccion,
          element.horaInicio,
          element.horaFinal,
          element.catedratico));
    });

    return hijos;
  }

  apiCursos() async {
    /*Iterable lista = json.decode(
        "[{\"_id\": \"603f27a2285e9b10c446ce4b\",\"nombre\": \"Analisis y diseño 1\",\"codigo\": 774,\"seccion\": \"A-\",\"horainicio\": \"7:00\",\"horafinal\": \"8:50\",\"catedratico\": \"Ivonne Aldana\",\"lunes\": \"N\",\"martes\": \"Y\",\"miercoles\": \"N\",\"jueves\": \"Y\",\"viernes\": \"N\",\"sabado\": \"N\",\"domingo\": \"N\",\"__v\": 0},{\"_id\": \"603feb20f881a22258af8d81\",\"nombre\": \"Analisis y diseño 2\",\"codigo\": 775,\"seccion\": \"A-\",\"horainicio\": \"7:00\",\"horafinal\": \"8:50\",\"catedratico\": \"Ivonne Aldana\",\"lunes\": \"N\",\"martes\": \"Y\",\"miercoles\": \"N\",\"jueves\": \"Y\",\"viernes\": \"N\",\"sabado\": \"N\",\"domingo\": \"N\",\"__v\": 0}]");
    listadoCursos = List<Curso>.from(lista.map((e) => Curso.fromJson(e)));*/
    http.Response response = await http.get(
      'http://13.58.126.153:4000/getcourses',
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      Iterable lista = json.decode(response.body);
      //listadoCursos = List<Curso>.from(lista.map((e) => Curso.fromJson(e)));
      lista.forEach((element) {
        listadoCursos.add(Curso.fromJson(element));
      });
    }
  }

  Widget _BCurso(
      String textTitle, codigo, seccion, hInicio, hFinal, catedratico) {
    return ExpansionTile(
      title: Text(codigo + " - " + textTitle),
      leading: Icon(Icons.school_sharp),
      trailing: Icon(Icons.expand_more_rounded),
      children: [
        Column(
          children: [
            Text(
              codigo + " - " + textTitle,
              style: TextStyle(
                  fontSize: 23.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              "Seccion: " + seccion,
              style: TextStyle(fontSize: 20.0, color: Colors.white),
            ),
            Text(
              catedratico,
              style: TextStyle(fontSize: 20.0, color: Colors.white),
            ),
            Text(
              "Inicio: " + hInicio + " Final: " + hFinal,
              style: TextStyle(fontSize: 17.0, color: Colors.white),
            ),
          ],
        )
      ],
      backgroundColor: Color.fromRGBO(15, 45, 80, 1),
      initiallyExpanded: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
          child: ListView(
            children: obtenerCursos(),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    //super.initState();
    listadoCursos.clear();
    apiCursos();
    setState(() {});
  }
}
