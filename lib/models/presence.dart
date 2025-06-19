class PresenceModel {
  final int idPresence;
  final int idEmpl;
  final bool presence;
  final String motif;
  final DateTime dateCreation;
  PresenceModel({
    required this.idPresence,
    required this.idEmpl,
    required this.presence,
    required this.motif,
    required this.dateCreation,
  });

  factory PresenceModel.fromMap(Map<String, dynamic> data) {
    return PresenceModel(
      idPresence: data['idPresence'],
      idEmpl:data['id_employe'] ,
      presence: data['presence'],
      motif: data['motif'],
      dateCreation: data['date_creation']
    );
  }

   Map<String, dynamic> toMap() {
    return {
        'idPresence':this.idPresence,
        'id_employe':this.idEmpl,
        'presence':this.presence,
        'motif':this.motif,
        'date_creation':this.dateCreation,
    };
  }

}
