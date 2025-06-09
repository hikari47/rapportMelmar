class TacheModel {
  final int idTache;
  final String titre;
  final String contenu;

  TacheModel({
    required this.idTache,
    required this.titre,
    required this.contenu,
  });

  factory TacheModel.fromFirebase(Map<String, dynamic> data) {
    return TacheModel(
      idTache: data['idTache'],
      titre: data['titre'],
      contenu: data['contenu'],
    );
  }

  factory TacheModel.fromSqflite(Map<String, dynamic> data) {
    return TacheModel(
      idTache: data['idTache'],
      titre: data['titre'],
      contenu: data['contenu'],
    );
  }
}
