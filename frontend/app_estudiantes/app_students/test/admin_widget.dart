import 'package:app_students/src/pages/admin_create_student.dart';
import 'package:app_students/src/pages/profile_admin.dart';
import 'package:app_students/src/pages/session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_students/src/pages/adminTabs.dart';
import 'dart:io';

void main() {
  Widget widgetTest({Widget child}) {
    return MaterialApp(
      home: child,
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
    expect(find.byType(PopupMenuButton), findsOneWidget);
    await tester.tap(find.byType(PopupMenuButton));
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
}
