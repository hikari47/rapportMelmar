class PlanningModel {
  final int idPlanning;
  final int idAdmin;
  final int idEmpl;
  final String joursTravail;
  final DateTime dateCreation;

  PlanningModel({
    required this.idPlanning,
    required this.idAdmin,
    required this.idEmpl,
    required this.joursTravail,
    required this.dateCreation
  });

  factory PlanningModel.fromMap(Map<String, dynamic> data) {
    return PlanningModel(
      idPlanning: data['idPlanning'],
      idAdmin: data['id_admin'],
      idEmpl: data['id_employe'],
      joursTravail: data['joursTravail'],
      dateCreation: data['date_creation']
    );
  }


}
