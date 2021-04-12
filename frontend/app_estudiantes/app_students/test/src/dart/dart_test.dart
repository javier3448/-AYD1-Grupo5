import 'package:test/test.dart';
import 'package:app_students/src/pages/metodos.dart';

//flutter test --reporter expanded --coverage test/src/dart/dart_test.dart
//genhtml coverage/lcov.info -o coverage/html

void main() {
  test('Ingreso de usuario a la aplicación', () async {
    Metodos()
        .ingresoUsuario("201504051", "123456789")
        .then((value) => {expect(value, equals(!null))});
  });

  test('String.trim() removes surrounding whitespace', () {
    var string = '  foo ';
    expect(string.trim(), equals('foo'));
  });
}
