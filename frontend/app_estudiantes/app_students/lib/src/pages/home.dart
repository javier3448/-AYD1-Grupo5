import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:app_students/src/pages/session.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter_session/flutter_session.dart';

import '../../main.dart';

class Home_page extends StatefulWidget {
  Home_page({Key key}) : super(key: key);

  _Home_pageState createState() => _Home_pageState();
}

// Solo es el curso que nos da la base de datos y un booleano que nos indica si
// el alumno lo agrego a su 'carrito'
class CursoPorAsignar {
  Curso curso;
  bool isAgregado;

  CursoPorAsignar(Curso curso, bool isAgregado) {
    this.curso = curso;
    this.isAgregado = isAgregado;
  }
}

class _Home_pageState extends State<Home_page> {
  List<CursoPorAsignar> listadoCursos = new List<CursoPorAsignar>();
  List<CursoPorAsignar> listaAuxiliar = new List<CursoPorAsignar>();

  List<Widget> obtenerCursos(List<dynamic> cursosAsignados) {
    //apiCursos();

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

    List<Widget> hijos = new List<Widget>();
    hijos.clear();

    if (cursos.isEmpty) {
      listadoCursos.forEach((element) {
        hijos.add(_BCurso(element));
      });
    } else {
      List<CursoPorAsignar> copiaLista = listadoCursos;
      var ids = [];
      cursos.forEach((element) {
        ids.add(element.id);
      });

      copiaLista.removeWhere((item) => (ids).contains(item.curso.id));

      copiaLista.forEach((element) {
        hijos.add(_BCurso(element));
      });
    }
    return hijos;
  }

// @Mejora: Aqui talvez tendriamos que hacer un query que solo de los cursos a los
// que se puede asignar el alumno o al menos que no retorne los cursos que ya tiene
// asignados
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
      listadoCursos.clear();
      lista.forEach((element) {
        listadoCursos.add(CursoPorAsignar(Curso.fromJson(element), false));
      });
    }
    setState(() {});
  }

  asignarCursos(Curso curso, String carnet) async {
    Map datos = {
      "carne": carnet,
      "cursoid": curso.id,
      "nombre": curso.nombre,
      "codigo": curso.codigo.toString(),
      "seccion": curso.seccion,
      "horainicio": curso.horaInicio,
      "horafinal": curso.horaFinal,
      "catedratico": curso.catedratico,
      "lunes": curso.lunes,
      "martes": curso.martes,
      "miercoles": curso.miercoles,
      "jueves": curso.jueves,
      "viernes": curso.viernes,
      "sabado": curso.sabado,
      "domingo": curso.domingo
    };
    String cuerpo = json.encode(datos);

    http.Response response = await http.put(
      'http://13.58.126.153:4000/assign',
      headers: {'Content-Type': 'application/json'},
      body: cuerpo,
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return true;
    }

    return false;
  }

  asignaciones(String carnet, List<Curso> cursos, Map datos) async {
    bool bandera = false;
    await Future.forEach(listaAuxiliar, (element) async {
      bandera = await asignarCursos(element.curso, carnet);
    });

    if (bandera) {
      Widget okButton = FlatButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.of(context).pop(); // dismiss dialog
        },
      );

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text("Asignación de Estudiante"),
        content: Text("Cursos Seleccionados Asignados!"),
        actions: [
          okButton,
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    } else {
      Widget okButton = FlatButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.of(context).pop(); // dismiss dialog
        },
      );

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text("Asignación de Estudiante"),
        content: Text("No se ha podido asignar cursos!"),
        actions: [
          okButton,
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    listaAuxiliar.forEach((element) {
      cursos.add(element.curso);
    });

    Usuario nuevo = Usuario.fromJson(datos.cast<String, dynamic>(), cursos);
    await FlutterSession().set("user", nuevo);
  }

  Widget _Horas(String hora) {
    return Chip(
      label: Text(hora),
      backgroundColor: Colors.white,
      shape: StadiumBorder(side: BorderSide(width: 1, color: Colors.redAccent)),
    );
  }

  Widget _DiaClase(String dia, String respuesta) {
    if (respuesta == "Y") {
      return Padding(
        padding: const EdgeInsets.all(2),
        child: CircleAvatar(
          radius: 15,
          backgroundColor: Colors.redAccent,
          child: CircleAvatar(
            radius: 14,
            backgroundColor: Colors.blue,
            child: Text(
              dia,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(2.0),
        child: CircleAvatar(
          radius: 15,
          backgroundColor: Colors.redAccent,
          child: CircleAvatar(
            radius: 14,
            backgroundColor: Colors.white,
            child: Text(dia,
                style: TextStyle(
                  color: Colors.black,
                )),
          ),
        ),
      );
    }
  }

  Widget _BCurso(CursoPorAsignar cursoPorAsignar) {
    String codigo = cursoPorAsignar.curso.codigo.toString();
    String nombre = cursoPorAsignar.curso.nombre;
    String seccion = cursoPorAsignar.curso.seccion;
    String catedratico = cursoPorAsignar.curso.catedratico;
    bool isAgregado = cursoPorAsignar.isAgregado;
    String hInicio = cursoPorAsignar.curso.horaInicio;
    String hFinal = cursoPorAsignar.curso.horaFinal;

    return ExpansionTile(
      title: Text(codigo + " - " + nombre),
      leading: Icon(Icons.school_sharp),
      trailing: Icon(Icons.expand_more_rounded),
      children: [
        Column(
          children: [
            Divider(
              height: 15,
              thickness: 3,
              indent: 30,
              endIndent: 30,
            ),
            Text(
              codigo + " - " + nombre,
              textAlign: TextAlign.center,
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
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _DiaClase("L", cursoPorAsignar.curso.lunes),
                  _DiaClase("M", cursoPorAsignar.curso.martes),
                  _DiaClase("Mi", cursoPorAsignar.curso.miercoles),
                  _DiaClase("J", cursoPorAsignar.curso.jueves),
                  _DiaClase("V", cursoPorAsignar.curso.viernes),
                  _DiaClase("S", cursoPorAsignar.curso.sabado),
                  _DiaClase("D", cursoPorAsignar.curso.domingo),
                ],
              ),
            ),
            Divider(
              height: 15,
              thickness: 3,
              indent: 80,
              endIndent: 80,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
// @TODO: que siga mas el estilo de los otros botones
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                  child: ElevatedButton(
                      onPressed: () {
                        debugPrint("Detalles");
                      },
                      child: Text("Detalles")),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                  child: ElevatedButton(
                      onPressed: () {
                        debugPrint("Asignar");
                        setState(() {
                          cursoPorAsignar.isAgregado =
                              !cursoPorAsignar.isAgregado;
                        });

                        if (cursoPorAsignar.isAgregado)
                          listaAuxiliar.add(cursoPorAsignar);
                        else {
                          List<CursoPorAsignar> aux =
                              new List<CursoPorAsignar>();
                          listaAuxiliar.forEach((element) {
                            if (element.curso.id != cursoPorAsignar.curso.id)
                              aux.add(element);
                          });

                          listaAuxiliar = aux;
                        }
                      },
                      child: Text(isAgregado ? "Quitar" : "Agregar")),
                ),
              ],
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
              floatingActionButton: FloatingActionButton(
                  child: Icon(Icons.save),
                  onPressed: () {
                    // Aqui hacemos la asignacion. Creo que el carrito ya no sirviria
                    // de nada entonces. El listview nos debe mostrar si el curso esta
                    // asignado, 'agregado', o ninguno
                    debugPrint("Ir a preview");
                    if (listaAuxiliar.isEmpty) {
                      Widget okButton = FlatButton(
                        child: Text("OK"),
                        onPressed: () {
                          Navigator.of(context).pop(); // dismiss dialog
                        },
                      );

                      // set up the AlertDialog
                      AlertDialog alert = AlertDialog(
                        title: Text("Asignación de Estudiante"),
                        content:
                            Text("No hay cursos seleccionados por asignar!"),
                        actions: [
                          okButton,
                        ],
                      );

                      // show the dialog
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return alert;
                        },
                      );
                    } else {
                      Map llaves = {
                        "_id": snapshot.data['id'],
                        "CUI": snapshot.data['cui'],
                        "carne": snapshot.data['carnet'],
                        "username": snapshot.data['username'],
                        "nombre": snapshot.data['nombre'],
                        "apellido": snapshot.data['apellido'],
                        "password": snapshot.data['password'],
                        "__v": snapshot.data['v']
                      };

                      List<Curso> cursos = new List<Curso>();

                      List<dynamic> lista = snapshot.data['cursosAsignados'];
                      lista.forEach((element) {
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

                      asignaciones(
                          snapshot.data['carnet'].toString(), cursos, llaves);
                    }
                  }),
            );
          }),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    //super.initState();
    listadoCursos.clear();
    listaAuxiliar.clear();
    apiCursos();
    setState(() {});
  }
}
