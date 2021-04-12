import 'package:app_students/src/pages/metodos.dart';
import 'package:app_students/user_model.dart';
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

  UserModel _user;

  @override
  void initState() {
    super.initState();
    //getUser();
  }

  //Variables
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
        _goRegisterPage(context);
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

  Widget buttonGoPrueba(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        _goRegisterPrueba(context);
      },
      child: Text("Iniciar"),
    );
  }

  void _goRegisterPrueba(BuildContext context) {
    Navigator.of(context).pushNamed("controlador");
  }

  void _goRegisterPage(BuildContext context) {
    Navigator.of(context).pushNamed("tans");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).primaryColor,
      appBar: null,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Center(
                child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //buttonGoPrueba(context),
                    imageCenter(),
                    SizedBox(height: 20),
                    myTittle(),
                    _user == null
                        ? Container()
                        : Text("El usuario ${_user.name} fue creado."),
                    fieldNumber(),
                    fieldPassword(),
//BotonIniciar Sesion**********************************************************
                    RaisedButton(
                      onPressed: () async {
                        if (!_formKey.currentState.validate()) {
                          return;
                        } else {
                          _formKey.currentState.save();
                        }

                        //print(_number);
                        String carne = _number;
                        String contra = _pass;
                        //print(_pass);

                        // AQUI ES DONDE DIGO QUE LA MANERA CORRECTA ES CREAR EL OBJETO
                        // Y LOS DATOS DEL RESPONSE LOS TENDIRA user de tipo UserModel
                        //final UserModel user = await createUser(_number, _pass);

                        //entonces ahora el state tiene como valor predefinido el user.
                        /*setState(() {
                          _user = user;
                        });*/
                        if (carne == '202100000' && contra == '123456789')
                          Navigator.of(context).pushNamed("controladorAdmin");
                        else {
                          Metodos()
                              .ingresoUsuario(carne, contra)
                              .then((value) async {
                            if (value != null) {
                              await FlutterSession().set("user", value);
                              _formKey.currentState?.reset();
                              Widget okButton = FlatButton(
                                child: Text("OK"),
                                onPressed: () {
                                  Navigator.of(context).pop(); // dismiss dialog
                                },
                              );

                              AlertDialog alert = AlertDialog(
                                title: Text("Ingreso Estudiante"),
                                content: Text("Bienvenido!"),
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
                              Navigator.of(context).pushNamed("controlador");
                            } else {
                              Widget okButton = FlatButton(
                                child: Text("OK"),
                                onPressed: () {
                                  Navigator.of(context).pop(); // dismiss dialog
                                },
                              );

                              AlertDialog alert = AlertDialog(
                                title: Text("Ingreso Estudiante"),
                                content: Text("Credenciales Incorrectas!"),
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
