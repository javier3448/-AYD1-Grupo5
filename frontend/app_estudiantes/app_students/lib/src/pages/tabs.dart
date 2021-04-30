import 'package:app_students/src/pages/metodos.dart' as Metodos;
import 'package:flutter/material.dart';
import 'package:app_students/src/pages/alert_dialog.dart';
import 'package:form_field_validator/form_field_validator.dart';

class tabs_page extends StatefulWidget {
  tabs_page({Key key}) : super(key: key);

  @override
  _tabs_pageState createState() => _tabs_pageState();
}

class _tabs_pageState extends State<tabs_page> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _number;
  String _cui;
  String _name;
  String _last;
  String _email;
  String _pass;

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
        key: new Key('name-field'),
        decoration: InputDecoration(
          icon: Icon(
            Icons.accessibility_new,
            color: Colors.white,
          ),
          labelText: 'Nombres',
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

  Widget fieldLastN() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      child: TextFormField(
        key: new Key('last-field'),
        decoration: InputDecoration(
          icon: Icon(
            Icons.accessibility_new,
            color: Colors.white,
          ),
          labelText: 'Apellidos',
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
        key: new Key('cui-field'),
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
          key: new Key('carnet-field'),
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
        key: new Key('email-field'),
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
        key: new Key('pass-field'),
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

  void reg() {
    Map data = {
      "nombre": _name,
      "apellido": _last,
      "CUI": _cui,
      "carne": _number,
      "username": _email,
      "password": _pass
    };

    Metodos.registrarUsuario(data).then((value) async {
      if (value) _formKey.currentState?.reset();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertaTabs(value).build(context);
        },
      );
    });
  }

  Alerta alertaTabs(bool value) {
    return Alerta(
        titulo: "Registro Estudiante",
        mensaje: value
            ? "Registro Realizado!"
            : "No se ha podido realizar registro!",
        nav: value ? "login" : "");
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
                  fieldNumber(),
                  fieldCUI(),
                  fieldName(),
                  fieldLastN(),
                  fieldEmail(),
                  fieldPassword(),
                  SizedBox(height: 15),
                  RaisedButton(
                    key: new Key('register-btn'),
                    onPressed: () async {
                      if (!_formKey.currentState.validate()) {
                        return;
                      } else {
                        _formKey.currentState.save();
                      }

                      reg();
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
