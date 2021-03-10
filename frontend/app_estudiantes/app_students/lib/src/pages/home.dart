import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:app_students/src/pages/session.dart';
import 'dart:async';
import 'dart:convert';

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

  List<Widget> obtenerCursos() {
    //apiCursos();

    List<Widget> hijos = new List<Widget>();
    listadoCursos.forEach((element) {
      hijos.add(_BCurso(element));
    });

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
      lista.forEach((element) {
        listadoCursos.add(CursoPorAsignar(Curso.fromJson(element), false));
      });
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
            Text(
              catedratico,
              style: TextStyle(fontSize: 20.0, color: Colors.white),
            ),
            Text(
              "Inicio: " + hInicio + " Final: " + hFinal,
              style: TextStyle(fontSize: 17.0, color: Colors.white),
            ),
            // @TODO: que siga mas el estilo de los otros botones
            ElevatedButton(
                onPressed: () {
                  debugPrint("Detalles");
                },
                child: Text("Detalles")),
            ElevatedButton(
                onPressed: () {
                  debugPrint("Asignar");
                  setState(() {
                    cursoPorAsignar.isAgregado = !cursoPorAsignar.isAgregado;
                  });
                },
                child: Text(isAgregado ? "Quitar" : "Agregar")),
          ],
        )
      ],
      backgroundColor: Color.fromRGBO(15, 45, 80, 1),
      initiallyExpanded: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: null,
      body: Container(
        child: Center(
          child: Container(
            child: ListView(
              children: obtenerCursos(),
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
          }),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    //super.initState();
    listadoCursos.clear();
    apiCursos();
    setState(() {});
  }
}
