class GroupModel {
  final int? idGrupo;
  final String nombreGrupo;
  final int fkMaestro;

  GroupModel({
    this.idGrupo,
    required this.nombreGrupo,
    required this.fkMaestro,
  });

  factory GroupModel.fromMap(Map<String, dynamic> json) => GroupModel(
        idGrupo: int.parse(json["idGrupo"]),
        nombreGrupo: json["NombreGrupo"],
        fkMaestro: int.parse(json["fkMaestro"]),
      );

  Map<String, dynamic> toMap() => {
        "idGrupo": idGrupo,
        "NombreGrupo": nombreGrupo,
        "fkMaestro": fkMaestro,
      };
}
