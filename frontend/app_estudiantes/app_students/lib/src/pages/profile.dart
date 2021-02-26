import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:app_students/src/pages/session.dart';

class Profile_page extends StatelessWidget {
  const Profile_page({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
            width: 200.0,
            height: 200.0,
            decoration: BoxDecoration(color: Colors.blue),
            child: Center(
              child: LeerSesion(),
            )),
      ),
    );
  }
}
