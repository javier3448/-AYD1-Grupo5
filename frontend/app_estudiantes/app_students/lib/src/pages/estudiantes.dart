import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_session/flutter_session.dart';
import 'package:app_students/src/pages/session.dart';

import '../../user_modelf.dart';

class Estudiantes extends StatefulWidget {
  Estudiantes({Key key}) : super(key: key);

  @override
  _EstudiantesState createState() => _EstudiantesState();
}

class _EstudiantesState extends State<Estudiantes> {
  Widget WidgetEstudiante(Estudiante estudiante) {
    return ExpansionTile(
      title: Text(estudiante.carne),
      subtitle: Text(estudiante.nombre + " " + estudiante.apellido),
      leading: CircleAvatar(
        child: Text("img"),
        backgroundColor: Color.fromRGBO(15, 40, 80, 1),
      ),
      trailing: Icon(Icons.expand_more_rounded),
      children: [
        Column(
          children: [
            Text(
              // @TODO:
              estudiante.username,
              style: TextStyle(
                  fontSize: 23.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              estudiante.CUI,
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

  List<Widget> widgetsEstudiantes(List<Estudiante> estudiantes) {
    List<Widget> lista = new List<Widget>();
    Widget tituloContainer = retornarTitulo();
    lista.add(tituloContainer);

    estudiantes.forEach((estudiante) {
      lista.add(WidgetEstudiante(estudiante));
    });
    return lista;
  }

  Future<List<Estudiante>> apiEstudiantes() async {
    http.Response response = await http.get(
      'http://13.58.126.153:4000/getStudents',
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      Iterable lista = json.decode(response.body);
      //listadoCursos = List<Curso>.from(lista.map((e) => Curso.fromJson(e)));
      List<Estudiante> result = [];
      lista.forEach((estudianteApi) {
        result.add(Estudiante.fromJson(estudianteApi));
      });

      return Future.value(result);
    }
    else{
      // TODO: No se si esta es una manera correcta de manejar el error usando un 
      // Future
      return Future.error(response.body);

      // @Debug
      // Estudiantes dummy solo para probar la pantalla
      // {
      //   List<Estudiante> result = [];
      //   for (var i = 0; i < 10; i++) {
      //     Estudiante dummy = Estudiante(
      //       nombre: "Javier" + i.toString(),
      //       apellido: "Alvarez" + i.toString(),
      //       CUI: "123456789012" + i.toString(),
      //       carne: "200012345" + i.toString(),
      //       username: "javier@gmail.com" + i.toString(),
      //       password: "12345678" + i.toString()
      //     );
      //     result.add(dummy);
      //   }
      //   return Future.value(result);
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: FutureBuilder(
          future: apiEstudiantes(),
          builder: (context, snapshot) {

            if(snapshot.hasData){
              return Scaffold(
                resizeToAvoidBottomInset: true,
                appBar: null,
                body: Container(
                  child: Center(
                    child: Container(
                      child: ListView(
                        children: widgetsEstudiantes(snapshot.data),
                      ),
                    ),
                  ),
                ),
              );
            }
            else if(snapshot.hasError){
              // TODO: poner un 'textTheme' especial o algo asi para que se sepa
              // que hubo error o al menos que este en rojo o algo asi
              return ErrorWidget('Error al hacer la peticion:\n\n' + snapshot.error.toString());
            }
            else{ //todavia estamos esperando al future
            // TODO: poner una animacion o algo asi para que se vea que esta cargando
              return Text(
                '\n\nCargando...',
                style: Theme.of(context).textTheme.headline2
              );
            }

          }),
    );
  }
}
