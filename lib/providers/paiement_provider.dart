import 'package:flutter/foundation.dart';
import '../models/paiement.dart';

class PaiementProvider with ChangeNotifier {
  List<PaiementModel> _paiements = [];
  PaiementModel? _paiement;

  List<PaiementModel> get paiements => _paiements;
  PaiementModel? get paiement => _paiement;

  void addPaiement(PaiementModel paiement) {
    _paiements.add(paiement);
    notifyListeners();
  }

  void setPaiement(PaiementModel paiement) {
    _paiement = paiement;
    notifyListeners();
  }

  void removePaiement(int idPaiement) {
    _paiements.removeWhere((paiement) => paiement.idPaiement == idPaiement);
    notifyListeners();
  }

  void clearPaiement() {
    _paiement = null;
    notifyListeners();
  }

  void change(PaiementModel paiementNew) {
    for (int i = 0; i < _paiements.length; i++) {
      if (_paiements[i].idPaiement == paiementNew.idPaiement) {
        _paiements[i] = paiementNew;
        notifyListeners();
        break;
      }
    }
    if (_paiement?.idPaiement == paiementNew.idPaiement) {
      _paiement = paiementNew;
      notifyListeners();
    }
  }
}
