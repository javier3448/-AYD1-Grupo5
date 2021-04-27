import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:app_students/src/pages/alert_dialog.dart';
import 'metodos.dart' as Metodos;

class admin_student extends StatefulWidget {
  admin_student({Key key}) : super(key: key);

  @override
  _admin_studentState createState() => _admin_studentState();
}

class _admin_studentState extends State<admin_student> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _number;
  String _cui;
  String _name;
  String _last;
  String _email;
  String _pass;

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

  void agregarEstudiante() {
    Map data = {
      "nombre": _name,
      "apellido": _last,
      "CUI": _cui,
      "carne": _number,
      "username": _email,
      "password": _pass
    };

    Metodos.registrarUsuario(data).then((value) async {
      if (value) {
        _formKey.currentState?.reset();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Alerta(
                    titulo: "Registro Estudiante",
                    mensaje: "Registro Realizado!",
                    nav: "login")
                .build(context);
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Alerta(
              titulo: "Registro Estudiante",
              mensaje: "No se ha podido realizar registro!",
            ).build(context);
          },
        );
      }
    });
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
                  fieldNumber(),
                  fieldCUI(),
                  fieldName(),
                  fieldLastN(),
                  fieldEmail(),
                  fieldPassword(),
                  SizedBox(height: 15),
                  RaisedButton(
                    onPressed: () async {
                      if (!_formKey.currentState.validate()) {
                        return;
                      } else {
                        _formKey.currentState.save();
                      }
                      agregarEstudiante();
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
