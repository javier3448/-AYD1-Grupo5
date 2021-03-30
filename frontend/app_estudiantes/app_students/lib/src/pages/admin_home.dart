import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Admin_page extends StatefulWidget {
  Admin_page({Key key}) : super(key: key);

  @override
  _Admin_pageState createState() => _Admin_pageState();
}

class _Admin_pageState extends State<Admin_page> {
  int cantidadCursos = 0;
  int cantidadEstudiantes = 0;

  var imgE = Image.network(
    "https://i.ibb.co/12x67R8/estudiantes.png",
    height: 150.0,
  );
  var imgL = Image.network(
    "https://i.ibb.co/3FwR6fM/libro.png",
    height: 150.0,
  );
  var imgQ = Image.network(
    "https://i.ibb.co/GQgYp7M/libro-abierto.png",
    height: 150.0,
  );

  Future obtenerDatos() async {
    http.Response response = await http.get(
      'http://13.58.126.153:4000/numeroCursos',
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 202) {
      Map respuesta = json.decode(response.body);
      cantidadCursos = respuesta['cursos'];
    }

    http.Response response2 = await http.get(
      'http://13.58.126.153:4000/numeroEstudiantes',
      headers: {'Content-Type': 'application/json'},
    );

    if (response2.statusCode == 202) {
      Map respuesta = json.decode(response2.body);
      cantidadEstudiantes = respuesta['estudiantes'];
    }
    setState(() {});
  }

  Widget cantidad(cantidad) {
    return Text(
      cantidad,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: Colors.white, fontSize: 100, fontWeight: FontWeight.bold),
    );
  }

  @override
  void initState() {
    //super.initState();
    obtenerDatos();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueAccent,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Dashboard",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 35.0,
                  fontWeight: FontWeight.w400,
                  decoration: TextDecoration.none),
            ),
          ),
          Divider(
            height: 3,
            thickness: 2,
            indent: 75,
            endIndent: 75,
          ),
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      imgE,
                      Text(
                        "Estudiantes Registrados",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.none),
                      )
                    ],
                  )),
              Expanded(
                  flex: 1, child: cantidad(cantidadEstudiantes.toString())),
            ],
          ),
          Divider(
            height: 50,
            thickness: 5,
            indent: 25,
            endIndent: 25,
          ),
          Row(
            children: [
              Expanded(flex: 1, child: cantidad(cantidadCursos.toString())),
              Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      imgL,
                      Text(
                        "Cursos Existentes",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.none),
                      )
                    ],
                  ))
            ],
          )
        ],
      ),
    );
  }
}
