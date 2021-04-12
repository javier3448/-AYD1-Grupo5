import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:app_students/src/pages/session.dart';

class Metodos {
  Future<Usuario> ingresoUsuario(String nombre, String pass) async {
    Map datos = {"nombre": nombre, "contrasena": pass};
    String cuerpo = json.encode(datos);

    http.Response response = await http.post(
      'http://13.58.126.153:4000/login',
      headers: {'Content-Type': 'application/json'},
      body: cuerpo,
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      Map respuesta = json.decode(response.body);
      List<Curso> cursosAsignados = new List<Curso>();
      Iterable cursos = respuesta['cursos'];
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
      return Usuario.fromJson(respuesta, cursosAsignados);
    }

    return null;
  }
}
