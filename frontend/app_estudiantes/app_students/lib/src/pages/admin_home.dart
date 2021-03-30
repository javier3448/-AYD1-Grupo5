import 'dart:ui';

import 'package:flutter/material.dart';

class Admin_page extends StatefulWidget {
  Admin_page({Key key}) : super(key: key);

  @override
  _Admin_pageState createState() => _Admin_pageState();
}

class _Admin_pageState extends State<Admin_page> {
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

  Widget cantidad(cantidad) {
    return Text(
      cantidad,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: Colors.white, fontSize: 100, fontWeight: FontWeight.bold),
    );
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
              Expanded(flex: 1, child: cantidad("000")),
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
              Expanded(flex: 1, child: cantidad("00")),
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
