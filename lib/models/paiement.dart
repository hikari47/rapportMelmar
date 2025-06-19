class PaiementModel {
  final int idPaiement;
    final int idCli;
  final int? idEmpl;
  final DateTime dateCreation;
  final double montant;

  PaiementModel({
    required this.idPaiement,
    required this.idCli,
    required this.idEmpl,
    required this.dateCreation,
    required this.montant,
  });

  factory PaiementModel.fromMap(Map<String, dynamic> data) {
    return PaiementModel(
      idPaiement: data['id_paiement'],
      idCli: data['id_client'],
      idEmpl: data['id_employe'],
     dateCreation: DateTime.parse(data['date_creation']),
      montant: (data['montant'] as num).toDouble(),
    );
  }

    Map<String, dynamic> toMap() {
    return {
        'id_paiement':this.idPaiement,
        'id_client':this.idCli,
        'id_employe':this.idEmpl,
        'date_creation':this.dateCreation,
        'montant':this.montant
    };
  }
}
