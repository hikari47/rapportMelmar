import 'package:flutter/foundation.dart';
import '../models/seance.dart';

// Provider pour NewModel
class NewModelProvider with ChangeNotifier {
  List<NewModel> _news = [];
  NewModel? _newModel;

  List<NewModel> get news => _news;
  NewModel? get newModel => _newModel;

  void addNewModel(NewModel newModel) {
    _news.add(newModel);
    notifyListeners();
  }

  void setNewModel(NewModel newModel) {
    _newModel = newModel;
    notifyListeners();
  }

  void removeNewModel(int id) {
    _news.removeWhere((n) => n.id == id);
    notifyListeners();
  }

  void clearNewModel() {
    _newModel = null;
    notifyListeners();
  }

  void change(NewModel newModel) {
    for (int i = 0; i < _news.length; i++) {
      if (_news[i].id == newModel.id) {
        _news[i] = newModel;
        notifyListeners();
        break;
      }
    }
    if (_newModel?.id == newModel.id) {
      _newModel = newModel;
      notifyListeners();
    }
  }
}

