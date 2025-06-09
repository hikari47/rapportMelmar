import 'package:flutter/foundation.dart';
import '../models/secteur.dart';

class SecteurProvider with ChangeNotifier {
  List<SecteurModel> _secteurs = [];
  SecteurModel? _secteur;

  List<SecteurModel> get secteurs => _secteurs;
  SecteurModel? get secteur => _secteur;

  void addSecteur(SecteurModel secteur) {
    _secteurs.add(secteur);
    notifyListeners();
  }

  void setSecteur(SecteurModel secteur) {
    _secteur = secteur;
    notifyListeners();
  }

  void removeSecteur(int idSecteur) {
    _secteurs.removeWhere((secteur) => secteur.idSecteur == idSecteur);
    notifyListeners();
  }

  void clearSecteur() {
    _secteur = null;
    notifyListeners();
  }

  void change(SecteurModel secteurNew) {
    for (int i = 0; i < _secteurs.length; i++) {
      if (_secteurs[i].idSecteur == secteurNew.idSecteur) {
        _secteurs[i] = secteurNew;
        notifyListeners();
        break;
      }
    }
    if (_secteur?.idSecteur == secteurNew.idSecteur) {
      _secteur = secteurNew;
      notifyListeners();
    }
  }
}
