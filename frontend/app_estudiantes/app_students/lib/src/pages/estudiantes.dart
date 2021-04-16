import 'dart:convert';

import 'package:app_students/src/pages/profile_admin.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_session/flutter_session.dart';
import 'package:app_students/src/pages/session.dart';

import '../../user_modelf.dart';
import 'admin_create_student.dart';

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
      leading: FutureBuilder(
        future: loadImageEstudiante(estudiante.image),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return CircleAvatar(
              backgroundImage: snapshot.data,
              backgroundColor: Color.fromRGBO(15, 40, 80, 1),
            );
          } else if (snapshot.hasError) {
            return ErrorWidget(
                'Error al obtener imagen:\n\n' + snapshot.error.toString());
          } else {
            // TODO: poner una animacion o algo asi para que se vea que esta cargando
            // BUG: Estos tres puntos se deberian de ver mientras se carga la imagen
            // pero no se ven
            return Text('...');
          }
        },
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
            Divider(height: 20.0),
            ElevatedButton(
                onPressed: () {
                  debugPrint("Editar");
                  Navigator.of(context)
                      .push(MaterialPageRoute(
                          builder: (context) => Profile_page_admin(estudiante)))
                      .whenComplete(() {
                    setState(() {});
                  });
                },
                child: Text("Editar")),
            ElevatedButton(
                onPressed: () {
                  debugPrint("Eliminar");
                  Widget okButton = FlatButton(
                    child: Text("Sí"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      eliminarUsuario(estudiante.carne, estudiante.nombre);
                    },
                  );

                  Widget cancelButton = FlatButton(
                    child: Text("Cancelar"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  );

                  AlertDialog alert = AlertDialog(
                    title: Text("Eliminar Estudiante"),
                    content: Text("¿Desea eliminar a " +
                        estudiante.nombre +
                        " " +
                        estudiante.apellido +
                        "?"),
                    actions: [
                      cancelButton,
                      okButton,
                    ],
                  );
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return alert;
                    },
                  );
                },
                child: Text("Eliminar")),
          ],
        )
      ],
      backgroundColor: Color.fromRGBO(15, 40, 80, 1),
      initiallyExpanded: false,
    );
  }

  Future eliminarUsuario(String carnet, String nombre) async {
    //ACA SE MANDA LA PETICION A LA BD
    Map datos = {"carne": carnet};
    String cuerpo = json.encode(datos);

    http.Response response = await http.post(
      'http://13.58.126.153:4000/deleteStudent',
      headers: {'Content-Type': 'application/json'},
      body: cuerpo,
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      Widget okButton = FlatButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.of(context).pop(); // dismiss dialog
        },
      );

      AlertDialog alert = AlertDialog(
        title: Text("Eliminar Estudiante"),
        content: Text("Estudiante '" + nombre + "' eliminado!"),
        actions: [
          okButton,
        ],
      );
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );

      setState(() {});
    } else {
      Widget okButton = FlatButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.of(context).pop(); // dismiss dialog
        },
      );

      AlertDialog alert = AlertDialog(
        title: Text("Eliminar Estudiante"),
        content: Text("Estudiante '" + nombre + "' no se ha podido eliminar!"),
        actions: [
          okButton,
        ],
      );

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
  }

  Future<ImageProvider<Object>> loadImageEstudiante(String url) {
    if (url == null) {
      return Future.value(AssetImage("assets/defaultProfilePicture.png"));
    }
    // @chapuz: porque el nuevo usuario que registre tiene una image "" por default,
    // no una null
    else if (url == "") {
      return Future.value(AssetImage("assets/defaultProfilePicture.png"));
    } else {
      return Future.value(NetworkImage(url));
    }
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
    } else {
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
            if (snapshot.hasData) {
              return Scaffold(
                floatingActionButton: FloatingActionButton(
                  elevation: 0,
                  highlightElevation: 0,
                  child: Icon(Icons.person_add),
                  onPressed: () {
                    debugPrint("agregar estudiante");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                admin_student()));
                  },
                ),
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
            } else if (snapshot.hasError) {
              // TODO: poner un 'textTheme' especial o algo asi para que se sepa
              // que hubo error o al menos que este en rojo o algo asi
              return ErrorWidget('Error al hacer la peticion:\n\n' +
                  snapshot.error.toString());
            } else {
              //todavia estamos esperando al future
              return Center(
                child: CircularProgressIndicator(
                  strokeWidth: 8,
                ),
              );
            }
          }),
    );
  }
}
