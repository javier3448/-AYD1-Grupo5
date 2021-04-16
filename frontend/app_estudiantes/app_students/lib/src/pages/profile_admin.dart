import 'dart:io' as Io;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:file_picker/file_picker.dart';

import '../../user_modelf.dart';

class Profile_page_admin extends StatefulWidget {
  // const Profile_page({Key key}) : super(key: key);
  //List DatosUsuario;
  Estudiante estudiante;
  Profile_page_admin(this.estudiante) {
    print(estudiante.nombre);
    print(estudiante.CUI);
  }

  @override
  _Profile_page_adminState createState() =>
      _Profile_page_adminState(this.estudiante);
}

class _Profile_page_adminState extends State<Profile_page_admin> {
  Estudiante estudiante;
  _Profile_page_adminState(this.estudiante);
  bool esEditable = false;
  bool seIngresatxt = false;
  var nombreCompleto_Cntrl = TextEditingController();
  var apellido_Ctrl = TextEditingController();
  var cui_Ctrl = TextEditingController();
  var carnet_Ctrl = TextEditingController();
  var usuario_Ctrl = TextEditingController();
  var contrasena_Ctrl = TextEditingController();

  final String nombreCString = '';
  String usuString = '';
  String cuiString = '';
  String carnetString = '';

  String fotostring = '';
  String filePath, img64;
  File file;
  String imagenPerfil =
      "https://upload.wikimedia.org/wikipedia/commons/thumb/1/12/User_icon_2.svg/1200px-User_icon_2.svg.png";

  @override
  void initState() {
    //super.initState();
  }

  Future actualizarPerfil(Map datos) async {
    String cuerpo = json.encode(datos);

    http.Response response = await http.post(
      'http://13.58.126.153:4000/update',
      headers: {'Content-Type': 'application/json'},
      body: cuerpo,
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      // anuncio

      Widget okButton = FlatButton(
        child: Text("OK"),
        onPressed: () {
          setState(() {
            esEditable = false;
            seIngresatxt = false;
          });
          Navigator.of(context).pop(); // dismiss dialog
        },
      );

      AlertDialog alert = AlertDialog(
        title: Text("Editar Perfil"),
        content: Text(
            "Datos para " + datos['nombre'] + " actualizados éxitosamente!"),
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
    } else {
      // anuncio
      Widget okButton = FlatButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.of(context).pop(); // dismiss dialog
        },
      );

      AlertDialog alert = AlertDialog(
        title: Text("Editar Perfil"),
        content: Text("Error al actualizar datos de " + datos['nombre'] + "!"),
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

  Future actualizarFotoPerfil(Map datos, Estudiante user) async {
    String cuerpo = json.encode(datos);

    http.Response response = await http.put(
      'http://13.58.126.153:4000/setImage',
      headers: {'Content-Type': 'application/json'},
      body: cuerpo,
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      Widget okButton = FlatButton(
        child: Text("OK"),
        onPressed: () {
          setState(() {
            esEditable = false;
            seIngresatxt = false;
          });
          Navigator.of(context).pop(); // dismiss dialog
        },
      );

      AlertDialog alert = AlertDialog(
        title: Text("Editar Perfil"),
        content: Text("¡Imagen de perfil de " +
            user.nombre +
            " actualizada exitosamente!"),
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
    } else {
      // anuncio
      Widget okButton = FlatButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.of(context).pop(); // dismiss dialog
        },
      );

      AlertDialog alert = AlertDialog(
        title: Text("Editar Perfil"),
        content: Text("¡Error al actualizar imagen de " + user.nombre + "!"),
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

  void _openFileExplorer(Estudiante usuario) async {
    filePath = await FilePicker.getFilePath(type: FileType.image);
    final bytes = Io.File(filePath).readAsBytesSync();
    img64 = base64Encode(bytes);
    Map datos = {"carne": usuario.carne, "image": img64.toString()};
    actualizarFotoPerfil(datos, usuario);
  }

  Widget textfield(
      {@required String labelText,
      TextEditingController contrl,
      TextInputType tipoDato}) {
    return Material(
      elevation: 4,
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 5.0),
        child: TextField(
          keyboardType: tipoDato,
          controller: contrl,
          decoration: InputDecoration(
              enabled: seIngresatxt,
              labelText: labelText,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelStyle: TextStyle(
                  color: Colors.lightBlue[300], fontWeight: FontWeight.bold),
              //hintText: hintText,
              hintStyle: TextStyle(
                  letterSpacing: 2,
                  color: Colors.indigo[700],
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0),
              fillColor: Colors.white30,
              filled: true,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none)),
        ),
      ),
    );
  }

  Widget textfieldFalse(
      {@required String labelText,
      TextEditingController contrl,
      TextInputType tipoDato}) {
    return Material(
      elevation: 4,
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 5.0),
        child: TextField(
          keyboardType: tipoDato,
          controller: contrl,
          autofocus: false,
          decoration: InputDecoration(
              enabled: false,
              labelText: labelText,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelStyle: TextStyle(
                  color: Colors.lightBlue[300], fontWeight: FontWeight.bold),
              //hintText: hintText,
              hintStyle: TextStyle(
                  letterSpacing: 2,
                  color: Colors.indigo[700],
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0),
              fillColor: Colors.white30,
              filled: true,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            body: SingleChildScrollView(
                child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomPaint(
                      child: SingleChildScrollView(
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              child: Column(children: [
                                Stack(children: [
                                  //crossAxisAlignment: CrossAxisAlignment.center,
                                  Container(
                                    padding: EdgeInsets.all(10.0),
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    height:
                                        MediaQuery.of(context).size.height / 3,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white, width: 5),
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                      image: DecorationImage(
                                          fit: BoxFit.contain,
                                          image: NetworkImage(
                                              estudiante.image == null ||
                                                      estudiante.image == ""
                                                  ? imagenPerfil
                                                  : estudiante.image)),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: 30, left: 140),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.lightBlue[300],
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          _openFileExplorer(estudiante);
                                        },
                                      ),
                                    ),
                                  )
                                ]),
                                Stack(children: [
                                  Container(
                                    height: MediaQuery.of(context)
                                                .size
                                                .height >
                                            650
                                        ? MediaQuery.of(context).size.height /
                                                2 +
                                            120
                                        : MediaQuery.of(context).size.height /
                                            3,
                                    width: double.infinity,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: textfield(
                                            tipoDato: TextInputType.text,
                                            contrl: nombreCompleto_Cntrl.text ==
                                                    ""
                                                ? (nombreCompleto_Cntrl
                                                  ..text = estudiante.nombre)
                                                : nombreCompleto_Cntrl,
                                            labelText: "Nombre",
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: textfield(
                                            tipoDato: TextInputType.text,
                                            contrl: apellido_Ctrl.text == ""
                                                ? (apellido_Ctrl
                                                  ..text = estudiante.apellido)
                                                : apellido_Ctrl,
                                            labelText: "Apellido",
                                            //hintText: snapshot.data['apellido'],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: textfieldFalse(
                                            tipoDato: TextInputType.text,
                                            contrl: cui_Ctrl
                                              ..text = estudiante.CUI,
                                            labelText: "CUI",
                                            //hintText: snapshot.data['password']
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: textfieldFalse(
                                            tipoDato: TextInputType.text,
                                            contrl: carnet_Ctrl
                                              ..text = estudiante.carne,
                                            labelText: "Carné",
                                            //hintText: snapshot.data['password']
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: textfieldFalse(
                                            tipoDato:
                                                TextInputType.emailAddress,
                                            contrl: usuario_Ctrl
                                              ..text = estudiante.username,
                                            labelText: "Correo Electrónico",
                                            //hintText: snapshot.data['password']
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: textfield(
                                            tipoDato: TextInputType.text,
                                            contrl: contrasena_Ctrl.text == ""
                                                ? (contrasena_Ctrl
                                                  ..text = estudiante.password)
                                                : contrasena_Ctrl,
                                            labelText: "Contraseña",
                                            //hintText: snapshot.data['password']
                                          ),
                                        ),
                                        Visibility(
                                            visible: esEditable,
                                            child: Container(
                                              child: Row(
                                                children: [
                                                  OutlineButton(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 40),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                      onPressed: () {
                                                        setState(() {
                                                          nombreCompleto_Cntrl
                                                                  .text =
                                                              estudiante.nombre;
                                                          apellido_Ctrl.text =
                                                              estudiante
                                                                  .apellido;
                                                          contrasena_Ctrl.text =
                                                              estudiante
                                                                  .password;
                                                          usuString = '';
                                                          cuiString = '';
                                                          carnetString = '';
                                                          esEditable = false;
                                                          seIngresatxt = false;
                                                        });
                                                      },
                                                      child: Text("CANCELAR",
                                                          style: TextStyle(
                                                              fontSize: 14.0,
                                                              letterSpacing:
                                                                  2.2,
                                                              color: Colors
                                                                  .black))),
                                                  RaisedButton(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 42),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                      color: Colors
                                                          .lightGreen[600],
                                                      onPressed: () {
                                                        setState(() {
                                                          //nombreCString =  nombreCompleto_Cntrl.text;
                                                          //usuString = usu_Ctrl.text;
                                                          cuiString =
                                                              cui_Ctrl.text;
                                                          carnetString =
                                                              carnet_Ctrl.text;
                                                          print(
                                                              "Aca se enviarian los nuevos datos a la BD :D ");

                                                          Map llaves = {
                                                            "CUI":
                                                                estudiante.CUI,
                                                            "carne": estudiante
                                                                .carne,
                                                            "username":
                                                                estudiante
                                                                    .username,
                                                            "nombre":
                                                                nombreCompleto_Cntrl
                                                                    .text,
                                                            "apellido":
                                                                apellido_Ctrl
                                                                    .text,
                                                            "password":
                                                                contrasena_Ctrl
                                                                    .text
                                                          };

                                                          actualizarPerfil(
                                                              llaves);
                                                        });
                                                      },
                                                      child: Text("GUARDAR",
                                                          style: TextStyle(
                                                              fontSize: 14.0,
                                                              letterSpacing:
                                                                  2.2,
                                                              color: Colors
                                                                  .black)))
                                                ],
                                              ),
                                            ))
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: 13, left: 315),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.lightBlue[300],
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            esEditable = true;
                                            seIngresatxt = true;
                                          });
                                        },
                                      ),
                                    ),
                                  )
                                ])
                              ]))),
                      painter: HeaderCurvedContainer(),
                    ),
                  ],
                )
              ],
            ))));
  }
}

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Color(0xff303f9f);
    Path path = Path()
      ..relativeLineTo(0, 150)
      ..quadraticBezierTo(size.width / 2, 225, size.width, 150)
      ..relativeLineTo(0, -150)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
