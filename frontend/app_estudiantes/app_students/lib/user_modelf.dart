class Estudiante {
  final String nombre;
  final String apellido;
  final String CUI;
  final String carne;
  final String username;
  final String password;

  Estudiante(
      {this.nombre,
      this.apellido,
      this.CUI,
      this.carne,
      this.username,
      this.password});

  factory Estudiante.fromJson(Map<String, dynamic> json) {
    return Estudiante(
        nombre: json['nombre'],
        apellido: json['apellido'],
        CUI: json['CUI'],
        carne: json['carne'],
        username: json['username'],
        password: json['password']);
  }
}
