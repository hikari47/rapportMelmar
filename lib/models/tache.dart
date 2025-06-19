class TacheModel {
  final int idTache;
  final String titre;
  final int idUser;
  final String contenu;
  final int Priorite;
  final bool effectuer;
  final DateTime dateCreation;

  TacheModel({
    required this.idTache,
    required this.titre,
    required this.idUser,
    required this.contenu,
    required this.Priorite,
    required this.effectuer,
    required this.dateCreation
  });

  factory TacheModel.fromMap(Map<String, dynamic> data) {
    return TacheModel(
      idTache: data['idTache'],
      titre: data['titre'],
      idUser: data['id_utilisateur'],
      contenu: data['contenu'],
      Priorite: data['priorite'],
      effectuer: data['effectuer'],
      dateCreation: data['date_creation']
    );
  }

  Map<String, dynamic> toMap() {
    return {
        'idTache':this.idTache,
        'titre':this.titre,
        'id_utilisateur':this.idUser,
        'contenu':this.contenu,
        'priorite':this.Priorite,
        'effectuer':this.effectuer,
        'date_creation':this.dateCreation
    };
  }

 
}
