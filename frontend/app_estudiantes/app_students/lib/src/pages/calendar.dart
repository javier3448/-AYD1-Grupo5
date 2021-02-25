import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class Calendar_page extends StatelessWidget {
  const Calendar_page({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
          width: 200.0,
          height: 200.0,
          decoration: BoxDecoration(color: Colors.green),
          child: Center(child: Text("HORARIO")),
        ),
      ),
    );
  }
}
