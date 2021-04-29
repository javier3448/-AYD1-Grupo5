import 'package:app_students/src/pages/profile_admin.dart';
import 'package:flutter/material.dart';
import 'package:app_students/src/pages/session.dart';
import 'package:app_students/src/pages/metodos.dart' as Metodos;
import 'admin_create_student.dart';
import 'package:app_students/src/pages/alert_dialog.dart';

class Estudiantes extends StatefulWidget {
  Estudiantes({Key key}) : super(key: key);

  @override
  _EstudiantesState createState() => _EstudiantesState();
}

class _EstudiantesState extends State<Estudiantes> {
  Widget WidgetEstudiante(Usuario estudiante) {
    return ExpansionTile(
      title: Text(estudiante.carnet),
      subtitle: Text(estudiante.nombre + " " + estudiante.apellido),
      leading: FutureBuilder(
        future: Metodos.loadImageEstudiante(estudiante.image),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return avatar(snapshot.data);
          } else if (snapshot.hasError) {
            return ErrorWidget('IMG:\n\n' + snapshot.error.toString());
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
              estudiante.cui,
              style: TextStyle(fontSize: 20.0, color: Colors.white),
            ),
            Divider(height: 20.0),
            ElevatedButton(
                onPressed: () {
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
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return confirmacion(estudiante);
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

  CircleAvatar avatar(var img) {
    return CircleAvatar(
      backgroundImage: img,
      backgroundColor: Color.fromRGBO(15, 40, 80, 1),
    );
  }

  List<Widget> widgetsEstudiantes(List<Usuario> estudiantes) {
    List<Widget> lista = new List<Widget>();
    Widget tituloContainer = Metodos.retornarTitulo();
    lista.add(tituloContainer);

    estudiantes.forEach((estudiante) {
      lista.add(WidgetEstudiante(estudiante));
    });
    return lista;
  }

  AlertDialog confirmacion(Usuario estudiante) {
    Widget okButton = FlatButton(
      child: Text("Sí"),
      onPressed: () {
        Navigator.of(context).pop();
        Metodos.eliminarUsuario(estudiante.carnet, estudiante.nombre)
            .then((value) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return alertaEstudiante(value, estudiante.nombre).build(context);
            },
          );
        });
        setState(() {});
      },
    );

    Widget cancelButton = FlatButton(
      child: Text("Cancelar"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    return AlertDialog(
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
  }

  Alerta alertaEstudiante(bool value, String nombre) {
    return Alerta(
      mensaje: value
          ? "Estudiante '" + nombre + "' eliminado!"
          : "No se ha podido eliminar el estudiante!",
      titulo: 'Eliminar Estudiante!',
    );
  }

  FloatingActionButton floatButton() {
    return FloatingActionButton(
      elevation: 0,
      highlightElevation: 0,
      child: Icon(Icons.person_add),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => admin_student()));
      },
    );
  }

  Scaffold scaffRet(List<Usuario> usuarios) {
    return Scaffold(
      floatingActionButton: floatButton(),
      resizeToAvoidBottomInset: true,
      appBar: null,
      body: Container(
        child: Center(
          child: Container(
            child: ListView(
              children: widgetsEstudiantes(usuarios),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: FutureBuilder(
          future: Metodos.apiEstudiantes(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return scaffRet(snapshot.data);
            } else if (snapshot.hasError) {
              // TODO: poner un 'textTheme' especial o algo asi para que se sepa
              // que hubo error o al menos que este en rojo o algo asi
              return ErrorWidget('Peticion :\n\n' + snapshot.error.toString());
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
