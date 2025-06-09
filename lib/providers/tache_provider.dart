import 'package:flutter/foundation.dart';
import '../models/tache.dart';

class TacheProvider with ChangeNotifier {
  List<TacheModel> _taches = [];
  TacheModel? _tache;

  List<TacheModel> get taches => _taches;
  TacheModel? get tache => _tache;

  void addTache(TacheModel tache) {
    _taches.add(tache);
    notifyListeners();
  }

  void setTache(TacheModel tache) {
    _tache = tache;
    notifyListeners();
  }

  void removeTache(int idTache) {
    _taches.removeWhere((tache) => tache.idTache == idTache);
    notifyListeners();
  }

  void clearTache() {
    _tache = null;
    notifyListeners();
  }

  void change(TacheModel tacheNew) {
    for (int i = 0; i < _taches.length; i++) {
      if (_taches[i].idTache == tacheNew.idTache) {
        _taches[i] = tacheNew;
        notifyListeners();
        break;
      }
    }
    if (_tache?.idTache == tacheNew.idTache) {
      _tache = tacheNew;
      notifyListeners();
    }
  }
}
