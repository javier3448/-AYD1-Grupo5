import 'dart:io';
import 'package:app_students/user_modelf.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class tabs_page extends StatefulWidget {
  tabs_page({Key key}) : super(key: key);

  @override
  _tabs_pageState createState() => _tabs_pageState();
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

class _tabs_pageState extends State<tabs_page> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //INGRESE ESTE METODO PARA PODER MANEJAR EL FORMULARIO, SI SE ENCUENTRA OTRA
  //MANERA DE NO HACERLO TAN FEO xd estaria mejor
  //lo que faltaria para login seria manejar la SESION DE USUARIO
  // Y SI FUERA UN GET MEJOR BASARSE EN LO QUE ESTA EN LOGIN Y NO LO DE ACA YA QUE LO VEO
  // DE UNA MANERA MAS CORRECTA EL COMO MANEJA LOS DATOS.
  void convertirDatos(nombre, apellido, cui, carne, username, pass) {
    Map data = {
      "nombre": nombre,
      "apellido": apellido,
      "CUI": cui,
      "carne": carne,
      "username": username,
      "password": pass
    };
    print("aqui");

    postRegister() async {
      String body = json.encode(data);

      http.Response response = await http.post(
        'http://13.58.126.153:4000/new',
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      debugPrint(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        //SI ES CORRECTO QUE BORRE EL FORM
        _processData();
      } else {
        print("ninguna alerta");
        // set up the button
        Widget okButton = FlatButton(
          child: Text("OK"),
          onPressed: () {
            Navigator.of(context).pop(); // dismiss dialog
          },
        );

        // set up the AlertDialog
        AlertDialog alert = AlertDialog(
          title: Text("Registro Estudiante"),
          content: Text("No se ha podido realizar registro!"),
          actions: [
            okButton,
          ],
        );

        // show the dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          },
        );
      }
    }

    postRegister();
  }

  //REINICIA EL FORMULARIO Y MUESTRA EL MENSAJE
  void _processData() {
    _formKey.currentState?.reset();
    registroRealizado(context);
  }

  //CON ESTE MUESTRO EL ALERTDIALOG DE QUE SE REGISTRO.... Faltaria otro si el registro no se realiza.
  void registroRealizado(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop(); // dismiss dialog
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Registro Estudiante"),
      content: Text("Registro realizado!"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  //UserModelF _user;

  //Variables
  String _number;
  String _cui;
  String _name;
  String _email;
  String _pass;

  // Widgets
  Widget myTittle() {
    return Text(
      "Registro Estudiante",
      style: TextStyle(color: Colors.white, fontSize: 25),
    );
  }

  Widget fieldName() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      child: TextFormField(
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

  Widget fieldCUI() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      child: TextFormField(
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
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(
          "Registro Estudiante",
        ),
      ),
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
                          _name, "last", _cui, _number, _email, _pass);
/*
                      setState(() {
                        _user = user;
                      });*/
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
