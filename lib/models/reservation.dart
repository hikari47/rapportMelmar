class ReservationModel {
  final int idReservation;
  final int idCli;
  final int idEmpl;
  final int idModel;
  final DateTime dateCreation;

  ReservationModel({
    required this.idReservation,
    required this.idCli,
    required this.idEmpl,
    required this.idModel,
    required this.dateCreation,
  });

  factory ReservationModel.fromMap(Map<String, dynamic> data) {
    return ReservationModel(
      idReservation: data['idReservation'],
      idCli: data['id_client'],
      idEmpl: data['id_employe'],
      idModel: data['id_model'],
      dateCreation: DateTime.parse(data['date_creation']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
        'idReservation':this.idReservation,
        'id_client':this.idCli,
        'id_employe':this.idEmpl,
        'id_model':this.idModel,
        'date_creation':this.dateCreation,
    };
  }

 
}
