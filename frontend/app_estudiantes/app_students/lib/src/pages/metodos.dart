import 'package:app_students/src/pages/alert_dialog.dart';
import 'package:app_students/user_modelf.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:app_students/src/pages/session.dart';
import 'package:flutter/material.dart';

const URL_API = 'http://13.58.126.153:4000/';
const HEADERS = {'Content-Type': 'application/json'};

Future<Usuario> ingresoUsuario(String nombre, String pass) async {
  Map datos = {"nombre": nombre, "contrasena": pass};
  String cuerpo = json.encode(datos);

  http.Response response = await http.post(
    URL_API + 'login',
    headers: HEADERS,
    body: cuerpo,
  );

  if (response.statusCode >= 200 && response.statusCode < 300) {
    Map respuesta = json.decode(response.body);
    List<Curso> cursosAsignados = mapeoCurso(respuesta);
    return Usuario.fromJson(respuesta, cursosAsignados);
  }

  return null;
}

List<Curso> mapeoCurso(Map cuerpo) {
  List<Curso> cursosAsignados = new List<Curso>();
  Iterable cursos = cuerpo['cursos'];
  cursos.forEach((element) {
    cursosAsignados.add(Curso(
        id: element['cursoid'],
        nombre: element['nombre'],
        codigo: element['codigo'],
        seccion: element['seccion'],
        horaInicio: element['horainicio'],
        horaFinal: element['horafinal'],
        lunes: element['lunes'],
        martes: element['martes'],
        miercoles: element['miercoles'],
        jueves: element['jueves'],
        viernes: element['viernes'],
        sabado: element['sabado'],
        domingo: element['domingo'],
        catedratico: element['catedratico']));
  });

  return cursosAsignados;
}

Future<bool> registrarUsuario(Map datos) async {
  String body = json.encode(datos);

  http.Response response = await http.post(
    URL_API + 'new',
    headers: HEADERS,
    body: body,
  );

  if (response.statusCode >= 200 && response.statusCode < 300) return true;
  return false;
}

Future<Usuario> actualizarPerfil(Map datos, List<Curso> listado) async {
  String cuerpo = json.encode(datos);

  http.Response response = await http.post(
    URL_API + 'update',
    headers: HEADERS,
    body: cuerpo,
  );

  if (response.statusCode >= 200 && response.statusCode < 300)
    return Usuario.fromJson(datos.cast<String, dynamic>(), listado);
  return null;
}

Future<Usuario> actualizarFotoPerfil(Map datos, Usuario user) async {
  String cuerpo = json.encode(datos);

  http.Response response = await http.put(
    URL_API + 'setImage',
    headers: HEADERS,
    body: cuerpo,
  );

  if (response.statusCode >= 200 && response.statusCode < 300) {
    user.image = response.body.toString();
    return user;
  }
  return null;
}

Future<List> obtenerDatos() async {
  List<int> datos = [];
  http.Response response = await http.get(
    URL_API + 'numeroCursos',
    headers: HEADERS,
  );

  if (response.statusCode == 202) {
    Map respuesta = json.decode(response.body);
    datos.add(respuesta['cursos']);
  }
  await obtenerEstudiantes().then((value) => datos.add(value));

  return datos;
}

Future<int> obtenerEstudiantes() async {
  http.Response response2 = await http.get(
    URL_API + 'numeroEstudiantes',
    headers: HEADERS,
  );

  if (response2.statusCode == 202) {
    Map respuesta = json.decode(response2.body);
    return respuesta['estudiantes'];
  }
  return 0;
}

Future<bool> crearCursoAdmin(Map datos) async {
  String body = json.encode(datos);
  http.Response response = await http.post(
    URL_API + 'newcourse',
    headers: HEADERS,
    body: body,
  );

  if (response.statusCode >= 200 && response.statusCode < 300)
    return true;
  else
    return false;
}

Widget retornarTitulo() {
  return Container(
    child: Text(
      "ESTUDIANTES",
      style: TextStyle(
          color: Colors.white, fontSize: 25.0, fontStyle: FontStyle.italic),
    ),
    alignment: Alignment.center,
    decoration: BoxDecoration(
        shape: BoxShape.rectangle, color: Color.fromRGBO(15, 40, 80, 1)),
    margin: EdgeInsets.all(25.0),
    padding: EdgeInsets.all(40.0),
  );
}

Future<List<Usuario>> apiEstudiantes() async {
  http.Response response = await http.get(
    URL_API + 'getStudents',
    headers: HEADERS,
  );

  if (response.statusCode >= 200 && response.statusCode < 300) {
    Iterable lista = json.decode(response.body);
    //listadoCursos = List<Curso>.from(lista.map((e) => Curso.fromJson(e)));
    List<Usuario> result = [];
    lista.forEach((estudianteApi) {
      result.add(Usuario.fromJson(estudianteApi, []));
    });

    return Future.value(result);
  }
  return Future.error(response.body);
}

Future<ImageProvider<Object>> loadImageEstudiante(String url) {
  if (url == null) {
    return Future.value(AssetImage("assets/defaultProfilePicture.png"));
  } else if (url == "") {
    return Future.value(AssetImage("assets/defaultProfilePicture.png"));
  } else {
    return Future.value(NetworkImage(url));
  }
}

Future<bool> eliminarUsuario(
    String carnet, String nombre, BuildContext context) async {
  //ACA SE MANDA LA PETICION A LA BD
  Map datos = {"carne": carnet};
  String cuerpo = json.encode(datos);

  http.Response response = await http.post(
    URL_API + 'deleteStudent',
    headers: HEADERS,
    body: cuerpo,
  );

  if (response.statusCode >= 200 && response.statusCode < 300) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Alerta(
          mensaje: "Estudiante '" + nombre + "' eliminado!",
          titulo: 'Eliminar Estudiante!',
        ).build(context);
      },
    );
  } else {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Alerta(
                mensaje:
                    "Estudiante '" + nombre + "' no se ha podido eliminar!",
                titulo: 'Eliminar Estudiante!')
            .build(context);
      },
    );
  }
  return true;
}

// @TODO: hacerle una prueba unitaria
Future<List<Curso>> apiCursos() async{
  http.Response response = await http.get(
    URL_API + 'getcourses',
    headers: HEADERS,
  );

  if (response.statusCode >= 200 && response.statusCode < 300) {
    Iterable lista = json.decode(response.body);
    //listadoCursos = List<Curso>.from(lista.map((e) => Curso.fromJson(e)));
    List<Curso> result = [];
    lista.forEach((cursoApi) {
      result.add(Curso.fromJson(cursoApi));
    });

    return Future.value(result);
  }
  return Future.error(response.body);
}