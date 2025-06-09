class PaiementModel {
  final int idPaiement;
  final DateTime datePaiement;
  final double montant;

  PaiementModel({
    required this.idPaiement,
    required this.datePaiement,
    required this.montant,
  });

  factory PaiementModel.fromFirebase(Map<String, dynamic> data) {
    return PaiementModel(
      idPaiement: data['idPaiement'],
      datePaiement: DateTime.parse(data['datePaiement']),
      montant: (data['montant'] as num).toDouble(),
    );
  }

  factory PaiementModel.fromSqflite(Map<String, dynamic> data) {
    return PaiementModel(
      idPaiement: data['idPaiement'],
      datePaiement: DateTime.parse(data['datePaiement']),
      montant: (data['montant'] as num).toDouble(),
    );
  }
}
