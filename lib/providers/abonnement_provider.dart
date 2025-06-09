import 'package:flutter/foundation.dart';
import '../models/abonnement.dart';

class AbonnementProvider with ChangeNotifier {
  List<AbonnementModel> _abonnements = [];
  AbonnementModel? _abonnement;

  List<AbonnementModel> get abonnements => _abonnements;
  AbonnementModel? get abonnement => _abonnement;

  void addAbonnement(AbonnementModel abonnement) {
    _abonnements.add(abonnement);
    notifyListeners();
  }

  void setAbonnement(AbonnementModel abonnement) {
    _abonnement = abonnement;
    notifyListeners();
  }

  void removeAbonnement(int idAbonnement) {
    _abonnements.removeWhere((abonnement) => abonnement.idAbonnement == idAbonnement);
    notifyListeners();
  }

  void clearAbonnement() {
    _abonnement = null;
    notifyListeners();
  }

  void change(AbonnementModel abonnementNew) {
    for (int i = 0; i < _abonnements.length; i++) {
      if (_abonnements[i].idAbonnement == abonnementNew.idAbonnement) {
        _abonnements[i] = abonnementNew;
        notifyListeners();
        break;
      }
    }
    if (_abonnement?.idAbonnement == abonnementNew.idAbonnement) {
      _abonnement = abonnementNew;
      notifyListeners();
    }
  }
}
