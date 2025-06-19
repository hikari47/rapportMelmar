class HistoriquePModel {
    final int idHistorique;
    final int idModel;
    final String typeAction;
    final double quantite;
    final double montantU;
    final double montantT;
    final DateTime dateCreation;
    final int idUser;
    final String commentaire;
    HistoriquePModel(
      {required this.idHistorique,
      required this.idModel,
      required this.idUser,
      required this.typeAction,
      required this.quantite,
      required this.montantU,
      required this.montantT,
      required this.dateCreation,
      required this.commentaire}
    );

    factory HistoriquePModel.fromMap(Map<String, dynamic> data) {
    return HistoriquePModel(
    idHistorique: data['id_historique'],
    idModel: data['id_model'],
    idUser: data['id_utilisateur'],
    typeAction: data['type_action'],
    quantite: data['quantite'],
    montantU: data['montantU'],
    montantT: data['montantT'],
    dateCreation:DateTime.parse(data['date_creation']) ,
    commentaire: data['commentaire'],
    );
  }

   Map<String, dynamic> toMap() {
    return {
        'id_historique':this.idHistorique,
        'id_model':this.idModel,
        'id_utilisateur':this.idUser,
        'type_action':this.typeAction,
        'quantite':this.quantite,
        'montantU':this.montantU,
        'montantT':this.montantT
    };
  }
}