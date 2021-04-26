import 'package:app_students/src/pages/session.dart';
import 'package:app_students/src/pages/estudiantes.dart';
import 'package:flutter/material.dart' as Material;
import 'package:test/test.dart';
import 'package:app_students/src/pages/metodos.dart' as Metodos;

//flutter test --reporter expanded --coverage test/src/dart/dart_test.dart
//genhtml coverage/lcov.info -o coverage/html

void main() {
  test('Obtener titulo de Estudiantes', () {
    var titulo = Metodos.retornarTitulo();
    expect(titulo, TypeMatcher<Material.Container>());
  });

  test('Obtener el listado de estudiantes', () {
    Metodos.apiEstudiantes()
        .then((value) => expect(value, TypeMatcher<List<Usuario>>()));
  });

  test('Obtener el listado de cursos', () {
    Metodos.apiCursos()
        .then((value) => expect(value, TypeMatcher<List<Usuario>>()));
  });

  test('metodo para cargar imagen de perfil en el listado de estudiantes', () {
    Metodos.loadImageEstudiante(null).then((value) =>
        expect(value, Material.AssetImage("assets/defaultProfilePicture.png")));
  });

  test('metodo para cargar imagen de perfil en el listado de estudiantes vacio',
      () {
    Metodos.loadImageEstudiante("").then((value) =>
        expect(value, Material.AssetImage("assets/defaultProfilePicture.png")));
  });

  test('metodo para cargar imagen de perfil en el listado de estudiantes vacio',
      () async {
    await Metodos.loadImageEstudiante(
            "https://i.ibb.co/j8fF06r/Armin-845-anime.png")
        .then((value) => expect(
            value,
            Material.NetworkImage(
                "https://i.ibb.co/j8fF06r/Armin-845-anime.png")));
  });

  test('crear un curso del administrador', () {
    Map datos = {
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
    };
    Metodos.crearCursoAdmin(datos)
        .then((value) => expect(value, TypeMatcher<bool>()));
  });

  test('eliminar un estudiante como admin', () {
    Material.BuildContext context;
    Metodos.eliminarUsuario('201602470', 'Test', context)
        .then((value) => expect(value, TypeMatcher<bool>()));
  });

  test('prueba a metodo widgetestudiante', () {
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
    var res = Estudiantes().createState().WidgetEstudiante(
        Usuario.fromJson(objetoJSON.cast<String, dynamic>(), []));
    expect(res, TypeMatcher<Material.ExpansionTile>());
  });

  test('lista de widget estudiante', () {
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
    var lista = Estudiantes().createState().widgetsEstudiantes(
        [Usuario.fromJson(objetoJSON.cast<String, dynamic>(), [])]);
    expect(lista, TypeMatcher<List<Material.Widget>>());
  });

  test('alarma de eliminar estudiante', () {
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
    var lista = Estudiantes()
        .createState()
        .confirmacion(Usuario.fromJson(objetoJSON.cast<String, dynamic>(), []));
    expect(lista, TypeMatcher<Material.AlertDialog>());
  });
}
