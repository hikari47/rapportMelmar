class UserModel {
  final int idUser;
  final String nom;
  final String prenom;
  final String sexe;
  final DateTime dateNaissance;
  final DateTime dateCreation;

  UserModel({
    required this.idUser,
    required this.nom,
    required this.prenom,
    required this.sexe,
    required this.dateNaissance,
    required this.dateCreation,
  });

  factory UserModel.fromFirebase(Map<String, dynamic> data) {
    return UserModel(
      idUser: data['idUser'],
      nom: data['nom'],
      prenom: data['prenom'],
      sexe: data['sexe'],
      dateNaissance: DateTime.parse(data['dateNaissance']),
      dateCreation: DateTime.parse(data['dateCreation']),
    );
  }

  factory UserModel.fromSqflite(Map<String, dynamic> data) {
    return UserModel(
      idUser: data['idUser'],
      nom: data['nom'],
      prenom: data['prenom'],
      sexe: data['sexe'],
      dateNaissance: DateTime.parse(data['dateNaissance']),
      dateCreation: DateTime.parse(data['dateCreation']),
    );
  }
}

class ClientModel extends UserModel {
  final int idCli;
  final String login;
  final String password;

  ClientModel({
    required this.idCli,
    required this.login,
    required this.password,
    required int idUser,
    required String nom,
    required String prenom,
    required String sexe,
    required DateTime dateNaissance,
    required DateTime dateCreation,
  }) : super(
          idUser: idUser,
          nom: nom,
          prenom: prenom,
          sexe: sexe,
          dateNaissance: dateNaissance,
          dateCreation: dateCreation,
        );

  factory ClientModel.fromFirebase(Map<String, dynamic> data) {
    return ClientModel(
      idCli: data['idCli'],
      login: data['login'],
      password: data['password'],
      idUser: data['idUser'],
      nom: data['nom'],
      prenom: data['prenom'],
      sexe: data['sexe'],
      dateNaissance: DateTime.parse(data['dateNaissance']),
      dateCreation: DateTime.parse(data['dateCreation']),
    );
  }

  factory ClientModel.fromSqflite(Map<String, dynamic> data) {
    return ClientModel(
      idCli: data['idCli'],
      login: data['login'],
      password: data['password'],
      idUser: data['idUser'],
      nom: data['nom'],
      prenom: data['prenom'],
      sexe: data['sexe'],
      dateNaissance: DateTime.parse(data['dateNaissance']),
      dateCreation: DateTime.parse(data['dateCreation']),
    );
  }
}

class EmployeModel extends UserModel {
  final int idEmpl;
  final DateTime priseService;

  EmployeModel({
    required this.idEmpl,
    required this.priseService,
    required int idUser,
    required String nom,
    required String prenom,
    required String sexe,
    required DateTime dateNaissance,
    required DateTime dateCreation,
  }) : super(
          idUser: idUser,
          nom: nom,
          prenom: prenom,
          sexe: sexe,
          dateNaissance: dateNaissance,
          dateCreation: dateCreation,
        );

  factory EmployeModel.fromFirebase(Map<String, dynamic> data) {
    return EmployeModel(
      idEmpl: data['idEmpl'],
      priseService: DateTime.parse(data['priseService']),
      idUser: data['idUser'],
      nom: data['nom'],
      prenom: data['prenom'],
      sexe: data['sexe'],
      dateNaissance: DateTime.parse(data['dateNaissance']),
      dateCreation: DateTime.parse(data['dateCreation']),
    );
  }

  factory EmployeModel.fromSqflite(Map<String, dynamic> data) {
    return EmployeModel(
      idEmpl: data['idEmpl'],
      priseService: DateTime.parse(data['priseService']),
      idUser: data['idUser'],
      nom: data['nom'],
      prenom: data['prenom'],
      sexe: data['sexe'],
      dateNaissance: DateTime.parse(data['dateNaissance']),
      dateCreation: DateTime.parse(data['dateCreation']),
    );
  }
}

class AdminModel extends UserModel {
  final int idAdmin;

  AdminModel({
    required this.idAdmin,
    required int idUser,
    required String nom,
    required String prenom,
    required String sexe,
    required DateTime dateNaissance,
    required DateTime dateCreation,
  }) : super(
          idUser: idUser,
          nom: nom,
          prenom: prenom,
          sexe: sexe,
          dateNaissance: dateNaissance,
          dateCreation: dateCreation,
        );

  factory AdminModel.fromFirebase(Map<String, dynamic> data) {
    return AdminModel(
      idAdmin: data['idAdmin'],
      idUser: data['idUser'],
      nom: data['nom'],
      prenom: data['prenom'],
      sexe: data['sexe'],
      dateNaissance: DateTime.parse(data['dateNaissance']),
      dateCreation: DateTime.parse(data['dateCreation']),
    );
  }

  factory AdminModel.fromSqflite(Map<String, dynamic> data) {
    return AdminModel(
      idAdmin: data['idAdmin'],
      idUser: data['idUser'],
      nom: data['nom'],
      prenom: data['prenom'],
      sexe: data['sexe'],
      dateNaissance: DateTime.parse(data['dateNaissance']),
      dateCreation: DateTime.parse(data['dateCreation']),
    );
  }
}
