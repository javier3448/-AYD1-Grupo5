import 'package:app_students/src/pages/session.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:app_students/src/pages/login.dart';

class Profile_page extends StatelessWidget {
  // const Profile_page({Key key}) : super(key: key);
  //List DatosUsuario;
  var DatosUsuario;

  @override
  void initState() {
    //super.initState();
    //getUser();
  }

  Widget textfield({@required String hintText, String labelText}) {
    return Material(
      elevation: 4,
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 5.0),
        child: TextField(
          decoration: InputDecoration(
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
            body: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 450,
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: textfield(
                                labelText: "Nombre Completo",
                                hintText: snapshot.data['nombre'] +
                                    " " +
                                    snapshot.data['apellido']),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: textfield(
                                labelText: "Nombre de Usuario",
                                hintText: snapshot.data['username']),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: textfield(
                                labelText: "CUI",
                                hintText: snapshot.data['cui'].toString()),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: textfield(
                                labelText: "Carnet",
                                hintText: snapshot.data['carnet'].toString()),
                          ),
                          Row(
                            children: [
                              OutlineButton(
                                  padding: EdgeInsets.symmetric(horizontal: 40),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  onPressed: () {},
                                  child: Text("CANCELAR",
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          letterSpacing: 2.2,
                                          color: Colors.black))),
                              RaisedButton(
                                  padding: EdgeInsets.symmetric(horizontal: 42),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  color: Colors.lightGreen[600],
                                  onPressed: () {},
                                  child: Text("GUARDAR",
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          letterSpacing: 2.2,
                                          color: Colors.black)))
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
                CustomPaint(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                  ),
                  painter: HeaderCurvedContainer(),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
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
                    Container(
                      padding: EdgeInsets.all(10.0),
                      width: MediaQuery.of(context).size.width / 2,
                      height: MediaQuery.of(context).size.width / 2,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 5),
                        shape: BoxShape.circle,
                        color: Colors.white,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('lib/src/pages/perfil.jpg'),
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 270, left: 184),
                  child: CircleAvatar(
                    backgroundColor: Colors.indigo[600],
                    child: IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                  ),
                )
              ],
            ),
          );
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
