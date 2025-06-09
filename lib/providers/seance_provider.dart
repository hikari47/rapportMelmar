import 'package:flutter/foundation.dart';
import '../models/seance.dart';

class SeanceProvider with ChangeNotifier {
  List<SeanceModel> _seances = [];
  SeanceModel? _seance;

  List<SeanceModel> get seances => _seances;
  SeanceModel? get seance => _seance;

  void addSeance(SeanceModel seance) {
    _seances.add(seance);
    notifyListeners();
  }

  void setSeance(SeanceModel seance) {
    _seance = seance;
    notifyListeners();
  }

  void removeSeance(int idSeance) {
    _seances.removeWhere((seance) => seance.idSeance == idSeance);
    notifyListeners();
  }

  void clearSeance() {
    _seance = null;
    notifyListeners();
  }

  void change(SeanceModel seanceNew) {
    for (int i = 0; i < _seances.length; i++) {
      if (_seances[i].idSeance == seanceNew.idSeance) {
        _seances[i] = seanceNew;
        notifyListeners();
        break;
      }
    }
    if (_seance?.idSeance == seanceNew.idSeance) {
      _seance = seanceNew;
      notifyListeners();
    }
  }
}
