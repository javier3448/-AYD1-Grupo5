import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:app_students/src/pages/session.dart';

class Cursos extends StatefulWidget {
  Cursos({Key key}) : super(key: key);

  @override
  _CursosState createState() => _CursosState();
}

class _CursosState extends State<Cursos> {
  Widget MiCurso(codigo, nombre, seccion, hInicio, hFinal) {
    return ExpansionTile(
      title: Text(nombre),
      subtitle: Text("Inicia: " + hInicio + "  -  Finaliza: " + hFinal),
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

  Widget retornarTitulo() {
    return Container(
      child: Text(
        "MIS CURSOS",
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

  List<Widget> obtenerCursos(List<dynamic> cursosAsignados) {
    List<Widget> lista = new List<Widget>();
    Widget tituloContainer = retornarTitulo();
    lista.add(tituloContainer);

    List<Curso> cursos = new List<Curso>();
    cursosAsignados.forEach((element) {
      cursos.add(Curso(
          id: element['id'],
          nombre: element['nombre'],
          codigo: element['codigo'],
          seccion: element['seccion'],
          horaInicio: element['horaInicio'],
          horaFinal: element['horaFinal'],
          lunes: element['lunes'],
          martes: element['martes'],
          miercoles: element['miercoles'],
          jueves: element['jueves'],
          viernes: element['viernes'],
          sabado: element['sabado'],
          domingo: element['domingo'],
          catedratico: element['catedratico']));
    });

    cursos.forEach((element) {
      lista.add(MiCurso(element.codigo.toString(), element.nombre,
          element.seccion, element.horaInicio, element.horaFinal));
    });
    return lista;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: FutureBuilder(
          future: FlutterSession().get('user'),
          builder: (context, snapshot) {
            return Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: null,
              body: Container(
                child: Center(
                  child: Container(
                    child: ListView(
                      children: obtenerCursos(snapshot.data['cursosAsignados']),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
