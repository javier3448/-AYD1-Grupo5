import 'package:flutter/material.dart';
import 'package:time_machine/time_machine.dart';
import 'package:timetable/timetable.dart';
import 'package:flutter_session/flutter_session.dart';
import 'cursos.dart';
import 'dart:math' show Random;

class CursoSemanal {
  // @Mejora: usar named params y esas cosas, creo que flutter tiene monto de syntax
  // sugar para este tipo de clases con todo publico y un constructor sencillo

  String nombre;

  Color color;

  int horaInicio;
  int minutoInicio;
  int horaFinal;
  int minutoFinal;

  List<bool> hasEventDay;

  // Que dia representa cada bool en hasEventDay, facilita un poco las funciones
  // getAllDayEventsIntersecting y getAllDayIntersecting de WeeklyEventProvider
  static const List<DayOfWeek> DaysOfWeek = [
    DayOfWeek.monday,
    DayOfWeek.tuesday,
    DayOfWeek.wednesday,
    DayOfWeek.thursday,
    DayOfWeek.friday,
    DayOfWeek.saturday,
    DayOfWeek.sunday,
  ];

  CursoSemanal(String nombre, Color color, int horaInicio, int minutoInicio,
      int horaFinal, int minutoFinal, List<bool> hasEventDay) {
    assert(hasEventDay.length == 7);
    assert(horaInicio < 24);
    assert(horaFinal < 23);
    assert(minutoInicio < 60);
    assert(minutoFinal < 60);

    this.nombre = nombre;
    this.color = color;
    this.horaInicio = horaInicio;
    this.minutoInicio = minutoInicio;
    this.horaFinal = horaFinal;
    this.minutoFinal = minutoFinal;
    this.hasEventDay = hasEventDay;
  }
}

// Nuestro propio EventProvider. El problema que soluciona es que queremos que ensenne
// el mismo horario para todas las semanas siempre, porque solo manejamos eventos
// semanales. Ademas no podemos limitar al TimeTableControler a mostrar solo una
// semana, entonces se va  a ver muy mal si el estudiante scrollea a la siguiente
// semana y que no tenga ningun evento.
// NO estoy seguro porque estos dos metodos son los que tengo que sobreescribir
// para hacer
class WeeklyEventProvider extends EventProvider<BasicEvent> {
  WeeklyEventProvider(List<CursoSemanal> cursosSemanales)
      : assert(cursosSemanales != null),
        _cursosSemanales = cursosSemanales;

  // cada curso tiene un weeklyEvent entonces el horario de un estudiantes va
  // a tener multiples weekly events
  final List<CursoSemanal> _cursosSemanales;

  // Lo que queremos hacer es pasar de 'los horarios de cursos' (cursosSemanales)
  // a los eventos que ocurririan en el intervalo `interval` para que el Timetable
  // los pueda mostrar
  @override
  Stream<Iterable<BasicEvent>> getAllDayEventsIntersecting(
      DateInterval interval) {
    // Sacamos los eventos que ocurriran en esta semana
    LocalDate iter = interval.start;
    LocalDate end = interval.end;

    List<BasicEvent> eventosParaTimetable = [];

    while (iter < end) {
      for (var cursoSemanal in _cursosSemanales) {
        for (var i = 0; i < cursoSemanal.hasEventDay.length; i++) {
          if (iter.dayOfWeek == CursoSemanal.DaysOfWeek[i] &&
              cursoSemanal.hasEventDay[i]) {
            LocalDateTime begEvent = iter
                .atMidnight()
                .addHours(cursoSemanal.horaInicio)
                .addMinutes(cursoSemanal.minutoInicio);
            LocalDateTime endEvent = iter
                .atMidnight()
                .addHours(cursoSemanal.horaFinal)
                .addMinutes(cursoSemanal.minutoFinal);

            eventosParaTimetable.add(BasicEvent(
                // @[!!!] NI IDEA QUE HACE EL ID, LO DEJAMOS EN 0 PARA TODOS D:
                id: eventosParaTimetable.length + 1,
                title: cursoSemanal.nombre,
                color: cursoSemanal.color,
                start: begEvent,
                end: endEvent));
          }
        }
      }
      iter = iter.addDays(1);
    }

    return Stream.value(eventosParaTimetable.allDayEvents);
  }

  @override
  Stream<Iterable<BasicEvent>> getPartDayEventsIntersecting(LocalDate date) {
    // Sacamos los eventos que ocurriran en esta semana
    LocalDate iter = date;

    List<BasicEvent> eventosParaTimetable = [];

    for (var cursoSemanal in _cursosSemanales) {
      for (var i = 0; i < cursoSemanal.hasEventDay.length; i++) {
        if (iter.dayOfWeek == CursoSemanal.DaysOfWeek[i] &&
            cursoSemanal.hasEventDay[i]) {
          LocalDateTime begEvent = iter
              .atMidnight()
              .addHours(cursoSemanal.horaInicio)
              .addMinutes(cursoSemanal.minutoInicio);
          LocalDateTime endEvent = iter
              .atMidnight()
              .addHours(cursoSemanal.horaFinal)
              .addMinutes(cursoSemanal.minutoFinal);

          eventosParaTimetable.add(BasicEvent(
              // @[!!!] NI IDEA QUE HACE EL ID, LO DEJAMOS EN 0 PARA TODOS D:
              id: eventosParaTimetable.length + 1,
              title: cursoSemanal.nombre,
              color: cursoSemanal.color,
              start: begEvent,
              end: endEvent));
        }
      }
    }

    return Stream.value(eventosParaTimetable);
  }
}

class Calendar_page extends StatefulWidget {
  @override
  _Calendar_pageState createState() => _Calendar_pageState();
}

class TimeTablePlus extends TimetableController<BasicEvent> {
  TimeTablePlus({
    @required EventProvider eventProvider,
  }) : super(
          eventProvider: eventProvider,
          initialTimeRange: InitialTimeRange.range(
            startTime: LocalTime(8, 0, 0),
            endTime: LocalTime(20, 0, 0),
          ),
          initialDate: LocalDate.today(),
          visibleRange: VisibleRange.days(5),
          firstDayOfWeek: DayOfWeek.monday,
        );
}

class _Calendar_pageState extends State<Calendar_page> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  TimetableController<BasicEvent> _controller;
  List<Color> colores = [
    Colors.amberAccent,
    Colors.blueAccent,
    Colors.cyanAccent,
    Colors.deepOrangeAccent[100],
    Colors.yellowAccent,
    Colors.purpleAccent,
    Colors.pinkAccent[100],
    Colors.orangeAccent[400],
    Colors.blueGrey[300],
    Colors.indigo[200],
    Colors.lime,
    Colors.green,
    Colors.brown[200],
    Colors.purple[200]
  ];
  var randomizar = new Random();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<CursoSemanal> obtenerCursos(List<dynamic> cursosAsignados) {
    List<CursoSemanal> cursos = [];
    cursosAsignados.forEach((element) {
      cursos.add(CursoSemanal(
          element['codigo'].toString() +
              ': ' +
              element['nombre'] +
              '\n' +
              element['catedratico'] +
              '\n' +
              element['seccion'],
          colores[randomizar.nextInt(colores.length - 1)],
          int.parse(element['horaInicio'].toString().split(':')[0]),
          int.parse(element['horaInicio'].toString().split(':')[1]),
          int.parse(element['horaFinal'].toString().split(':')[0]),
          int.parse(element['horaFinal'].toString().split(':')[1]),
          [
            element['lunes'].toString() == 'Y' ? true : false,
            element['martes'].toString() == 'Y' ? true : false,
            element['miercoles'].toString() == 'Y' ? true : false,
            element['jueves'].toString() == 'Y' ? true : false,
            element['viernes'].toString() == 'Y' ? true : false,
            element['sabado'].toString() == 'Y' ? true : false,
            element['domingo'].toString() == 'Y' ? true : false,
          ]));
    });
    return cursos;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: FutureBuilder(
          future: FlutterSession().get('user'),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              TimeTablePlus ctrlPlus = TimeTablePlus(
                  eventProvider: WeeklyEventProvider(
                      obtenerCursos(snapshot.data['cursosAsignados'])));
              return Scaffold(
                key: _scaffoldKey,
                body: Timetable<BasicEvent>(
                  controller: ctrlPlus,
                  onEventBackgroundTap: (start, isAllDay) {},
                  eventBuilder: (event) {
                    return BasicEventWidget(
                      event,
                      onTap: () {
                        String eventoString = event.title.toString();
                        var eventoInfo = eventoString.split('\n');
                        Widget okButton = FlatButton(
                          child: Text("OK"),
                          onPressed: () {
                            Navigator.of(context).pop(); // dismiss dialog
                          },
                        );
                        AlertDialog alert = AlertDialog(
                          title: Text(eventoInfo[0]),
                          backgroundColor: Colors.blue[50],
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(15)),
                          content: Text('\nCatedrático: ' +
                              eventoInfo[1] +
                              '\n\nSección: ' +
                              eventoInfo[2]),
                          actions: [
                            okButton,
                          ],
                        );
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      },
                    );
                  },
                  allDayEventBuilder: (context, event, info) =>
                      BasicAllDayEventWidget(
                    event,
                    info: info,
                    onTap: () => _showSnackBar('All-day event $event tapped'),
                  ),
                ),
              );
            }
            else if(snapshot.hasError){
              // TODO: poner un 'textTheme' especial o algo asi para que se sepa
              // que hubo error o al menos que este en rojo o algo asi
              return ErrorWidget('Error al hacer la peticion:\n\n' +
                  snapshot.error.toString());
            }
            else{
              //todavia estamos esperando al future
              return Center(
                child: CircularProgressIndicator(
                  strokeWidth: 8,
                ),
              );
            }
          }),
    );
  }

  void _showSnackBar(String content) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(content),
    ));
  }
}
