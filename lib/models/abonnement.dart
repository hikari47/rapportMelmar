class AbonnementModel {
  final int idAbonnement;
  final int idCli;
  final int? idEmpl;
  final int idSecteur;
  final String type;
  final double montantU;
  final double montantT;
  final int nombreMois;
  final DateTime dateCreation;

  AbonnementModel({
    required this.idAbonnement,
    required this.idCli,
    required this.idEmpl,
    required this.idSecteur,
    required this.type,
    required this.montantU,
    required this.montantT,
    required this.nombreMois,
    required this.dateCreation
  });

  factory AbonnementModel.fromMap(Map<String, dynamic> data) {
    return AbonnementModel(
      idAbonnement: data['id_abonnement'],
      idCli: data['id_client'],
      idEmpl: data['id_employe'],
      idSecteur:data['id_secteur'] ,
      type: data['type'],
      montantU: (data['montantU'] as num).toDouble(),
      montantT: (data['montantT'] as num).toDouble(),
      nombreMois: data['nombre_mois'],
      dateCreation: DateTime.parse(data['date_creation']),
    );
  }

   Map<String, dynamic> toMap() {
    return {
        'id_abonnement':this.idAbonnement,
        'id_client':this.idCli,
        'id_employe':this.idEmpl,
        'id_secteur':this.idSecteur,
        'type':this.type,
        'montantU':this.montantU,
        'montantT':this.montantT,
        'nombre_mois':this.nombreMois,
        'date_creation':this.dateCreation
    };
  }

}
