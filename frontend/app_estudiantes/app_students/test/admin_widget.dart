import 'package:app_students/src/pages/about.dart';
import 'package:app_students/src/pages/add_curse.dart';
import 'package:app_students/src/pages/admin_create_student.dart';
import 'package:app_students/src/pages/estudiantes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_students/src/pages/adminTabs.dart';
import 'dart:io';
import 'package:app_students/src/pages/session.dart';

void main() {
  Widget widgetTest({Widget child}) {
    return MaterialApp(
      home: child,
    );
  }

  Widget widgetTest2({Widget child}) {
    return MaterialApp(
      home: Scaffold(
        body: child,
      ),
    );
  }

  setUpAll(() => HttpOverrides.global = null);
  final TestWidgetsFlutterBinding binding =
      TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Find an AppBar admin controller', (WidgetTester tester) async {
    await tester.pumpWidget(widgetTest(child: Admin_Tabs()));
    expect(find.byType(AppBar), findsOneWidget);
  });

  testWidgets('Admin page navigator', (WidgetTester tester) async {
    await tester.pumpWidget(widgetTest(child: Admin_Tabs()));
    expect(find.byType(BottomNavigationBar), findsOneWidget);
    await tester.tap(find.byType(BottomNavigationBar));
    await tester.pump();
  });

  testWidgets('Press PopupMenuButton on admin page',
      (WidgetTester tester) async {
    await tester.pumpWidget(widgetTest(child: Admin_Tabs()));
    expect(find.byKey(new Key('pop-btn')), findsOneWidget);
    await tester.tap(find.byKey(new Key('pop-btn')));
    await tester.pumpAndSettle();
  });

  testWidgets('Create student on admin has a form',
      (WidgetTester tester) async {
    await tester.pumpWidget(widgetTest(child: admin_student()));
    expect(find.byType(Form), findsOneWidget);
  });

  testWidgets('Tap on create student button (admin)',
      (WidgetTester tester) async {
    await tester.pumpWidget(widgetTest(child: admin_student()));
    expect(find.byType(RaisedButton), findsOneWidget);

    await tester.tap(find.byType(RaisedButton));
    await tester.pumpAndSettle();
  });

  testWidgets('About has an appbar', (WidgetTester tester) async {
    await tester.pumpWidget(widgetTest(child: about()));
    expect(find.byType(AppBar), findsOneWidget);
  });

  testWidgets('Add Course page has a Form', (WidgetTester tester) async {
    await tester.pumpWidget(widgetTest(child: add_curse()));
    expect(find.byType(Form), findsOneWidget);
  });

  testWidgets('Press button on Add Course page', (WidgetTester tester) async {
    await tester.pumpWidget(widgetTest(child: add_curse()));

    /*expect(find.byKey(new Key('code-txt')), findsOneWidget);
    await tester.enterText(find.byKey(new Key('code-txt')), "001");*/

    for (int i = 1; i < 8; i++) {
      expect(find.byKey(new Key('D' + i.toString())), findsOneWidget);
      await tester.tap(find.byKey(new Key('D' + i.toString())));
    }

    /*expect(find.byKey(new Key('press-btn')), findsOneWidget);
    await tester.tap(find.byKey(Key('press-btn')));*/
    await tester.pumpAndSettle();
  });

  /*testWidgets('Edit profile student has four containers',
      (WidgetTester tester) async {
    Usuario test = Usuario(
        apellido: 'Test',
        carnet: '201504051',
        cui: '3017873870101',
        cursosAsignados: [],
        id: 'id1',
        image: "",
        nombre: 'Usuario',
        password: '123456789',
        username: 'user-test@gmail.com',
        v: 0);
    await binding.setSurfaceSize(Size(800, 800));
    await tester.pumpWidget(widgetTest(child: Profile_page_admin(test)));
    expect(find.byType(SingleChildScrollView), findsNWidgets(2));
  });*/
  testWidgets('test estudiantes.dart ', (WidgetTester tester) async {
    await tester.pumpWidget(Estudiantes());
    await tester.pump(Duration.zero);
    //expect(find.byType(FutureBuilder), findsOneWidget);
  });

  testWidgets('test widget estudiante', (WidgetTester tester) async {
    Map objetoJSON = {
      "_id": "605e6868e046883547da2726",
      "nombre": "Mariana",
      "apellido": "Sic",
      "CUI": "3017873870101",
      "carne": "201504051",
      "username": "sicmariana8@gmail.com",
      "password": "123456789",
      "__v": 0,
      "image":
          "https://proyecto1-ayd1.s3.us-east-2.amazonaws.com/7bc23af3-f06e-4492-bb0f-6a05de505324.jpg"
    };
    await tester.pumpWidget(widgetTest2(
        child: Estudiantes().createState().WidgetEstudiante(
            Usuario.fromJson(objetoJSON.cast<String, dynamic>(), []))));
  });
}
