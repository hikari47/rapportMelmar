class ReservationModel {
  final int idReservation;
  final int idCli;
  final int idEmpl;
  final int idModel;
  final DateTime dateReservation;

  ReservationModel({
    required this.idReservation,
    required this.idCli,
    required this.idEmpl,
    required this.idModel,
    required this.dateReservation,
  });

  factory ReservationModel.fromMap(Map<String, dynamic> data) {
    return ReservationModel(
      idReservation: data['idReservation'],
      idCli: data['id_client'],
      idEmpl: data['id_employe'],
      idModel: data['id_model'],
      dateReservation: DateTime.parse(data['dateReservation']),
    );
  }

 
}
