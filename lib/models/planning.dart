class PlanningModel {
  final int idPlanning;
  final String joursTravail;

  PlanningModel({
    required this.idPlanning,
    required this.joursTravail,
  });

  factory PlanningModel.fromFirebase(Map<String, dynamic> data) {
    return PlanningModel(
      idPlanning: data['idPlanning'],
      joursTravail: data['joursTravail'],
    );
  }

  factory PlanningModel.fromSqflite(Map<String, dynamic> data) {
    return PlanningModel(
      idPlanning: data['idPlanning'],
      joursTravail: data['joursTravail'],
    );
  }
}
