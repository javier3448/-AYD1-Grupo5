import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:app_students/src/pages/session.dart';

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

  if (response.statusCode >= 200 && response.statusCode < 300) {
    return true;
  } else {
    return false;
  }
}
