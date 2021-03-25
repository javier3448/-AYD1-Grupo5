import 'package:flutter/material.dart';

class Delete_page extends StatefulWidget {
  Delete_page({Key key}) : super(key: key);

  @override
  _Delete_pageState createState() => _Delete_pageState();
}

class _Delete_pageState extends State<Delete_page> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          "DELETE",
          style: TextStyle(fontSize: 30.0),
        ),
      ),
    );
  }
}
