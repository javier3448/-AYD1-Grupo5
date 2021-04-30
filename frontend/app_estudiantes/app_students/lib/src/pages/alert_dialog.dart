import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Alerta extends StatelessWidget {
  final String titulo;
  final String mensaje;
  final String nav;

  const Alerta(
      {Key key, @required this.titulo, @required this.mensaje, this.nav = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
        if (nav != "") Navigator.of(context).pushNamed(nav);
      },
    );

    return AlertDialog(
      title: Text(this.titulo),
      content: Text(this.mensaje),
      actions: [
        okButton,
      ],
    );
  }
}
