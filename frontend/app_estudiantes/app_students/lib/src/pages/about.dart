import 'package:flutter/material.dart';

class about extends StatefulWidget {
  about({Key key}) : super(key: key);

  @override
  _aboutState createState() => _aboutState();
}

class _aboutState extends State<about> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Acerca de..."),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Proyecto de Clase",
                    style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),
                Text("Analisis y Diseño de sistemas 1",
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.w400)),
                Text("Inga. Mirna Ivonne Aladana",
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.w400)),
                Text("Grupo No.5",
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.person_outline),
                    Text("  201408549 - Elba Maria Álvarez Domínguez",
                        style: TextStyle(fontSize: 16.0))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.person_outline),
                    Text("  201504051 - Asunción Mariana Sic Sor",
                        style: TextStyle(fontSize: 16.0))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.person_outline),
                    Text("  201601469 - Oscar Eduardo Mazariegos López",
                        style: TextStyle(fontSize: 16.0))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.person_outline),
                    Text("  201602625 - Oscar Alfredo Llamas Lemus",
                        style: TextStyle(fontSize: 16.0))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.person_outline),
                    Text("  201612383 - Javier Antonio Álvarez González",
                        style: TextStyle(fontSize: 16.0))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
