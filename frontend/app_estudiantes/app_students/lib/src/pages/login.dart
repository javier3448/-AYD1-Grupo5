import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class login_page extends StatefulWidget {
  login_page({Key key}) : super(key: key);

  @override
  _login_pageState createState() => _login_pageState();
}

class _login_pageState extends State<login_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: null,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  imageCenter(),
                  SizedBox(height: 20),
                  myTittle(),
                  fieldNumber(),
                  fieldPassword(),
                  buttonLogin2(),
                ],
              ),
            ),
            Center(
              child: buttonGoRegister(context),
            )
          ],
        ),
      ),
    );
  }
}

Widget myTittle() {
  return Text(
    "Iniciar Sesion",
    style: TextStyle(color: Colors.white, fontSize: 25),
  );
}

Widget buttonLogin() {
  return FlatButton(
    onPressed: () {},
    child: Text(
      "Ingresar",
      style: TextStyle(color: Colors.white, fontSize: 18),
    ),
    color: Colors.redAccent,
    minWidth: 200,
    height: 45,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  );
}

Widget buttonLogin2() {
  return RaisedButton(
    onPressed: () {},
    child: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Ingresar",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        Icon(
          Icons.arrow_forward_ios_sharp,
          color: Colors.white,
        ),
      ],
    ),
    color: Colors.redAccent,
    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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

Widget fieldPassword() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
    child: TextField(
      obscureText: true,
      maxLength: 10,
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

Widget imageCenter() {
  return Container(
    height: 125,
    //https://www.usac.edu.gt/g/escudo10.png
    child: Image.network("https://www.usac.edu.gt/g/escudo10.png"),
  );
}

Widget buttonGoRegister(BuildContext context) {
  return FlatButton(
    onPressed: () {
      _goRegisterPage(context);
    },
    child: Text(
      "Regístrate Ahora",
      style: TextStyle(color: Colors.white, fontSize: 15, shadows: [
        Shadow(offset: Offset(8.0, 8.0), blurRadius: 10.0, color: Colors.black)
      ]),
    ),
  );
}

void _goRegisterPage(BuildContext context) {
  Navigator.of(context).pushNamed("tans");
}
