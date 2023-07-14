class StudentGroupModel {
  final String fkAlumno;
  final int fkGrupo;

  StudentGroupModel({
    required this.fkAlumno,
    required this.fkGrupo,
  });

  factory StudentGroupModel.fromMap(Map<String, dynamic> json) =>
      StudentGroupModel(
        fkAlumno: json["fkAlumno"],
        fkGrupo: json["fkGrupo"],
      );

  Map<String, dynamic> toMap() => {
        "fkAlumno": fkAlumno,
        "fkGrupo": fkGrupo,
      };
}
