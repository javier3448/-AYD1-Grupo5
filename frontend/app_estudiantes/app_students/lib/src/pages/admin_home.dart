import 'package:flutter/material.dart';

class Admin_page extends StatefulWidget {
  Admin_page({Key key}) : super(key: key);

  @override
  _Admin_pageState createState() => _Admin_pageState();
}

class _Admin_pageState extends State<Admin_page> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          "ADMIN HOME",
          style: TextStyle(fontSize: 30.0),
        ),
      ),
    );
  }
}
