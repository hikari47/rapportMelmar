import 'package:flutter/foundation.dart';
import '../models/user.dart';
import '../models/planning.dart';
// Importez ici d'autres modèles si besoin

class DynamicProvider extends ChangeNotifier {
  List<dynamic> _objects = [];
  dynamic _object;

  List<dynamic> get objects => _objects;
  dynamic get object => _object;

  void addObject(dynamic obj) {
    _objects.add(obj);
    notifyListeners();
  }

  void setObject(dynamic obj) {
    _object = obj;
    notifyListeners();
  }

  void removeObjectById(dynamic id) {
    _objects.removeWhere((obj) => _getId(obj) == id);
    notifyListeners();
  }

  void clearObject() {
    _object = null;
    notifyListeners();
  }

  void change(dynamic newObj) {
    final newId = _getId(newObj);
    for (int i = 0; i < _objects.length; i++) {
      if (_getId(_objects[i]) == newId) {
        _objects[i] = newObj;
        notifyListeners();
        break;
      }
    }
    if (_object != null && _getId(_object) == newId) {
      _object = newObj;
      notifyListeners();
    }
  }

  /// Méthode pour identifier un objet par son id, selon son type
  dynamic _getId(dynamic obj) {
    if (obj is UserModel) {
      return obj.idUser;
    } else if (obj is PlanningModel) {
      return obj.idPlanning;
    }
    // Ajoutez ici d'autres types si besoin
    return null;
  }

  /// Trouve un objet par son id, quel que soit son type
  dynamic findObjectById(dynamic id) {
    return _objects.firstWhere(
      (obj) => _getId(obj) == id,
      orElse: () => null,
    );
  }
}
