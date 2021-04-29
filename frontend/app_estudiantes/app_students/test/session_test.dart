import 'package:app_students/src/pages/session.dart';
import 'package:test/test.dart';

//flutter test --reporter expanded --coverage test/*.dart
//genhtml coverage/lcov.info -o coverage/html

void main() {
  // PRUEBAS UNITARIAS PARA LOS OBJETOS: Usuario y Curso
  test('Convertir un objeto JSON a un objeto de tipo Usuario', () {
    //Arrange (Preparar)
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

    //Act (Actua)
    var usuarioTest = Usuario.fromJson(objetoJSON.cast<String, dynamic>(), []);

    //Assert (Afirmar)
    expect(usuarioTest, TypeMatcher<Usuario>());
  });

  test('Convertir un objeto dynamic a un objeto de tipo Usuario', () {
    dynamic objeto = {
      "id": "605e6868e046883547da2726",
      "nombre": "Mariana",
      "apellido": "Sic",
      "cui": "3017873870101",
      "carnet": "201504051",
      "username": "sicmariana8@gmail.com",
      "password": "123456789",
      "v": 0,
      "image":
          "https://proyecto1-ayd1.s3.us-east-2.amazonaws.com/7bc23af3-f06e-4492-bb0f-6a05de505324.jpg"
    };

    var usuarioDynamic = Usuario.fromDynamic(objeto, []);
    expect(usuarioDynamic, TypeMatcher<Usuario>());
  });

  test('Convertir un objeto Usuario a un objeto JSON', () {
    Usuario user = new Usuario(
        id: "605e6868e046883547da2726",
        nombre: "Mariana",
        apellido: "Sic",
        cui: "3017873870101",
        carnet: "201504051",
        username: "sicmariana8@gmail.com",
        password: "123456789",
        v: 0,
        image:
            "https://proyecto1-ayd1.s3.us-east-2.amazonaws.com/7bc23af3-f06e-4492-bb0f-6a05de505324.jpg");

    var usuarioJSON = user.toJson();
    expect(usuarioJSON, TypeMatcher<Map<String, dynamic>>());
  });

  test('Convertir un objeto JSON a un objeto de tipo Curso', () {
    Map objetoJSON = {
      "_id": "605e68d0e046883547da2727",
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
      "domingo": "N",
      "__v": 0
    };

    var cursoTest = Curso.fromJson(objetoJSON.cast<String, dynamic>());

    expect(cursoTest, TypeMatcher<Curso>());
  });

  test('Convertir un objeto dynamic a un objeto de tipo Curso', () {
    dynamic objeto = {
      "id": "605e68d0e046883547da2727",
      "nombre": "Analisis y diseño 1",
      "codigo": 774,
      "seccion": "A-",
      "horaInicio": "7:00",
      "horaFinal": "8:50",
      "catedratico": "Ivonne Aldana",
      "lunes": "N",
      "martes": "Y",
      "miercoles": "N",
      "jueves": "Y",
      "viernes": "N",
      "sabado": "N",
      "domingo": "N",
      "v": 0
    };

    var cursoDynamic = Curso.fromDynamic(objeto);
    expect(cursoDynamic, TypeMatcher<Curso>());
  });

  test('Convertir un objeto Curso a un objeto JSON', () {
    Curso curso = new Curso(
        id: "605e68d0e046883547da2727",
        nombre: "Analisis y diseño 1",
        codigo: 774,
        seccion: "A-",
        horaInicio: "7:00",
        horaFinal: "8:50",
        catedratico: "Ivonne Aldana",
        lunes: "N",
        martes: "Y",
        miercoles: "N",
        jueves: "Y",
        viernes: "N",
        sabado: "N",
        domingo: "N",
        v: 0);

    var cursoJSON = curso.toJson();
    expect(cursoJSON, TypeMatcher<Map<String, dynamic>>());
  });
}
