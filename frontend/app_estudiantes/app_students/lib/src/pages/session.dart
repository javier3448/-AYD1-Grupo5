import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';

class LeerSesion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: FutureBuilder(
          future: FlutterSession().get('user'),
          builder: (context, snapshot) {
            return Text(snapshot.hasData
                ? snapshot.data['id'].toString() +
                    "|" +
                    snapshot.data['nombre'] +
                    "|" +
                    snapshot.data['apellido'] +
                    "|" +
                    snapshot.data['cui'].toString() +
                    "|" +
                    snapshot.data['carnet'].toString() +
                    "|" +
                    snapshot.data['username'] +
                    "|"
                : 'nada :c');
          }),
    );
  }
}

class GuardarSesion extends StatelessWidget {
  final Usuario datos;
  GuardarSesion(this.datos);
  @override
  Widget build(BuildContext context) {
    return Material(
      child: FutureBuilder(
          future: guardarDatos(context),
          builder: (context, snapshot) {
            return Text("Guardado");
          }),
    );
  }

  Future<void> guardarDatos(context) async {
    await FlutterSession().set('user', this.datos);
  }
}

class Usuario {
  final String id;
  final String nombre;
  final String apellido;
  final String cui;
  final String carnet;
  final String username;
  final String password;
  final int v;

  Usuario(
      {this.id,
      this.nombre,
      this.apellido,
      this.cui,
      this.carnet,
      this.username,
      this.password,
      this.v});

  Usuario.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        nombre = json['nombre'],
        apellido = json['apellido'],
        cui = json['cui'],
        carnet = json['carnet'],
        username = json['username'],
        password = json['password'],
        v = json['v'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["nombre"] = nombre;
    data["apellido"] = apellido;
    data["cui"] = cui;
    data["carnet"] = carnet;
    data["username"] = username;
    data["password"] = password;
    data["v"] = v;
    return data;
  }
}
