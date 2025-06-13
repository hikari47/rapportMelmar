import 'package:flutter/foundation.dart';
import '../models/historique_produit.dart';

class HistoriqueProduitProvider with ChangeNotifier {
  List<HistoriquePModel> _histos = [];
  HistoriquePModel? _histo;

  List<HistoriquePModel> get histos => _histos;
  HistoriquePModel? get histo => _histo;

  void addHistoriqueP(HistoriquePModel histo) {
    _histos.add(histo);
    notifyListeners();
  }

  void setHistoriqueP(HistoriquePModel histo) {
    _histo = histo;
    notifyListeners();
  }

  void removeHistoriqueP(int idHisto) {
    _histos.removeWhere((paiement) => paiement.idHistorique == idHisto);
    notifyListeners();
  }

  void clearHistoriqueP() {
    _histo = null;
    notifyListeners();
  }

  void change(HistoriquePModel histoNew) {
    for (int i = 0; i < _histos.length; i++) {
      if (_histos[i].idHistorique == histoNew.idHistorique) {
        _histos[i] =histoNew;
        notifyListeners();
        break;
      }
    }
    if (_histo?.idHistorique==histoNew.idHistorique) {
      _histo = histoNew;
      notifyListeners();
    }
  }
}
