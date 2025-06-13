import 'package:flutter/foundation.dart';
import '../models/user.dart';

class EmployeProvider extends ChangeNotifier {
  List<EmployeModel> _employees = [];
  EmployeModel? _employee;

  List<EmployeModel> get employees => _employees;
  EmployeModel? get employee => _employee;

  void addEmploye(EmployeModel employe) {
    _employees.add(employe);
    notifyListeners();
  }

  void setEmploye(EmployeModel employe) {
    _employee = employe;
    notifyListeners();
  }

  void removeEmploye(int idEmpl) {
    _employees.removeWhere((employee) => employee.idEmpl == idEmpl);
    notifyListeners();
  }

  void clearEmploye() {
    _employee = null;
    notifyListeners();
  }

  void change(EmployeModel employeeNew) {
    for (int i = 0; i < _employees.length; i++) {
      if (_employees[i].idEmpl == employeeNew.idEmpl) {
        _employees[i] = employeeNew;
        notifyListeners();
        break;
      }
    }
    if (_employee?.idEmpl == employeeNew.idEmpl) {
      _employee = employeeNew;
      notifyListeners();
    }
  }
}
