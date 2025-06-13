import 'package:flutter/foundation.dart';
import '../models/user.dart';

class ClientProvider with ChangeNotifier {
  List<ClientModel> _clients = [];
  ClientModel? _client;

  List<ClientModel> get clients => _clients;
  UserModel? get client => _client;

  void addClient(ClientModel client) {
    _clients.add(client);
    notifyListeners();
  }

  void setClient(ClientModel client) {
    _client = client;
    notifyListeners();
  }

  void removeClient(int idCli) {
    _clients.removeWhere((client) => client.idCli == idCli);
    notifyListeners();
  }

  void clearClient() {
    _client = null;
    notifyListeners();
  }

  void change(ClientModel clientNew) {
    for (int i = 0; i < _clients.length; i++) {
      if (_clients[i].idCli == clientNew.idCli) {
        _clients[i] = clientNew;
        notifyListeners();
        break;
      }
    }
    if (_client?.idCli == clientNew.idCli) {
      _client = clientNew;
      notifyListeners();
    }
  }
}
