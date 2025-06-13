import 'package:flutter/foundation.dart';
import '../models/user.dart';

class UserProvider extends ChangeNotifier {
  List<UserModel> _users = [];
  UserModel? _user;

  List<UserModel> get users => _users;
  UserModel? get user => _user;

  void addUser(UserModel user) {
    _users.add(user);
    notifyListeners();
  }

  void setUser(UserModel user) {
    _user = user;
    notifyListeners();
  }

  void removeUser(int idUser) {
    _users.removeWhere((user) => user.idUser == idUser);
    notifyListeners();
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }

  void change(UserModel userNew) {
    for (int i = 0; i < _users.length; i++) {
      if (_users[i].idUser == userNew.idUser) {
        _users[i] = userNew;
        notifyListeners();
        break;
      }
    }
    if (_user?.idUser == userNew.idUser) {
      _user = userNew;
      notifyListeners();
    }
  }
}
