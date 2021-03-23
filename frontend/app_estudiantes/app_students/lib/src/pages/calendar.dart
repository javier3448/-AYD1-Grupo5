import 'package:flutter/material.dart';
import 'package:time_machine/time_machine.dart';
import 'package:timetable/timetable.dart';

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

  CursoSemanal(String nombre, Color color, int horaInicio, int minutoInicio, int horaFinal, int minutoFinal, List<bool> hasEventDay){
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
  WeeklyEventProvider(List<CursoSemanal>cursosSemanales)
      : assert(cursosSemanales != null),
        _cursosSemanales = cursosSemanales;

  // cada curso tiene un weeklyEvent entonces el horario de un estudiantes va 
  // a tener multiples weekly events
  final List<CursoSemanal> _cursosSemanales;

  // Lo que queremos hacer es pasar de 'los horarios de cursos' (cursosSemanales)
  // a los eventos que ocurririan en el intervalo `interval` para que el Timetable
  // los pueda mostrar
  @override
  Stream<Iterable<BasicEvent>> getAllDayEventsIntersecting(DateInterval interval) {
    // Sacamos los eventos que ocurriran en esta semana
    LocalDate iter = interval.start;
    LocalDate end = interval.end;

    List<BasicEvent> eventosParaTimetable = [];

    while(iter < end){
      for(var cursoSemanal in _cursosSemanales){
        for (var i = 0; i < cursoSemanal.hasEventDay.length; i++) {
          if(iter.dayOfWeek == CursoSemanal.DaysOfWeek[i] && 
              cursoSemanal.hasEventDay[i]){
            LocalDateTime begEvent = iter.atMidnight().addHours(cursoSemanal.horaInicio).addMinutes(cursoSemanal.minutoInicio);
            LocalDateTime endEvent = iter.atMidnight().addHours(cursoSemanal.horaFinal).addMinutes(cursoSemanal.minutoFinal);

            eventosParaTimetable.add(BasicEvent(
              // @[!!!] NI IDEA QUE HACE EL ID, LO DEJAMOS EN 0 PARA TODOS D:
              id: 0,
              title: cursoSemanal.nombre,
              color: cursoSemanal.color,
              start: begEvent,
              end: endEvent
            ));
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

    for(var cursoSemanal in _cursosSemanales){
      for (var i = 0; i < cursoSemanal.hasEventDay.length; i++) {
        if(iter.dayOfWeek == CursoSemanal.DaysOfWeek[i] && 
            cursoSemanal.hasEventDay[i]){
          LocalDateTime begEvent = iter.atMidnight().addHours(cursoSemanal.horaInicio).addMinutes(cursoSemanal.minutoInicio);
          LocalDateTime endEvent = iter.atMidnight().addHours(cursoSemanal.horaFinal).addMinutes(cursoSemanal.minutoFinal);

          eventosParaTimetable.add(BasicEvent(
            // @[!!!] NI IDEA QUE HACE EL ID, LO DEJAMOS EN 0 PARA TODOS D:
            id: 0,
            title: cursoSemanal.nombre,
            color: cursoSemanal.color,
            start: begEvent,
            end: endEvent
          ));
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

class _Calendar_pageState extends State<Calendar_page> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  TimetableController<BasicEvent> _controller;

  @override
  void initState() {
    super.initState();

    _controller = TimetableController(
      eventProvider: WeeklyEventProvider(
        [
          // Para Mariana:
          // Por ahora queme los cursos aqui, tendria que ir una lista con los
          // 'CursoSemanal' del estudiante logeado.
          CursoSemanal(
            "curso\ncatedratico\ndescripcion", // string que aparece en la celda
            Colors.blue, //color de la celda
            8, 10,   //hora inicio (8:10)
            10, 10,  //hora fin (10:10)
            [
              true,  // Lunes
              false, // Martes
              true,  // Miercoles
              false, // Jueves
              true,  // Viernes
              false, // Sabado
              true   // domingo
            ]
          ),
          CursoSemanal(
            "Otro curso\notro catedratico\n otra descripcion", // string que aparece en la celda
            Colors.lightBlue, // color de la celda
            12, 30, //hora inicio (12:30)
            14, 30, //hora fin (14:40)
            [
              false, // Lunes
              true,  // Martes
              false, // Miercoles
              true,  // Jueves
              false, // Viernes
              true,  // Sabado
              false, // domingo
            ]
          )
        ]
      ),

      initialTimeRange: InitialTimeRange.range(
        startTime: LocalTime(8, 0, 0),
        endTime: LocalTime(20, 0, 0),
      ),
      initialDate: LocalDate.today(),
      visibleRange: VisibleRange.days(3),
      firstDayOfWeek: DayOfWeek.monday,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Timetable example'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.today),
            onPressed: () => _controller.animateToToday(),
            tooltip: 'Jump to today',
          ),
        ],
      ),
      body: Timetable<BasicEvent>(
        controller: _controller,
        onEventBackgroundTap: (start, isAllDay) {
          _showSnackBar('Background tapped $start is all day event $isAllDay');
        },
        eventBuilder: (event) {
          return BasicEventWidget(
            event,
            onTap: () => _showSnackBar('Part-day event $event tapped'),
          );
        },
        allDayEventBuilder: (context, event, info) => BasicAllDayEventWidget(
          event,
          info: info,
          onTap: () => _showSnackBar('All-day event $event tapped'),
        ),
      ),
    );
  }

  void _showSnackBar(String content) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(content),
    ));
  }
}