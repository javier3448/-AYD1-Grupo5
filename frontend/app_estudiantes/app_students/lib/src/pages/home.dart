import 'package:flutter/material.dart';

class Home_page extends StatelessWidget {
  const Home_page({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
          width: 200.0,
          height: 200.0,
          decoration: BoxDecoration(color: Colors.red),
          child: Center(child: Text("INICIO")),
        ),
      ),
    );
  }
}
