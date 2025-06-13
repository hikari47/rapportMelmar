import 'package:flutter/foundation.dart';
import '../models/user.dart';

class AdminProvider with ChangeNotifier {
  List<AdminModel> _admins = [];
  AdminModel? _admin;

  List<AdminModel> get admins => _admins;
 AdminModel? get admin => _admin;

  void addAdmin(AdminModel admin) {
    _admins.add(admin);
    notifyListeners();
  }

  void setAdmin(AdminModel admin) {
    _admin = admin;
    notifyListeners();
  }

  void removeAdmin(int idAd) {
    _admins.removeWhere((admin) => admin.idAdmin == idAd);
    notifyListeners();
  }

  void clearAdmin() {
    _admin = null;
    notifyListeners();
  }

  void change(AdminModel adminNew) {
    for (int i = 0; i < _admins.length; i++) {
      if (_admins[i].idAdmin == adminNew.idAdmin) {
        _admins[i] = adminNew;
        notifyListeners();
        break;
      }
    }
    if (_admin?.idAdmin == adminNew.idAdmin) {
      _admin = adminNew;
      notifyListeners();
    }
  }
}
