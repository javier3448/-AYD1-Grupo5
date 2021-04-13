import 'package:app_students/src/pages/session.dart';
import 'package:test/test.dart';
import 'package:app_students/src/pages/metodos.dart';

//flutter test --reporter expanded --coverage test/src/dart/dart_test.dart
//genhtml coverage/lcov.info -o coverage/html

void main() {
  Metodos metodos = new Metodos();

  //PRUEBAS UNITARIAS PARA EL INGRESO A LA PLATAFORMA
  test('Ingreso de usuario a la aplicación', () {
    metodos.ingresoUsuario("201504051", "123456789").then((value) => () {
          expect(value, TypeMatcher<Usuario>());
        });
  });

  test('Comprobar el mapeo de cursos asignados del usuario', () {
    Map cuerpo = {
      "cursos": [
        {
          "cursoid": "603f27a2285e9b10c446ce4b",
          "nombre": "Analisis y diseño 1",
          "codigo": 774,
          "seccion": "A-",
          "horainicio": "7:00",
          "horafinal": "8:50",
          "catedratico": "Ivonne Aldana",
          "lunes": "N",
          "martes": "Y",
          "miercoles": "N",
          "jueves": "Y",
          "viernes": "N",
          "sabado": "N",
          "domingo": "N"
        },
        {
          "cursoid": "605e66f4e046883547da2724",
          "nombre": "Economia",
          "codigo": 14,
          "seccion": "A",
          "horainicio": "11:20",
          "horafinal": "13:00",
          "catedratico": "Doctora Evelyn",
          "lunes": "N",
          "martes": "N",
          "miercoles": "N",
          "jueves": "N",
          "viernes": "N",
          "sabado": "Y",
          "domingo": "N"
        }
      ]
    };
    var lista = metodos.mapeoCurso(cuerpo);
    expect(lista, TypeMatcher<List<Curso>>());
  });

  //PRUEBAS UNITARIAS PARA EL REGISTRO DE UN USUARIO
  test('Registrar un usuario a la plataforma', () {
    Map datos = {
      "nombre": "Usuario",
      "apellido": "Test",
      "CUI": "3017873870101",
      "carne": "201587965",
      "username": "correo@gmail.com",
      "password": "123456789"
    };

    metodos.registrarUsuario(datos).then((value) => expect(value, true));
  });
}
