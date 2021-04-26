import 'package:app_students/src/pages/add_curse.dart';
import 'package:flutter/material.dart';
import 'package:app_students/src/pages/metodos.dart' as Metodos;
import 'package:app_students/src/pages/session.dart';

class Delete_page extends StatefulWidget {
  Delete_page({Key key}) : super(key: key);

  @override
  _Delete_pageState createState() => _Delete_pageState();
}

class _Delete_pageState extends State<Delete_page> {

  Widget MiCursoAdmin(String codigo, String nombre, String seccion, String hInicio, String hFinal) {
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
        "CURSOS",
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

  List<Widget> obtenerWidgetsCursos(List<Curso> cursos) {
    List<Widget> lista = new List<Widget>();
    lista.add(retornarTitulo());

    cursos.forEach((element) {
      lista.add(MiCursoAdmin(element.codigo.toString(), element.nombre,
          element.seccion, element.horaInicio, element.horaFinal));
    });

    return lista;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Metodos.apiCursos(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              floatingActionButton: FloatingActionButton(
                elevation: 0,
                highlightElevation: 0,
                child: Icon(Icons.my_library_add),
                onPressed: () {
                  debugPrint("agregar curso");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => add_curse()));
                },
              ),
              resizeToAvoidBottomInset: true,
              appBar: null,
              body: Container(
                child: Center(
                  child: Container(
                    child: ListView(
                      children: obtenerWidgetsCursos(snapshot.data),
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
        }
      );
  }
}
