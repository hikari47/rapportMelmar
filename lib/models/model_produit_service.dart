class ModelProduitServiceModel {
  final int idModel;
  final String nomModel;
  final String champsModel;

  ModelProduitServiceModel({
    required this.idModel,
    required this.nomModel,
    required this.champsModel,
  });

  factory ModelProduitServiceModel.fromFirebase(Map<String, dynamic> data) {
    return ModelProduitServiceModel(
      idModel: data['idModel'],
      nomModel: data['nomModel'],
      champsModel: data['champsModel'],
    );
  }

  factory ModelProduitServiceModel.fromSqflite(Map<String, dynamic> data) {
    return ModelProduitServiceModel(
      idModel: data['idModel'],
      nomModel: data['nomModel'],
      champsModel: data['champsModel'],
    );
  }
}
