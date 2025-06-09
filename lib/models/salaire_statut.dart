class SalaireStatutModel {
  final int idSalaireStatut;
  final bool payer;

  SalaireStatutModel({
    required this.idSalaireStatut,
    required this.payer,
  });

  factory SalaireStatutModel.fromFirebase(Map<String, dynamic> data) {
    return SalaireStatutModel(
      idSalaireStatut: data['idSalaireStatut'],
      payer: data['payer'],
    );
  }

  factory SalaireStatutModel.fromSqflite(Map<String, dynamic> data) {
    return SalaireStatutModel(
      idSalaireStatut: data['idSalaireStatut'],
      payer: data['payer'] == 1 || data['payer'] == true,
    );
  }
}
