import 'package:flutter/material.dart';
import 'package:time_machine/time_machine.dart';
import 'package:timetable/timetable.dart';

class CursoSemanal {

  String nombre;

  // @Mejora?: validar que estos ints esten en rangos correctos (0-23 y 0-59)
  int horaInicio;
  int minutoInicio;
  int horaFinal;
  int minutoFinal;

  List<bool> hasEventDay;

  // que dia representa cada bool en hasEventDay, facilita un poco las funciones
  // getAllDayEventsIntersecting y getAllDayIntersecting
  static const List<DayOfWeek> DaysOfWeek = [
    DayOfWeek.monday,
    DayOfWeek.tuesday,
    DayOfWeek.wednesday,
    DayOfWeek.thursday,
    DayOfWeek.friday,
    DayOfWeek.saturday,
    DayOfWeek.sunday,
  ];


  CursoSemanal(String nombre, int horaInicio, int minutoInicio, int horaFinal, int minutoFinal, List<bool> hasEventDay){
    assert(hasEventDay.length == 7);

    this.nombre = nombre;
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
              color: Colors.blue,
              start: begEvent,
              end: endEvent
            ));
          }
        }
      }
      iter = iter.addDays(1);
    }

    return Stream.value(eventosParaTimetable);  
  }

  @override
  Stream<Iterable<E>> getPartDayEventsIntersecting(LocalDate date) {
    final events = _events.partDayEvents.intersectingDate(date);
    return Stream.value(events);
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
      // A basic EventProvider containing a single event:
      // eventProvider: EventProvider.list([
      //   BasicEvent(
      //     id: 0,
      //     title: 'My Event',
      //     color: Colors.blue,
      //     start: LocalDate.today().at(LocalTime(13, 0, 0)),
      //     end: LocalDate.today().at(LocalTime(15, 0, 0)),
      //   ),
      //   BasicEvent(
      //     id: 0,
      //     title: 'My Event',
      //     color: Colors.blue,
      //     start: LocalDate.today().at(LocalTime(13, 0, 0)),
      //     end: LocalDate.today().at(LocalTime(15, 0, 0)),
      //   ),
      // ]),

      // Or even this short example using a Stream:
      // eventProvider: EventProvider.stream(
      //   // @Mejora?: Podemos conseguir eventos de la base de datos con el stream
      //   // Siempre y cuando no podemaso tener actividades que no tenga un ciclo semanal
      //   // Eso no es necesario
      //   eventGetter: (range) => Stream.periodic(
      //     Duration(milliseconds: 16),
      //     (i) {
      //       final start =
      //           LocalDate.today().atMidnight() + Period(minutes: i * 2);
      //       return [
      //         BasicEvent(
      //           id: 0,
      //           title: 'Event',
      //           color: Colors.blue,
      //           start: start,
      //           end: start + Period(hours: 5),
      //         ),
      //       ];
      //     },
      //   ),
      // ),

      // Simple stream
      eventProvider: EventProvider.simpleStream(

      ),

      // Other (optional) parameters:
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