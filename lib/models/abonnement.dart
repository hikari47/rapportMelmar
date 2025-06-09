class AbonnementModel {
  final int idAbonnement;
  final String type;
  final double montantU;
  final double montantT;
  final int nombreMois;

  AbonnementModel({
    required this.idAbonnement,
    required this.type,
    required this.montantU,
    required this.montantT,
    required this.nombreMois,
  });

  factory AbonnementModel.fromFirebase(Map<String, dynamic> data) {
    return AbonnementModel(
      idAbonnement: data['idAbonnement'],
      type: data['type'],
      montantU: (data['montantU'] as num).toDouble(),
      montantT: (data['montantT'] as num).toDouble(),
      nombreMois: data['nombreMois'],
    );
  }

  factory AbonnementModel.fromSqflite(Map<String, dynamic> data) {
    return AbonnementModel(
      idAbonnement: data['idAbonnement'],
      type: data['type'],
      montantU: (data['montantU'] as num).toDouble(),
      montantT: (data['montantT'] as num).toDouble(),
      nombreMois: data['nombreMois'],
    );
  }
}
