class PresenceModel {
  final int idPresence;
  final bool presence;
  final String motif;

  PresenceModel({
    required this.idPresence,
    required this.presence,
    required this.motif,
  });

  factory PresenceModel.fromFirebase(Map<String, dynamic> data) {
    return PresenceModel(
      idPresence: data['idPresence'],
      presence: data['presence'],
      motif: data['motif'],
    );
  }

  factory PresenceModel.fromSqflite(Map<String, dynamic> data) {
    return PresenceModel(
      idPresence: data['idPresence'],
      presence: data['presence'] == 1 || data['presence'] == true,
      motif: data['motif'],
    );
  }
}
