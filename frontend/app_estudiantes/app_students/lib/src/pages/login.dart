import 'package:app_students/src/pages/metodos.dart' as Metodos;
import 'package:app_students/src/pages/alert_dialog.dart';
import 'package:app_students/src/pages/session.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter_session/flutter_session.dart';

class login_page extends StatefulWidget {
  login_page({Key key}) : super(key: key);

  @override
  loginpageState createState() => loginpageState();
}

class loginpageState extends State<login_page> {
  loginpageState();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  String _number;
  String _pass;

  Widget myTittle() {
    return Text(
      "Iniciar Sesion",
      style: TextStyle(color: Colors.white, fontSize: 25),
    );
  }

  Widget fieldNumber() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
        child: TextFormField(
          key: new Key('carnet-field'),
          inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
          validator: MinLengthValidator(9, errorText: "Carné Invalido."),
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
          onSaved: (String value) {
            _number = value;
          },
        ));
  }

  Widget fieldPassword() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      child: TextFormField(
        key: new Key('pass-field'),
        obscureText: true,
        maxLength: 15,
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
        Navigator.of(context).pushNamed("tans");
      },
      child: Text(
        "Regístrate Ahora",
        style: TextStyle(color: Colors.white, fontSize: 15, shadows: [
          Shadow(
              offset: Offset(8.0, 8.0), blurRadius: 10.0, color: Colors.black)
        ]),
      ),
    );
  }

  Alerta alertaLogin(Usuario value) {
    return Alerta(
        titulo: "Ingreso Estudiante",
        mensaje: value == null
            ? "Credenciales Incorrectas!"
            : "Bienvenido/a " + value.nombre + "!",
        nav: value != null ? "controlador" : "");
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).primaryColor,
      appBar: null,
      body: new Container(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            new Center(
                child: new Form(
              key: _formKey,
              child: new SingleChildScrollView(
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    imageCenter(),
                    SizedBox(height: 20),
                    myTittle(),
                    fieldNumber(),
                    fieldPassword(),
                    RaisedButton(
                      onPressed: () async {
                        if (!_formKey.currentState.validate()) {
                          return;
                        } else {
                          _formKey.currentState.save();
                        }
                        String carne = _number;
                        String contra = _pass;
                        if (carne == '202100000' && contra == '123456789')
                          Navigator.of(context).pushNamed("controladorAdmin");
                        else {
                          Metodos.ingresoUsuario(carne, contra)
                              .then((value) async {
                            if (value != null) {
                              await FlutterSession().set("user", value);
                              _formKey.currentState?.reset();
                            }
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return alertaLogin(value).build(context);
                              },
                            );
                          });
                        }
                      },
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
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ],
                ),
              ),
            )),
            Center(
              child: buttonGoRegister(context),
            )
          ],
        ),
      ),
    );
  }
}
