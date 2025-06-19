class SeanceModel {
  final int idSeance;
  final int idCli;
  final int? idEmpl;
  final int ? idAbonnement;
  final int idSecteur;
  final DateTime dateCreation;
  final DateTime duree;
  final double montantT;

  SeanceModel({
    required this.idSeance,
    required this.idCli,
    required this.idEmpl,
    required this.idAbonnement,
    required this.idSecteur,
    required this.dateCreation,
    required this.duree,
    required this.montantT
  });

  factory SeanceModel.fromMap(Map<String, dynamic> data) {
    return SeanceModel(
      idSeance: data['id_seance'],
      idCli: data['id_client'],
      idEmpl: data['id_employe'],
      idAbonnement: data['id_abonnement'],
      idSecteur:data['id_secteur'] ,
      dateCreation: DateTime.parse(data['date_creation']),
      duree: DateTime.parse(data['duree']),
      montantT: (data['montantT'] as num).toDouble()
    );
  }

  Map<String, dynamic> toMap() {
    return {
        'id_seance':this.idSeance,
        'id_client':this.idCli,
        'id_employe':this.idEmpl,
        'id_abonnement':this.idAbonnement,
        'id_secteur':this.idSecteur,
        'duree':this.duree,
        'montantT':this.montantT,
        'date_creation':this.dateCreation,
    };
  }

}

class NewModel {
  final int id;
  final String image;
  final String url;

  NewModel({
    required this.id,
    required this.image,
    required this.url,
  });

  factory NewModel.fromMap(Map<String, dynamic> data) {
    return NewModel(
      id: data['id'],
      image: data['image'],
      url: data['url'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'image': this.image,
      'url': this.url,
    };
  }
}

class EventModel {
  final int id;
  final String image;
  final String titre;
  final String description;
  final String url;

  EventModel({
    required this.id,
    required this.image,
    required this.titre,
    required this.description,
    required this.url,
  });

  factory EventModel.fromMap(Map<String, dynamic> data) {
    return EventModel(
      id: data['id'],
      image: data['image'],
      titre: data['titre'],
      description: data['description'],
      url: data['url'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'image': this.image,
      'titre': this.titre,
      'description': this.description,
      'url': this.url,
    };
  }
}
