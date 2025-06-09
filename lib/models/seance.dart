class SeanceModel {
  final int idSeance;
  final DateTime dateSeance;
  final DateTime duree;

  SeanceModel({
    required this.idSeance,
    required this.dateSeance,
    required this.duree,
  });

  factory SeanceModel.fromFirebase(Map<String, dynamic> data) {
    return SeanceModel(
      idSeance: data['idSeance'],
      dateSeance: DateTime.parse(data['dateSeance']),
      duree: DateTime.parse(data['duree']),
    );
  }

  factory SeanceModel.fromSqflite(Map<String, dynamic> data) {
    return SeanceModel(
      idSeance: data['idSeance'],
      dateSeance: DateTime.parse(data['dateSeance']),
      duree: DateTime.parse(data['duree']),
    );
  }
}
