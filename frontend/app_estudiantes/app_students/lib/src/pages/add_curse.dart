import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class add_curse extends StatefulWidget {
  add_curse({Key key}) : super(key: key);

  @override
  _add_curseState createState() => _add_curseState();
}

class _add_curseState extends State<add_curse> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //Variables
  String _codigo;
  String _nombre;
  String _profesor;
  String _seccion;
  String _horaI;
  String _horaF;

  //DIAS
  var _Lunes = false;
  var _Martes = false;
  var _Miercoles = false;
  var _Jueves = false;
  var _Viernes = false;
  var _Sabado = false;
  var _Domingo = false;

  // Widgets
  Widget myTittle() {
    return Text(
      "Crear nuevo curso",
      style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 25),
    );
  }

  Widget mySub() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Text(
        "Seleccione los dias que se impartira el curso:",
        style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 15),
      ),
    );
  }

  Widget fieldCode() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      child: TextFormField(
        keyboardType: TextInputType.number,
        maxLength: 4,
        decoration: InputDecoration(
          icon: Icon(
            Icons.account_box,
            color: Theme.of(context).primaryColor,
          ),
          labelText: 'Código de curso',
          labelStyle: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.redAccent),
          ),
        ),
        onSaved: (String value) {
          _codigo = value;
        },
      ),
    );
  }

  Widget fieldName() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      child: TextFormField(
        decoration: InputDecoration(
          icon: Icon(
            Icons.library_books,
            color: Theme.of(context).primaryColor,
          ),
          labelText: 'Nombre Curso',
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
          _nombre = value;
        },
        maxLength: 50,
      ),
    );
  }

  Widget fieldIng() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      child: TextFormField(
        decoration: InputDecoration(
          icon: Icon(
            Icons.accessibility_new,
            color: Theme.of(context).primaryColor,
          ),
          labelText: 'Nombre profesor',
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
          _profesor = value;
        },
        maxLength: 50,
      ),
    );
  }

  Widget fieldSeccion() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 100, vertical: 5),
      child: TextFormField(
        decoration: InputDecoration(
          icon: Icon(
            Icons.my_library_books_outlined,
            color: Theme.of(context).primaryColor,
          ),
          labelText: 'Sección',
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
          _seccion = value;
        },
        maxLength: 2,
      ),
    );
  }

  Widget fieldHoraI() {
    return Container(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        RaisedButton.icon(
          onPressed: () {
            selectHoraI(context);
          },
          icon: Icon(Icons.watch_later),
          label: Text("Hora Inicio"),
          color: Colors.redAccent,
        ),
        Text(
          _timeI.hour.toString() + ":" + _timeI.minute.toString(),
          style: TextStyle(fontSize: 20.0),
        )
      ]),
    );
  }

  Widget fieldHoraF() {
    return Container(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        RaisedButton.icon(
          onPressed: () {
            selectHoraF(context);
          },
          icon: Icon(Icons.watch_later),
          label: Text("Hora Final"),
          color: Colors.redAccent,
        ),
        Text(
          _timeF.hour.toString() + ":" + _timeF.minute.toString(),
          style: TextStyle(fontSize: 20.0),
        )
      ]),
    );
  }

  TimeOfDay _timeI = new TimeOfDay.now();
  TimeOfDay _timeF = new TimeOfDay.now();

  Future<Null> selectHoraI(BuildContext context) async {
    final TimeOfDay picked =
        await showTimePicker(context: context, initialTime: _timeI);

    if (picked != null && picked != _timeI) {
      setState(() {
        _timeI = picked;
        print("Hora seleccionada: " +
            _timeI.hour.toString() +
            _timeI.minute.toString());
      });
    }
  }

  Future<Null> selectHoraF(BuildContext context) async {
    final TimeOfDay picked =
        await showTimePicker(context: context, initialTime: _timeF);

    if (picked != null && picked != _timeF) {
      setState(() {
        _timeF = picked;
        print("Hora seleccionada: " +
            _timeF.hour.toString() +
            _timeF.minute.toString());
      });
    }
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
                  fieldCode(),
                  fieldName(),
                  fieldIng(),
                  fieldSeccion(),
                  fieldHoraI(),
                  fieldHoraF(),
                  Divider(),
                  mySub(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //LUNES
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Lu"),
                          Checkbox(
                              value: _Lunes,
                              onChanged: (bool value) {
                                setState(() {
                                  _Lunes = value;
                                });
                              })
                        ],
                      ),
                      //MARTES
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Ma"),
                          Checkbox(
                              value: _Martes,
                              onChanged: (bool value) {
                                setState(() {
                                  _Martes = value;
                                });
                              })
                        ],
                      ),
                      //MIERCOLES
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Mi"),
                          Checkbox(
                              value: _Miercoles,
                              onChanged: (bool value) {
                                setState(() {
                                  _Miercoles = value;
                                });
                              })
                        ],
                      ),
                      //JUEVES
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Jue"),
                          Checkbox(
                              value: _Jueves,
                              onChanged: (bool value) {
                                setState(() {
                                  _Jueves = value;
                                });
                              })
                        ],
                      ),
                      //VIERNES
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Vi"),
                          Checkbox(
                              value: _Viernes,
                              onChanged: (bool value) {
                                setState(() {
                                  _Viernes = value;
                                });
                              })
                        ],
                      ),
                      //SABADO
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Sa"),
                          Checkbox(
                              value: _Sabado,
                              onChanged: (bool value) {
                                setState(() {
                                  _Sabado = value;
                                });
                              })
                        ],
                      ),
                      //Domingo
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Do"),
                          Checkbox(
                              value: _Domingo,
                              onChanged: (bool value) {
                                setState(() {
                                  _Domingo = value;
                                });
                              })
                        ],
                      ),
                    ],
                  ),

//Button Register**************************************************************
                  SizedBox(height: 15),
                  RaisedButton(
                    onPressed: () async {
                      if (!_formKey.currentState.validate()) {
                        return;
                      } else {
                        _formKey.currentState.save();
                      }
                    },
                    child: Text(
                      "Crear curso",
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
