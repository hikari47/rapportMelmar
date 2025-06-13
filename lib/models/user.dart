//ne pas oublier de mettre une methode permettant de creer un json en sortie

class UserModel {
  final int idUser;
  final String nom;
  final String prenom;
  final String sexe;
  final String ? updateInfoUser;
  final String ? imagePath;
  final DateTime dateNaissance;
  final DateTime dateCreation;

  UserModel({
    required this.idUser,
    required this.nom,
    required this.prenom,
    required this.sexe,
    required this.updateInfoUser,
    required this.imagePath,
    required this.dateNaissance,
    required this.dateCreation,
  });

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      idUser: data['id_utilisateur'],
      nom: data['nom'],
      prenom: data['prenom'],
      sexe: data['sexe'],
      updateInfoUser: data['modifications_utilisateur'],
      imagePath: data['image_path'],
      dateNaissance: DateTime.parse(data['date_naissance']),
      dateCreation: DateTime.parse(data['date_creation']),
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
    required String updateInfoUser,
    required String imagePath,
    required DateTime dateNaissance,
    required DateTime dateCreation,
  }) : super(
          idUser: idUser,
          nom: nom,
          prenom: prenom,
          sexe: sexe,
          updateInfoUser: updateInfoUser,
          imagePath: imagePath,
          dateNaissance: dateNaissance,
          dateCreation: dateCreation,
        );

  factory ClientModel.fromMap(Map<String, dynamic> data) {
    return ClientModel(
      idCli: data['id_client'],
      login: data['login'],
      password: data['password'],
      idUser: data['id_utilisateur'],
      nom: data['nom'],
      prenom: data['prenom'],
      sexe: data['sexe'],
      updateInfoUser: data['modifications_utilisateur'],
      imagePath: data['image_path'],
      dateNaissance: DateTime.parse(data['date_naissance']),
      dateCreation: DateTime.parse(data['date_creation']),
    );
  }

}

class EmployeModel extends UserModel {
  final int idEmpl;
  final DateTime priseService;
  final String login;
  final String password;

  EmployeModel({
    required this.idEmpl,
    required this.login,
    required this.password,
    required this.priseService,
    required int idUser,
    required String nom,
    required String prenom,
    required String sexe,
    required String updateInfoUser,
    required String imagePath,
    required DateTime dateNaissance,
    required DateTime dateCreation,
  }) : super(
          idUser: idUser,
          nom: nom,
          prenom: prenom,
          sexe: sexe,
          updateInfoUser: updateInfoUser,
          imagePath: imagePath,
          dateNaissance: dateNaissance,
          dateCreation: dateCreation,
        );

  factory EmployeModel.fromMap(Map<String, dynamic> data) {
    return EmployeModel(
      idEmpl: data['idEmpl'],
      login: data['login'],
      password: data['password'],
      priseService: DateTime.parse(data['prise_service']),
      idUser: data['id_utilisateur'],
      nom: data['nom'],
      prenom: data['prenom'],
      sexe: data['sexe'],
      updateInfoUser: data['modifications_utilisateur'],
      imagePath: data['image_path'],
      dateNaissance: DateTime.parse(data['date_naissance']),
      dateCreation: DateTime.parse(data['date_creation']),
    );
  }


}

class AdminModel extends UserModel {
  final int idAdmin;
  final String login;
  final String password;

  AdminModel({
    required this.idAdmin,
    required this.login,
    required this.password,
    required int idUser,
    required String nom,
    required String prenom,
    required String sexe,
    required String updateInfoUser,
    required String imagePath,
    required DateTime dateNaissance,
    required DateTime dateCreation,
  }) : super(
          idUser: idUser,
          nom: nom,
          prenom: prenom,
          sexe: sexe,
          updateInfoUser: updateInfoUser,
          imagePath: imagePath,
          dateNaissance: dateNaissance,
          dateCreation: dateCreation,
        );

  factory AdminModel.fromMap(Map<String, dynamic> data) {
    return AdminModel(
      idAdmin: data['idAdmin'],
      login: data['login'],
      password: data['password'],
      idUser: data['id_utilisateur'],
      nom: data['nom'],
      prenom: data['prenom'],
      sexe: data['sexe'],
      updateInfoUser: data['modifications_utilisateur'],
      imagePath: data['image_path'],
      dateNaissance: DateTime.parse(data['date_naissance']),
      dateCreation: DateTime.parse(data['date_creation']),
    );
  }

 
}
