import 'package:app_students/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_session/flutter_session.dart';
import 'dart:async';
import 'dart:convert';

class login_page extends StatefulWidget {
  login_page({Key key}) : super(key: key);

  @override
  _login_pageState createState() => _login_pageState();
}

//prueba POST login EN TEORIA ESTA SERIA LA MENERA CORRECTA DE HACER UN POST
// YA QUE SE PUEDEN MANEJAR LAS ESTRUCUTAS COMO TAL Y PODER USAR LOS DATOS DE RESPUESTA.
// ESTE LO HICE CON UNA API DE EJEMPLO
Future<UserModel> createUser(String carne, String contra) async {
  final String myApi = "https://reqres.in/api/users";

  final response = await http.post(myApi, body: {"name": carne, "job": contra});

  if (response.statusCode == 201) {
    final String responseString = response.body;

    //AQUI CONSTRUYO EL OBJETO DE USERMODEL
    return userModelFromJson(responseString);
  } else {
    return null;
  }
}

class Usuario {
  String _id;
  String nombre;
  String apellido;
  String cui;
  String carnet;
  String username;
  String password;
  int __v;

  Usuario(this.cui, this.carnet);

  Usuario.fromJson(Map<String, dynamic> json)
      : _id = json['_id'],
        nombre = json['nombre'],
        apellido = json['apellido'],
        cui = json['cui'],
        carnet = json['carnet'],
        username = json['username'],
        password = json['password'],
        __v = json['__v'];

  Map<String, dynamic> toJson() => {
        '_id': _id,
        'nombre': nombre,
        'apellido': apellido,
        'cui': cui,
        'carnet': carnet,
        'username': username,
        'password': password,
        '__v': __v
      };
}

class _login_pageState extends State<login_page> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //API REST

  //user
  UserModel _user;

  ingresoUsuario(String nombre, String pass) async {
    //ACA SE MANDA LA PETICION A LA BD
    Map datos = {"nombre": nombre, "contrasena": pass};
    String cuerpo = json.encode(datos);

    http.Response response = await http.post(
      'http://13.58.126.153:4000/login',
      headers: {'Content-Type': 'application/json'},
      body: cuerpo,
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      Map respuesta = jsonDecode(response.body);
      var usuarioRes = Usuario.fromJson(respuesta);
      _formKey.currentState?.reset();
      //LO QUE DEVUELVE: EL TOKEN DE SESION -> esto va dentro del if si la petición fue correcta
      print("el token va a ser -> " + usuarioRes._id);
      var sesionActual = FlutterSession();
      await sesionActual.set("token", usuarioRes._id);
      await sesionActual.set("user", nombre);

      //LUEGO PARA RECUPERAR EL TOKEN -> dynamic token = await FlutterSession().get("token");

      // anuncio
      Widget okButton = FlatButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.of(context).pop(); // dismiss dialog
        },
      );

      AlertDialog alert = AlertDialog(
        title: Text("Ingreso Estudiante"),
        content: Text("Bienvenido " + usuarioRes.nombre + "!"),
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

      // ACA SE VA A LA PAG DE BIENVENIDO
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
  }

  //prueba GET
  getUser() async {
    http.Response response =
        await http.get('http://13.58.126.153:4000/api/login');
    debugPrint(response.body);
  }

  @override
  void initState() {
    super.initState();
    getUser();
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

  void _goRegisterPage(BuildContext context) {
    Navigator.of(context).pushNamed("tans");
  }

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
                child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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

                        ingresoUsuario(carne, contra);
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
