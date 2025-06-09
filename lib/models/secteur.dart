class SecteurModel {
  final int idSecteur;
  final String libelle;

  SecteurModel({
    required this.idSecteur,
    required this.libelle,
  });

  factory SecteurModel.fromFirebase(Map<String, dynamic> data) {
    return SecteurModel(
      idSecteur: data['idSecteur'],
      libelle: data['libelle'],
    );
  }

  factory SecteurModel.fromSqflite(Map<String, dynamic> data) {
    return SecteurModel(
      idSecteur: data['idSecteur'],
      libelle: data['libelle'],
    );
  }
}
