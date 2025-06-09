class ReservationModel {
  final int idReservation;
  final DateTime dateReservation;

  ReservationModel({
    required this.idReservation,
    required this.dateReservation,
  });

  factory ReservationModel.fromFirebase(Map<String, dynamic> data) {
    return ReservationModel(
      idReservation: data['idReservation'],
      dateReservation: DateTime.parse(data['dateReservation']),
    );
  }

  factory ReservationModel.fromSqflite(Map<String, dynamic> data) {
    return ReservationModel(
      idReservation: data['idReservation'],
      dateReservation: DateTime.parse(data['dateReservation']),
    );
  }
}
