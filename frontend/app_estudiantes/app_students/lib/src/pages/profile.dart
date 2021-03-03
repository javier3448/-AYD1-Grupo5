import 'package:app_students/src/pages/session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:app_students/src/pages/login.dart';

class Profile_page extends StatefulWidget {
  // const Profile_page({Key key}) : super(key: key);
  //List DatosUsuario;
  @override
  _Profile_pageState createState() => _Profile_pageState();
}

class _Profile_pageState extends State<Profile_page> {
  var DatosUsuario;
  bool esEditable = false;
  bool seIngresatxt = false;
  final nombreCompleto_Cntrl = TextEditingController();
  final usu_Ctrl = TextEditingController();
  final cui_Ctrl = TextEditingController();
  final carnet_Ctrl = TextEditingController();

  String nombreCString = '';
  String usuString = '';
  String cuiString = '';
  String carnetString = '';

  @override
  void initState() {
    //super.initState();
    //getUser();
  }

  Widget textfield(
      {@required String hintText,
      String labelText,
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
              enabled: seIngresatxt,
              labelText: labelText,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelStyle: TextStyle(
                  color: Colors.lightBlue[300], fontWeight: FontWeight.bold),
              hintText: hintText,
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
      child: FutureBuilder(
        future: FlutterSession().get('user'),
        builder: (context, snapshot) {
          // -------- SCAFFOLD
          return Scaffold(
              body: SingleChildScrollView(
                  child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomPaint(
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: Column(children: [
                          Padding(
                            padding: EdgeInsets.all(20),
                            child: Text(
                              "Perfil",
                              style: TextStyle(
                                  fontSize: 35,
                                  letterSpacing: 1.5,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Stack(children: [
                            //crossAxisAlignment: CrossAxisAlignment.center,
                            Container(
                              padding: EdgeInsets.all(10.0),
                              width: MediaQuery.of(context).size.width / 2,
                              height: MediaQuery.of(context).size.height / 4,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 5),
                                shape: BoxShape.circle,
                                color: Colors.white,
                                image: DecorationImage(
                                    fit: BoxFit.contain,
                                    image: NetworkImage(
                                        "https://upload.wikimedia.org/wikipedia/commons/thumb/1/12/User_icon_2.svg/1200px-User_icon_2.svg.png")),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 30, left: 140),
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
                          ]),
                          Container(
                            height: 450,
                            width: double.infinity,
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: textfield(
                                      tipoDato: TextInputType.text,
                                      contrl: nombreCompleto_Cntrl,
                                      labelText: "Nombre Completo",
                                      hintText: snapshot.data['nombre'] +
                                          " " +
                                          snapshot.data['apellido']),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: textfield(
                                    tipoDato: TextInputType.text,
                                    contrl: usu_Ctrl,
                                    labelText: "Nombre de Usuario",
                                    hintText: snapshot.data['username'],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: textfield(
                                      tipoDato: TextInputType.number,
                                      contrl: cui_Ctrl,
                                      labelText: "CUI",
                                      hintText:
                                          snapshot.data['cui'].toString()),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: textfield(
                                      tipoDato: TextInputType.number,
                                      contrl: carnet_Ctrl,
                                      labelText: "Carnet",
                                      hintText:
                                          snapshot.data['carnet'].toString()),
                                ),
                                Visibility(
                                    visible: esEditable,
                                    child: Container(
                                      child: Row(
                                        children: [
                                          OutlineButton(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 40),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              onPressed: () {
                                                setState(() {
                                                  nombreCString = '';
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
                                                      letterSpacing: 2.2,
                                                      color: Colors.black))),
                                          RaisedButton(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 42),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              color: Colors.lightGreen[600],
                                              onPressed: () {
                                                setState(() {
                                                  nombreCString =
                                                      nombreCompleto_Cntrl.text;
                                                  usuString = usu_Ctrl.text;
                                                  cuiString = cui_Ctrl.text;
                                                  carnetString =
                                                      carnet_Ctrl.text;
                                                  print(
                                                      "Aca se enviarian los nuevos datos a la BD :D ");

                                                  //Se tendria que validar el guardado de datos en la BD
                                                  Widget okButton = FlatButton(
                                                    child: Text("OK"),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop(); // dismiss dialog
                                                    },
                                                  );

                                                  AlertDialog alert =
                                                      AlertDialog(
                                                    title: Text(
                                                        "Edición de Perfil"),
                                                    content: Text(
                                                        "¡Se guardaron correctamente los datos!"),
                                                    actions: [
                                                      okButton,
                                                    ],
                                                  );
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return alert;
                                                    },
                                                  );
                                                });
                                              },
                                              child: Text("GUARDAR",
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      letterSpacing: 2.2,
                                                      color: Colors.black)))
                                        ],
                                      ),
                                    ))
                              ],
                            ),
                          )
                        ])),
                    painter: HeaderCurvedContainer(),
                  ),
                ],
              )
            ],
          )));
        },
      ),
    );
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
