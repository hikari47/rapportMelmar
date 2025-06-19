class ModelProduitServiceModel {
  final int idModel;
  final String type;
  final String nomModel;
  final double prix;
  final String champsModel;
  final int idSecteur;
  final String imagePath;
  final DateTime dateCreation;

  ModelProduitServiceModel({
    required this.idModel,
    required this.type,
    required this.nomModel,
    required this.prix,
    required this.champsModel,
    required this.idSecteur,
    required this.imagePath,
    required this.dateCreation
  });

  factory ModelProduitServiceModel.fromMap(Map<String, dynamic> data) {
    return ModelProduitServiceModel(
      idModel: data['id_model']??0,
      type: data['type']??'',
      nomModel: data['nom_model']??'',
      prix: data['prix']??0.0,
      champsModel: data['champs_model']??'',
      idSecteur: data['id_secteur']??0,
      imagePath: data['image_path']??'',
      dateCreation: data['date_creation']??DateTime.now()
    );
  }
   Map<String, dynamic> toMap() {
    return {
        'id_model':this.idModel,
        'type':this.type,
        'nom_model':this.nomModel,
        'prix':this.prix ,
        'champs_model':this.champsModel,
        'id_secteur':this.idSecteur,
        'image_path':this.imagePath,
        'date_creation':this.dateCreation
    };
  }

}
