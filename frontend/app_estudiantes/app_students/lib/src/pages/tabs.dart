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
          "Registro Estudiante",
        ),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              myTittle(),
              fieldNumber(),
              fieldCUI(),
              fieldName(),
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
  return RaisedButton(
    onPressed: () {},
    child: Text(
      "Registrar",
      style: TextStyle(color: Colors.white, fontSize: 20),
    ),
    color: Colors.redAccent,
    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  );
}

Widget fieldName() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
    child: TextField(
      decoration: InputDecoration(
        icon: Icon(
          Icons.accessibility_new,
          color: Colors.white,
        ),
        labelText: 'Nombre Completo',
        labelStyle: TextStyle(
          color: Color(0xFF6200EE),
        ),
        fillColor: Colors.white,
        filled: true,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.redAccent),
        ),
      ),
    ),
  );
}

Widget fieldCUI() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
    child: TextField(
      keyboardType: TextInputType.number,
      maxLength: 13,
      decoration: InputDecoration(
        icon: Icon(
          Icons.badge,
          color: Colors.white,
        ),
        labelText: 'Código Único de Identificación ',
        labelStyle: TextStyle(
          color: Color(0xFF6200EE),
        ),
        fillColor: Colors.white,
        filled: true,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.redAccent),
        ),
      ),
    ),
  );
}

Widget fieldNumber() {
  return Container(
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      child: TextField(
        keyboardType: TextInputType.number,
        maxLength: 9,
        decoration: InputDecoration(
          icon: Icon(
            Icons.account_circle_rounded,
            color: Colors.white,
          ),
          labelText: 'Carné',
          labelStyle: TextStyle(
            color: Color(0xFF6200EE),
          ),
          fillColor: Colors.white,
          filled: true,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.redAccent),
          ),
        ),
      ));
}

Widget fieldEmail() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
    child: TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        icon: Icon(
          Icons.alternate_email_rounded,
          color: Colors.white,
        ),
        labelText: 'Correo Electrónico',
        labelStyle: TextStyle(
          color: Color(0xFF6200EE),
        ),
        fillColor: Colors.white,
        filled: true,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.redAccent),
        ),
      ),
    ),
  );
}

Widget fieldPassword() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
    child: TextField(
      obscureText: true,
      decoration: InputDecoration(
        icon: Icon(
          Icons.admin_panel_settings,
          color: Colors.white,
        ),
        labelText: 'Contraseña',
        labelStyle: TextStyle(
          color: Color(0xFF6200EE),
        ),
        fillColor: Colors.white,
        filled: true,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.redAccent),
        ),
      ),
    ),
  );
}
