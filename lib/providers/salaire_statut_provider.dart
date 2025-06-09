import 'package:flutter/foundation.dart';
import '../models/salaire_statut.dart';

class SalaireStatutProvider with ChangeNotifier {
  List<SalaireStatutModel> _salaireStatuts = [];
  SalaireStatutModel? _salaireStatut;

  List<SalaireStatutModel> get salaireStatuts => _salaireStatuts;
  SalaireStatutModel? get salaireStatut => _salaireStatut;

  void addSalaireStatut(SalaireStatutModel salaireStatut) {
    _salaireStatuts.add(salaireStatut);
    notifyListeners();
  }

  void setSalaireStatut(SalaireStatutModel salaireStatut) {
    _salaireStatut = salaireStatut;
    notifyListeners();
  }

  void removeSalaireStatut(int idSalaireStatut) {
    _salaireStatuts.removeWhere((salaireStatut) => salaireStatut.idSalaireStatut == idSalaireStatut);
    notifyListeners();
  }

  void clearSalaireStatut() {
    _salaireStatut = null;
    notifyListeners();
  }

  void change(SalaireStatutModel salaireStatutNew) {
    for (int i = 0; i < _salaireStatuts.length; i++) {
      if (_salaireStatuts[i].idSalaireStatut == salaireStatutNew.idSalaireStatut) {
        _salaireStatuts[i] = salaireStatutNew;
        notifyListeners();
        break;
      }
    }
    if (_salaireStatut?.idSalaireStatut == salaireStatutNew.idSalaireStatut) {
      _salaireStatut = salaireStatutNew;
      notifyListeners();
    }
  }
}
