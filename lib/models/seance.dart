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

}
