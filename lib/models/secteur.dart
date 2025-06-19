class SecteurModel {
  final int idSecteur;
  final String libelle;

  SecteurModel({
    required this.idSecteur,
    required this.libelle,
  });

  factory SecteurModel.fromMap(Map<String, dynamic> data) {
    return SecteurModel(
      idSecteur: data['idSecteur'],
      libelle: data['libelle'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
        'idSecteur':this.idSecteur,
        'libelle':this.libelle
    };
  }

 
}
