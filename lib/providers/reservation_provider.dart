import 'package:flutter/foundation.dart';
import '../models/reservation.dart';

class ReservationProvider with ChangeNotifier {
  List<ReservationModel> _reservations = [];
  ReservationModel? _reservation;

  List<ReservationModel> get reservations => _reservations;
  ReservationModel? get reservation => _reservation;

  void addReservation(ReservationModel reservation) {
    _reservations.add(reservation);
    notifyListeners();
  }

  void setReservation(ReservationModel reservation) {
    _reservation = reservation;
    notifyListeners();
  }

  void removeReservation(int idReservation) {
    _reservations.removeWhere((reservation) => reservation.idReservation == idReservation);
    notifyListeners();
  }

  void clearReservation() {
    _reservation = null;
    notifyListeners();
  }

  void change(ReservationModel reservationNew) {
    for (int i = 0; i < _reservations.length; i++) {
      if (_reservations[i].idReservation == reservationNew.idReservation) {
        _reservations[i] = reservationNew;
        notifyListeners();
        break;
      }
    }
    if (_reservation?.idReservation == reservationNew.idReservation) {
      _reservation = reservationNew;
      notifyListeners();
    }
  }
}
