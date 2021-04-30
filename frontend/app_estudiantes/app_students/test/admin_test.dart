import 'package:app_students/src/pages/add_curse.dart';
import 'package:app_students/src/pages/admin_create_student.dart';
import 'package:app_students/src/pages/login.dart';
import 'package:app_students/src/pages/session.dart';
import 'package:app_students/src/pages/estudiantes.dart';
import 'package:app_students/src/pages/admin_delete.dart';
import 'package:app_students/src/pages/profile_admin.dart';
import 'package:app_students/src/pages/tabs.dart';
import 'package:flutter/material.dart' as Material;
import 'package:test/test.dart';
import 'package:app_students/src/pages/metodos.dart' as Metodos;

//flutter test --reporter expanded --coverage test/src/dart/dart_test.dart
//genhtml coverage/lcov.info -o coverage/html

void main() {
  Map estudiante = {
    "_id": "605e6868e046883547da2726",
    "nombre": "Levi",
    "apellido": "Ackermann",
    "CUI": "3445667722510",
    "carne": "202230456",
    "username": "levi@gmail.com",
    "password": "123456789",
    "__v": 0,
  };

  Usuario estudiantePrueba =
      Usuario.fromJson(estudiante.cast<String, dynamic>(), []);
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
        .then((value) => expect(value, TypeMatcher<List<Curso>>()));
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
    Metodos.eliminarUsuario('201602470', 'Test')
        .then((value) => expect(value, TypeMatcher<bool>()));
  });

  test('prueba a metodo widgetestudiante', () {
    var res = Estudiantes().createState().WidgetEstudiante(estudiantePrueba);
    expect(res, TypeMatcher<Material.ExpansionTile>());
  });

  test('lista de widget estudiante', () {
    var lista =
        Estudiantes().createState().widgetsEstudiantes([estudiantePrueba]);
    expect(lista, TypeMatcher<List<Material.Widget>>());
  });

  test('alarma de eliminar estudiante', () {
    var lista = Estudiantes().createState().confirmacion(estudiantePrueba);
    expect(lista, TypeMatcher<Material.AlertDialog>());
  });

  test('actualizar perfil estudiante admin', () {
    Profile_page_admin(estudiantePrueba).createState().actualizarPerfil();
  });

  test('test a edit button', () {
    Profile_page_admin(estudiantePrueba).createState().editBtn();
  });

  test('retornar titulo en cursos admin', () {
    var titulo = Delete_page().createState().retornarTitulo();
    expect(titulo, TypeMatcher<Material.Widget>());
  });

  test('obtener widget en cursos admin', () {
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
    var titulo = Delete_page()
        .createState()
        .obtenerWidgetsCursos([Curso.fromJson(datos.cast<String, dynamic>())]);
    expect(titulo, TypeMatcher<List<Material.Widget>>());
  });

  test('agregar curso nuevo', () {
    add_curse().createState().agregarCurso();
  });

  test('agregar estudiante nuevo', () {
    admin_student().createState().agregarEstudiante();
  });

  test('retornar boton flotante', () {
    var boton = Estudiantes().createState().floatButton();
    expect(boton, TypeMatcher<Material.FloatingActionButton>());
  });

  test('Actualizar foto de perfil de un estudiante desde administrador', () {
    Profile_page_admin(estudiantePrueba)
        .createState()
        .actualizar(estudiantePrueba, 'test/img/marlo.png');
  });

  test('alerta de datos actualizados', () {
    Profile_page_admin(estudiantePrueba)
        .createState()
        .alertaActualizacion(estudiantePrueba);
  });

  test('alerta de datos actualizados con nulo', () {
    Profile_page_admin(estudiantePrueba)
        .createState()
        .alertaActualizacion(null);
  });

  test('alerta para agregar un curso true', () {
    add_curse().createState().crearCursoAlarma(true);
  });

  test('alerta para agregar un curso false', () {
    add_curse().createState().crearCursoAlarma(false);
  });

  test('alerta para agregar un estudiante true', () {
    admin_student().createState().alertaCrearEstudiante(true);
  });

  test('alerta para agregar un estudiante false', () {
    admin_student().createState().alertaCrearEstudiante(false);
  });

  test('alerta para tabs true', () {
    tabs_page().createState().alertaTabs(true);
  });

  test('alerta para tabs false', () {
    tabs_page().createState().alertaTabs(false);
  });

  test('alerta para estudiantes true', () {
    Estudiantes().createState().alertaEstudiante(true, 'Estudiante');
  });

  test('alerta para estudiantes false', () {
    Estudiantes().createState().alertaEstudiante(false, 'Estudiante');
  });

  test('alerta para login true', () {
    login_page().createState().alertaLogin(estudiantePrueba);
  });

  test('alerta para login false', () {
    login_page().createState().alertaLogin(null);
  });
}
