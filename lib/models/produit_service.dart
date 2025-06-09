class ProduitServiceModel {
  final int idProduitService;

  ProduitServiceModel({
    required this.idProduitService,
  });

  factory ProduitServiceModel.fromFirebase(Map<String, dynamic> data) {
    return ProduitServiceModel(
      idProduitService: data['idProduitService'],
    );
  }

  factory ProduitServiceModel.fromSqflite(Map<String, dynamic> data) {
    return ProduitServiceModel(
      idProduitService: data['idProduitService'],
    );
  }
}
