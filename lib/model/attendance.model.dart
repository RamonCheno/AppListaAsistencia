class AttendanceModel {
  int? id;
  late String alumnoFk;
  late String presente;
  late String fecha;

  AttendanceModel({
    this.id,
    required this.presente,
    required this.alumnoFk,
    required this.fecha,
  });
}
