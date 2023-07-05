class StudentModel {
  final String matricula;
  final String nombre;
  final String apellido;
  final String genero;

  StudentModel({
    required this.matricula,
    required this.nombre,
    required this.apellido,
    required this.genero,
  });

  factory StudentModel.fromMap(Map<String, dynamic> json) => StudentModel(
        matricula: json["matricula"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        genero: json["genero"],
      );

  Map<String, dynamic> toMap() => {
        "matricula": matricula,
        "nombre": nombre,
        "apellido": apellido,
        "genero": genero,
      };
}
