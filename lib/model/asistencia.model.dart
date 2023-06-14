import 'dart:convert';

class AttendanceModel {
  String _idAsistencia = "";
  String _alumnoFk = "";
  String _presente = "";
  String _fecha = "";

  AttendanceModel({
    required idAsistencia,
    required alumnoFk,
    required presente,
    required fecha,
  }) {
    _idAsistencia = idAsistencia;
    _alumnoFk = alumnoFk;
    _presente = presente;
    _fecha = fecha;
  }

  String get idAsistencia => _idAsistencia;

  String get alumnoFk => _alumnoFk;

  String get presente => _presente;

  String get fecha => _fecha;

  factory AttendanceModel.fromJson(String str) =>
      AttendanceModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AttendanceModel.fromMap(Map<String, dynamic> json) => AttendanceModel(
        idAsistencia: json["idAsistencia"],
        alumnoFk: json["alumnoFK"],
        presente: json["presente"],
        fecha: json["fecha"],
      );

  Map<String, dynamic> toMap() => {
        "idAsistencia": _idAsistencia,
        "alumnoFK": _alumnoFk,
        "presente": _presente,
        "fecha": _fecha,
      };
}
