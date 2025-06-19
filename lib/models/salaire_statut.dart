class SalaireStatutModel {
  final int idSalaireStatut;
  final int idEmpl;
  final int idAdmin;
  final bool payer;
  final double montant;
  final String motif;
  final DateTime dateCreation;

  SalaireStatutModel({
    required this.idSalaireStatut,
    required this.idEmpl,
    required this.idAdmin,
    required this.payer,
    required this.montant,
    required this.motif,
    required this.dateCreation,
  });

  factory SalaireStatutModel.fromMap(Map<String, dynamic> data) {
    return SalaireStatutModel(
      idSalaireStatut: data['idSalaireStatut'],
      idEmpl: data['id_employe'],
      idAdmin: data['id_admin'],
      payer: data['payer'],
      montant: data['montant'],
      motif: data['motif'],
      dateCreation:data['date_creation']
    );
  }

    Map<String, dynamic> toMap() {
    return {
        'idSalaireStatut':this.idSalaireStatut,
        'id_employe':this.idEmpl,
        'id_admin':this.idAdmin,
        'payer':this.payer,
        'montant':this.montant,
        'motif':this.motif,
        'date_creation':this.dateCreation,
    };
  }

  
}
