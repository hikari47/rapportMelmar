import 'package:flutter/foundation.dart';
import '../models/planning.dart';

class PlanningProvider with ChangeNotifier {
  List<PlanningModel> _plannings = [];
  PlanningModel? _planning;

  List<PlanningModel> get plannings => _plannings;
  PlanningModel? get planning => _planning;

  void addPlanning(PlanningModel planning) {
    _plannings.add(planning);
    notifyListeners();
  }

  void setPlanning(PlanningModel planning) {
    _planning = planning;
    notifyListeners();
  }

  void removePlanning(int idPlanning) {
    _plannings.removeWhere((planning) => planning.idPlanning == idPlanning);
    notifyListeners();
  }

  void clearPlanning() {
    _planning = null;
    notifyListeners();
  }

  void change(PlanningModel planningNew) {
    for (int i = 0; i < _plannings.length; i++) {
      if (_plannings[i].idPlanning == planningNew.idPlanning) {
        _plannings[i] = planningNew;
        notifyListeners();
        break;
      }
    }
    if (_planning?.idPlanning == planningNew.idPlanning) {
      _planning = planningNew;
      notifyListeners();
    }
  }
}
