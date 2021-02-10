import 'package:flutter/material.dart';

class tabs_page extends StatefulWidget {
  tabs_page({Key key}) : super(key: key);

  @override
  _tabs_pageState createState() => _tabs_pageState();
}

class _tabs_pageState extends State<tabs_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(
          "Universidad2",
        ),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              myTittle(),
              fieldNumber(),
              fieldName(),
              fieldLastName(),
              fieldEmail(),
              fieldPassword(),
              SizedBox(height: 15),
              buttonRegister()
            ],
          ),
        ),
      ),
    );
  }
}

Widget myTittle() {
  return Text(
    "Registro Estudiante",
    style: TextStyle(color: Colors.white, fontSize: 25),
  );
}

Widget buttonRegister() {
  return FlatButton(
    onPressed: () {},
    child: Text(
      "Registrar",
      style: TextStyle(color: Colors.white, fontSize: 18),
    ),
    color: Colors.redAccent,
    minWidth: 200,
    height: 45,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  );
}

Widget fieldName() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
    child: TextField(
      decoration: InputDecoration(
          hintText: "Nombre", fillColor: Colors.white, filled: true),
    ),
  );
}

Widget fieldLastName() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
    child: TextField(
      decoration: InputDecoration(
          hintText: "Apellido", fillColor: Colors.white, filled: true),
    ),
  );
}

Widget fieldNumber() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
    child: TextField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          hintText: "Carné", fillColor: Colors.white, filled: true),
    ),
  );
}

Widget fieldEmail() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
    child: TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          hintText: "Correo Institucional",
          fillColor: Colors.white,
          filled: true),
    ),
  );
}

Widget fieldPassword() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
    child: TextField(
      obscureText: true,
      decoration: InputDecoration(
          hintText: "Contraseña", fillColor: Colors.white, filled: true),
    ),
  );
}
