import 'package:flutter/foundation.dart';
import '../models/produit_service.dart';

class ProduitServiceProvider with ChangeNotifier {
  List<ProduitServiceModel> _produitServices = [];
  ProduitServiceModel? _produitService;

  List<ProduitServiceModel> get produitServices => _produitServices;
  ProduitServiceModel? get produitService => _produitService;

  void addProduitService(ProduitServiceModel produitService) {
    _produitServices.add(produitService);
    notifyListeners();
  }

  void setProduitService(ProduitServiceModel produitService) {
    _produitService = produitService;
    notifyListeners();
  }

  void removeProduitService(int idProduitService) {
    _produitServices.removeWhere((produitService) => produitService.idProduitService == idProduitService);
    notifyListeners();
  }

  void clearProduitService() {
    _produitService = null;
    notifyListeners();
  }

  void change(ProduitServiceModel produitServiceNew) {
    for (int i = 0; i < _produitServices.length; i++) {
      if (_produitServices[i].idProduitService == produitServiceNew.idProduitService) {
        _produitServices[i] = produitServiceNew;
        notifyListeners();
        break;
      }
    }
    if (_produitService?.idProduitService == produitServiceNew.idProduitService) {
      _produitService = produitServiceNew;
      notifyListeners();
    }
  }
}
