import 'package:flutter/material.dart';

class Create_page extends StatefulWidget {
  Create_page({Key key}) : super(key: key);

  @override
  _Create_pageState createState() => _Create_pageState();
}

class _Create_pageState extends State<Create_page> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          "CREATE",
          style: TextStyle(fontSize: 30.0),
        ),
      ),
    );
  }
}
