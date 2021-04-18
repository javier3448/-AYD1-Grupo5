import 'package:app_students/src/pages/metodos.dart' as Metodos;
import 'package:app_students/src/pages/session.dart';
import 'package:test/test.dart';
import 'dart:convert';
import 'dart:io' as Io;

void main() {
  // PRUEBAS UNITARIAS PARA ACTUALIZAR DE PERFIL A LA PLATAFORMA
  test('Editar datos de un estudiante', () {
    Map nuevo = {
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
    Metodos.actualizarPerfil(nuevo, [])
        .then((value) => expect(value, TypeMatcher<Usuario>()));
  });

  test('Actualizar foto de perfil de un estudiante', () {
    Map nuevo = {
      "_id": "605e6868e046883547da2726",
      "nombre": "Levi",
      "apellido": "Ackermann",
      "CUI": "3445667722510",
      "carne": "202230456",
      "username": "levi@gmail.com",
      "password": "123456789",
      "__v": 0,
    };
    final bytes = Io.File('test/img/marlo.png').readAsBytesSync();

    print(Io.Directory.current.path);
    String img64 = base64Encode(bytes);
    Map datos = {"carne": "202230456", "image": img64.toString()};
    Metodos.actualizarFotoPerfil(
            datos, Usuario.fromJson(nuevo.cast<String, dynamic>(), []))
        .then((value) => expect(value, TypeMatcher<Usuario>()));
  });
}
