import 'dart:convert';

class StudentModel {
  String _matricula = "";
  String _nombre = "";
  String _apellido = "";
  String _genero = "";

  StudentModel({
    required matricula,
    required nombre,
    required apellido,
    required genero,
  }) {
    _matricula = matricula;
    _nombre = nombre;
    _apellido = apellido;
    _genero = genero;
  }

  String get matricula => _matricula;
  String get nombre => _nombre;
  String get apellido => _apellido;
  String get genero => _genero;

  factory StudentModel.fromJson(String str) =>
      StudentModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StudentModel.fromMap(Map<String, dynamic> json) => StudentModel(
        matricula: json["matricula"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        genero: json["genero"],
      );

  Map<String, dynamic> toMap() => {
        "matricula": _matricula,
        "nombre": _nombre,
        "apellido": _apellido,
        "genero": _genero,
      };
}
