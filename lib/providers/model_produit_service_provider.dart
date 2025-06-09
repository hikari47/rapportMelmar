import 'package:flutter/foundation.dart';
import '../models/model_produit_service.dart';

class ModelProduitServiceProvider with ChangeNotifier {
  List<ModelProduitServiceModel> _modelProduitServices = [];
  ModelProduitServiceModel? _modelProduitService;

  List<ModelProduitServiceModel> get modelProduitServices => _modelProduitServices;
  ModelProduitServiceModel? get modelProduitService => _modelProduitService;

  void addModelProduitService(ModelProduitServiceModel modelProduitService) {
    _modelProduitServices.add(modelProduitService);
    notifyListeners();
  }

  void setModelProduitService(ModelProduitServiceModel modelProduitService) {
    _modelProduitService = modelProduitService;
    notifyListeners();
  }

  void removeModelProduitService(int idModel) {
    _modelProduitServices.removeWhere((modelProduitService) => modelProduitService.idModel == idModel);
    notifyListeners();
  }

  void clearModelProduitService() {
    _modelProduitService = null;
    notifyListeners();
  }

  void change(ModelProduitServiceModel modelProduitServiceNew) {
    for (int i = 0; i < _modelProduitServices.length; i++) {
      if (_modelProduitServices[i].idModel == modelProduitServiceNew.idModel) {
        _modelProduitServices[i] = modelProduitServiceNew;
        notifyListeners();
        break;
      }
    }
    if (_modelProduitService?.idModel == modelProduitServiceNew.idModel) {
      _modelProduitService = modelProduitServiceNew;
      notifyListeners();
    }
  }
}
