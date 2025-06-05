import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:appmelmar/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserM? _user;

  UserM? get user => _user;

  void login(String username, String password,dynamic userFibase) {
    _user = UserM(login: username, password: password,userFb:userFibase);
    notifyListeners(); // Notifie les widgets que l'état a changé
  }
}