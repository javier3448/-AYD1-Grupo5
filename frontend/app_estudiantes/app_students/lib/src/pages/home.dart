import 'package:flutter/material.dart';

class Home_page extends StatelessWidget {
  const Home_page({Key key}) : super(key: key);

  Widget _BCurso(String textTitle, codigo, seccion, hInicio, hFinal) {
    return ExpansionTile(
      title: Text(codigo + " - " + textTitle),
      leading: Icon(Icons.school_sharp),
      trailing: Icon(Icons.expand_more_rounded),
      children: [
        Column(
          children: [
            Text(
              codigo + " - " + textTitle,
              style: TextStyle(
                  fontSize: 35.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              "Seccion: " + seccion,
              style: TextStyle(fontSize: 25.0, color: Colors.white),
            ),
            Text(
              "MIRNA ALDANA ",
              style: TextStyle(fontSize: 25.0, color: Colors.white),
            ),
            Text(
              "Inicio: " + hInicio + " Final: " + hFinal,
              style: TextStyle(fontSize: 20.0, color: Colors.white),
            )
          ],
        )
      ],
      backgroundColor: Color.fromRGBO(15, 45, 80, 1),
      initiallyExpanded: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
          child: ListView(
            children: [
              _BCurso('Curso 1', "000", "-A", "14:50", "15:40"),
              _BCurso('Curso 2', "756", "-B", "14:50", "15:40"),
              _BCurso('Curso 3', "241", "B", "14:50", "15:40"),
              _BCurso('Curso 4', "171", "+A", "14:50", "15:40"),
              _BCurso('Curso 5', "283", "N", "14:50", "15:40"),
              _BCurso('Curso 6', "455", "A", "14:50", "15:40"),
              _BCurso('Curso 1', "000", "-A", "14:50", "15:40"),
              _BCurso('Curso 2', "756", "-B", "14:50", "15:40"),
              _BCurso('Curso 3', "241", "B", "14:50", "15:40"),
              _BCurso('Curso 4', "171", "+A", "14:50", "15:40"),
              _BCurso('Curso 5', "283", "N", "14:50", "15:40"),
              _BCurso('Curso 6', "455", "A", "14:50", "15:40"),
              _BCurso('Curso 1', "000", "-A", "14:50", "15:40"),
              _BCurso('Curso 2', "756", "-B", "14:50", "15:40"),
              _BCurso('Curso 3', "241", "B", "14:50", "15:40"),
              _BCurso('Curso 4', "171", "+A", "14:50", "15:40"),
              _BCurso('Curso 5', "283", "N", "14:50", "15:40"),
              _BCurso('Curso 6', "455", "A", "14:50", "15:40"),
            ],
          ),
        ),
      ),
    );
  }
}
