import 'package:flutter/foundation.dart';
import '../models/seance.dart';

class EventModelProvider with ChangeNotifier {
  List<EventModel> _events = [];
  EventModel? _event;

  List<EventModel> get events => _events;
  EventModel? get event => _event;

  void addEvent(EventModel event) {
    _events.add(event);
    notifyListeners();
  }

  void setEvent(EventModel event) {
    _event = event;
    notifyListeners();
  }

  void removeEvent(int id) {
    _events.removeWhere((e) => e.id == id);
    notifyListeners();
  }

  void clearEvent() {
    _event = null;
    notifyListeners();
  }

  void change(EventModel eventNew) {
    for (int i = 0; i < _events.length; i++) {
      if (_events[i].id == eventNew.id) {
        _events[i] = eventNew;
        notifyListeners();
        break;
      }
    }
    if (_event?.id == eventNew.id) {
      _event = eventNew;
      notifyListeners();
    }
  }
}
