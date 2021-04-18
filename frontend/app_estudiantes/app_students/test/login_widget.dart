import 'package:app_students/src/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_students/src/pages/alert_dialog.dart' as Alerta;
import 'dart:io';

void main() {
  Widget createWidgetForTesting({Widget child}) {
    return MaterialApp(
      home: child,
    );
  }

  setUpAll(() => HttpOverrides.global = null);

  testWidgets('Login page has a form widget', (WidgetTester tester) async {
    // Create the widget by telling the tester to build it.
    await tester.pumpWidget(createWidgetForTesting(child: new login_page()));

    expect(find.byType(Form), findsOneWidget);
  });

  testWidgets('Press login button', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetForTesting(child: new login_page()));

    expect(find.byKey(new Key('pass-field')), findsOneWidget);

    await tester.enterText(find.byKey(new Key('carnet-field')), "201504051");
    await tester.enterText(find.byKey(new Key('pass-field')), "123456789");
    expect(find.byType(RaisedButton), findsOneWidget);
    await tester.tap(find.byType(RaisedButton));
    await tester.pump();
  });

  testWidgets('Check if AlertDialog displays correct messages',
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetForTesting(
        child: new Alerta.Alerta(
            titulo: "Prueba", mensaje: "Mensaje para prueba unitaria!")));
    expect(find.text("Prueba"), findsOneWidget);
    expect(find.text("Mensaje para prueba unitaria!"), findsOneWidget);
  });

  testWidgets('Press okButton on AlertDialog', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetForTesting(
        child: new Alerta.Alerta(
            titulo: "Prueba", mensaje: "Mensaje para prueba unitaria!")));
    expect(find.byType(FlatButton), findsOneWidget);
    await tester.tap(find.byType(FlatButton));
    await tester.pump();
  });
}
