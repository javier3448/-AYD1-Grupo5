import 'package:app_students/src/pages/login.dart';
import 'package:app_students/src/pages/tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_students/src/pages/alert_dialog.dart';
import 'dart:io';

void main() {
  Widget createWidgetForTesting({Widget child}) {
    return MaterialApp(
      home: child,
    );
  }

  setUpAll(() => HttpOverrides.global = null);

  testWidgets('Login page has a form widget', (WidgetTester tester) async {
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
        child: new Alerta(
            titulo: "Prueba", mensaje: "Mensaje para prueba unitaria!")));
    expect(find.text("Prueba"), findsOneWidget);
    expect(find.text("Mensaje para prueba unitaria!"), findsOneWidget);
  });

  testWidgets('Press okButton on AlertDialog', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetForTesting(
        child: new Alerta(
            titulo: "Prueba", mensaje: "Mensaje para prueba unitaria!")));
    expect(find.byType(FlatButton), findsOneWidget);
    await tester.tap(find.byType(FlatButton));
    await tester.pump();
  });

  testWidgets('Register page has a form widget', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetForTesting(child: new tabs_page()));

    expect(find.byType(Form), findsOneWidget);
  });

  testWidgets('Register new student with the form',
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetForTesting(child: new tabs_page()));

    await tester.tap(find.byKey(new Key('carnet-field')));
    await tester.enterText(find.byKey(new Key('carnet-field')), "201602526");

    await tester.tap(find.byKey(new Key('cui-field')));
    await tester.enterText(find.byKey(new Key('cui-field')), "3017972550101");

    await tester.tap(find.byKey(new Key('name-field')));
    await tester.enterText(find.byKey(new Key('name-field')), "Test");

    await tester.tap(find.byKey(new Key('last-field')));
    await tester.enterText(find.byKey(new Key('last-field')), "Widget");

    await tester.tap(find.byKey(new Key('email-field')));
    await tester.enterText(
        find.byKey(new Key('email-field')), "testwidget@gmail.com");

    await tester.tap(find.byKey(new Key('pass-field')));
    await tester.enterText(find.byKey(new Key('pass-field')), "123456789");

    await tester.tap(find.byKey(new Key('register-btn')));
    await tester.pumpAndSettle(new Duration(seconds: 2));
  });
}
