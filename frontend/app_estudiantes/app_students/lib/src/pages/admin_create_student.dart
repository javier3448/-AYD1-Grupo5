import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart' as http;

import '../../user_modelf.dart';
import 'metodos.dart' as Metodos;

class admin_student extends StatefulWidget {
  admin_student({Key key}) : super(key: key);

  @override
  _admin_studentState createState() => _admin_studentState();
}

//prueba POST REGISTRO el future lleva un modelo aun se puede manejar. https://flutter.dev/docs/cookbook/networking/send-data
Future<Estudiante> createUser(String nombre, String apellido, String cui,
    String carne, String username, String pass) async {
  Map data = {
    "nombre": nombre,
    "apellido": apellido,
    "CUI": cui,
    "carne": carne,
    "username": username,
    "password": pass
  };

  postRegister() async {
    String body = json.encode(data);

    http.Response response = await http.post(
      'http://13.58.126.153:4000/create',
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    debugPrint(response.body);

    if (response.statusCode == 201) {
      final String responseString = response.body;
      return responseString;
    } else {
      return null;
    }
  }
}

class _admin_studentState extends State<admin_student> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void convertirDatos(nombre, apellido, cui, carne, username, pass) {
    Map data = {
      "nombre": nombre,
      "apellido": apellido,
      "CUI": cui,
      "carne": carne,
      "username": username,
      "password": pass
    };

    Metodos.registrarUsuario(data).then((value) async {
      if (value) {
        _formKey.currentState?.reset();
        Widget okButton = FlatButton(
          child: Text("OK"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        );

        AlertDialog alert = AlertDialog(
          title: Text("Registro Estudiante"),
          content: Text("Registro realizado!"),
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
        Widget okButton = FlatButton(
          child: Text("OK"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        );

        AlertDialog alert = AlertDialog(
          title: Text("Registro Estudiante"),
          content: Text("No se ha podido realizar registro!"),
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
    });
  }

  //Variables
  String _number;
  String _cui;
  String _name;
  String _last;
  String _email;
  String _pass;

  // Widgets
  Widget myTittle() {
    return Text(
      "Registrar Nuevo Estudiante",
      style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 25),
    );
  }

  Widget fieldName() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      child: TextFormField(
        decoration: InputDecoration(
          icon: Icon(
            Icons.accessibility_new,
            color: Theme.of(context).primaryColor,
          ),
          labelText: 'Nombres',
          labelStyle: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.redAccent),
          ),
        ),
        validator: (value) {
          if (value.isEmpty) {
            return "Campo obligatorio.";
          } else {
            return null;
          }
        },
        onSaved: (String value) {
          _name = value;
        },
        maxLength: 50,
      ),
    );
  }

  Widget fieldLastN() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      child: TextFormField(
        decoration: InputDecoration(
          icon: Icon(
            Icons.accessibility_new,
            color: Theme.of(context).primaryColor,
          ),
          labelText: 'Apellidos',
          labelStyle: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.redAccent),
          ),
        ),
        validator: (value) {
          if (value.isEmpty) {
            return "Campo obligatorio.";
          } else {
            return null;
          }
        },
        onSaved: (String value) {
          _last = value;
        },
        maxLength: 50,
      ),
    );
  }

  Widget fieldCUI() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      child: TextFormField(
        keyboardType: TextInputType.number,
        maxLength: 13,
        decoration: InputDecoration(
          icon: Icon(
            Icons.badge,
            color: Theme.of(context).primaryColor,
          ),
          labelText: 'Código Único de Identificación ',
          labelStyle: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.redAccent),
          ),
        ),
        validator: MinLengthValidator(13, errorText: "El CUI  es inválido."),
        onSaved: (String value) {
          _cui = value;
        },
      ),
    );
  }

  Widget fieldNumber() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
        child: TextFormField(
          keyboardType: TextInputType.number,
          maxLength: 9,
          decoration: InputDecoration(
            icon: Icon(
              Icons.account_circle_rounded,
              color: Theme.of(context).primaryColor,
            ),
            labelText: 'Carné',
            labelStyle: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.redAccent),
            ),
          ),
          validator: MinLengthValidator(9, errorText: "El Carné no es válido."),
          onSaved: (String value) {
            _number = value;
          },
        ));
  }

  Widget fieldEmail() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          icon: Icon(
            Icons.alternate_email_rounded,
            color: Theme.of(context).primaryColor,
          ),
          labelText: 'Correo Electrónico',
          labelStyle: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.redAccent),
          ),
        ),
        validator: EmailValidator(errorText: "El correo no es válido."),
        onSaved: (String value) {
          _email = value;
        },
        maxLength: 50,
      ),
    );
  }
  //probando

  Widget fieldPassword() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(
            Icons.admin_panel_settings,
            color: Theme.of(context).primaryColor,
          ),
          labelText: 'Contraseña',
          labelStyle: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.redAccent),
          ),
        ),
        validator:
            MinLengthValidator(8, errorText: "Contraseña demasiado corta."),
        onSaved: (String value) {
          _pass = value;
        },
        maxLength: 15,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Center(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  myTittle(),
                  //*_user == null
                  //    ? Container(
                  //        child: Text("NEL"),
                  //      )
                  //    : Text("El usuario ${_user.carne} fue creado."),
                  fieldNumber(),
                  fieldCUI(),
                  fieldName(),
                  fieldLastN(),
                  fieldEmail(),
                  fieldPassword(),
//Button Register**************************************************************
                  SizedBox(height: 15),
                  RaisedButton(
                    onPressed: () async {
                      if (!_formKey.currentState.validate()) {
                        return;
                      } else {
                        _formKey.currentState.save();
                      }

                      //imprimimos los datos.
                      print(_number);
                      print(_cui);
                      print(_name);
                      print(_email);
                      print(_pass);

                      //metodo el cual lleva a registrar.
                      convertirDatos(
                          _name, _last, _cui, _number, _email, _pass);
/*
                      setState(() {
                        _user = user;
                      });*/

                      // @BUG: despues de crear el usuario nos manda a la pantalla de login
                    },
                    child: Text(
                      "Registrar",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    color: Colors.redAccent,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
