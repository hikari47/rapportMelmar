import 'package:flutter/foundation.dart';
import '../models/presence.dart';

class PresenceProvider with ChangeNotifier {
  List<PresenceModel> _presences = [];
  PresenceModel? _presence;

  List<PresenceModel> get presences => _presences;
  PresenceModel? get presence => _presence;

  void addPresence(PresenceModel presence) {
    _presences.add(presence);
    notifyListeners();
  }

  void setPresence(PresenceModel presence) {
    _presence = presence;
    notifyListeners();
  }

  void removePresence(int idPresence) {
    _presences.removeWhere((presence) => presence.idPresence == idPresence);
    notifyListeners();
  }

  void clearPresence() {
    _presence = null;
    notifyListeners();
  }

  void change(PresenceModel presenceNew) {
    for (int i = 0; i < _presences.length; i++) {
      if (_presences[i].idPresence == presenceNew.idPresence) {
        _presences[i] = presenceNew;
        notifyListeners();
        break;
      }
    }
    if (_presence?.idPresence == presenceNew.idPresence) {
      _presence = presenceNew;
      notifyListeners();
    }
  }
}
