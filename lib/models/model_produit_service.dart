class ModelProduitServiceModel {
  final int idModel;
  final String nomModel;
  final String champsModel;
  final int idSecteur;
  final String imagePath;
  final DateTime dateCreation;

  ModelProduitServiceModel({
    required this.idModel,
    required this.nomModel,
    required this.champsModel,
    required this.idSecteur,
    required this.imagePath,
    required this.dateCreation
  });

  factory ModelProduitServiceModel.fromMap(Map<String, dynamic> data) {
    return ModelProduitServiceModel(
      idModel: data['id_model'],
      nomModel: data['nom_model'],
      champsModel: data['champs_model'],
      idSecteur: data['id_secteur'],
      imagePath: data['image_path'],
      dateCreation: data['date_creation']
    );
  }


}
