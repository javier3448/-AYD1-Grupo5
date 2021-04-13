class Usuario {
  final String id;
  final String nombre;
  final String apellido;
  final String cui;
  final String carnet;
  final String username;
  final String password;
  final List<Curso> cursosAsignados;
  String image;
  final int v;

  Usuario(
      {this.id,
      this.nombre,
      this.apellido,
      this.cui,
      this.carnet,
      this.username,
      this.password,
      this.cursosAsignados,
      this.image,
      this.v});

  Usuario.fromJson(Map<String, dynamic> json, List<Curso> cursos)
      : id = json['_id'],
        nombre = json['nombre'],
        apellido = json['apellido'],
        cui = json['CUI'],
        carnet = json['carne'],
        username = json['username'],
        password = json['password'],
        cursosAsignados = cursos,
        image = json['image'],
        v = json['__v'];

  Usuario.fromDynamic(dynamic d, List<Curso> cursos)
      : id = d['id'],
        nombre = d['nombre'],
        apellido = d['apellido'],
        cui = d['cui'],
        carnet = d['carnet'],
        username = d['username'],
        password = d['password'],
        cursosAsignados = cursos,
        image = d['image'],
        v = d['v'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["nombre"] = nombre;
    data["apellido"] = apellido;
    data["cui"] = cui;
    data["carnet"] = carnet;
    data["username"] = username;
    data["password"] = password;
    data['cursosAsignados'] = cursosAsignados;
    data['image'] = image;
    data["v"] = v;
    return data;
  }
}

class Curso {
  final String id;
  final String nombre;
  final int codigo;
  final String seccion;
  final String horaInicio;
  final String horaFinal;
  final String catedratico;
  final String lunes;
  final String martes;
  final String miercoles;
  final String jueves;
  final String viernes;
  final String sabado;
  final String domingo;
  final int v;

  Curso(
      {this.id,
      this.nombre,
      this.codigo,
      this.seccion,
      this.horaInicio,
      this.horaFinal,
      this.catedratico,
      this.lunes,
      this.martes,
      this.miercoles,
      this.jueves,
      this.viernes,
      this.sabado,
      this.domingo,
      this.v});

  Curso.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        nombre = json['nombre'],
        codigo = json['codigo'],
        seccion = json['seccion'],
        horaInicio = json['horainicio'],
        horaFinal = json['horafinal'],
        catedratico = json['catedratico'],
        lunes = json['lunes'],
        martes = json['martes'],
        miercoles = json['miercoles'],
        jueves = json['jueves'],
        viernes = json['viernes'],
        sabado = json['sabado'],
        domingo = json['domingo'],
        v = json['__v'];

  Curso.fromDynamic(dynamic d)
      : id = d['id'],
        nombre = d['nombre'],
        codigo = d['codigo'],
        seccion = d['seccion'],
        horaInicio = d['horaInicio'],
        horaFinal = d['horaFinal'],
        lunes = d['lunes'],
        martes = d['martes'],
        miercoles = d['miercoles'],
        jueves = d['jueves'],
        viernes = d['viernes'],
        sabado = d['sabado'],
        domingo = d['domingo'],
        catedratico = d['catedratico'],
        v = 0;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["nombre"] = nombre;
    data['codigo'] = codigo;
    data['seccion'] = seccion;
    data['horaInicio'] = horaInicio;
    data['horaFinal'] = horaFinal;
    data['catedratico'] = catedratico;
    data['lunes'] = lunes;
    data['martes'] = martes;
    data['miercoles'] = miercoles;
    data['jueves'] = jueves;
    data['viernes'] = viernes;
    data['sabado'] = sabado;
    data['domingo'] = domingo;
    data["v"] = v;
    return data;
  }
}
