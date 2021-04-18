import 'package:app_students/src/pages/add_curse.dart';
import 'package:flutter/material.dart';

class Delete_page extends StatefulWidget {
  Delete_page({Key key}) : super(key: key);

  @override
  _Delete_pageState createState() => _Delete_pageState();
}

class _Delete_pageState extends State<Delete_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        highlightElevation: 0,
        child: Icon(Icons.my_library_add),
        onPressed: () {
          debugPrint("agregar curso");
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => add_curse()));
        },
      ),
      resizeToAvoidBottomInset: true,
      appBar: null,
      body: Container(
        child: Center(
          child: Container(
            child: ListView(
              children: [Text("Mostrar cursos aca")],
            ),
          ),
        ),
      ),
    );
  }
}
