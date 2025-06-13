import 'package:appmelmar/models/abonnement.dart';
import 'package:appmelmar/models/historique_produit.dart';
import 'package:appmelmar/models/model_produit_service.dart';
import 'package:appmelmar/models/paiement.dart';
import 'package:appmelmar/models/reservation.dart';
import 'package:appmelmar/models/seance.dart';
import 'package:appmelmar/models/secteur.dart';
import 'package:appmelmar/models/tache.dart';
import 'package:appmelmar/models/user.dart';
import'package:appmelmar/models/planning.dart';
import'package:appmelmar/models/presence.dart';
import'package:appmelmar/models/salaire_statut.dart';
import 'package:appmelmar/providers/abonnement_provider.dart';
import 'package:appmelmar/providers/admin_provider.dart';
import 'package:appmelmar/providers/employe_provider.dart';
import 'package:appmelmar/providers/historique_produit_provider.dart';
import 'package:appmelmar/providers/model_produit_service_provider.dart';
import 'package:appmelmar/providers/paiement_provider.dart';
import 'package:appmelmar/providers/planning_provider.dart';
import 'package:appmelmar/providers/reservation_provider.dart';
import 'package:appmelmar/providers/seance_provider.dart';
import 'package:appmelmar/providers/secteur_provider.dart';
import 'package:appmelmar/providers/tache_provider.dart';
import 'package:appmelmar/providers/user_provider.dart';
import 'package:appmelmar/providers/client_provider.dart';
import 'package:appmelmar/providers/presence_provider.dart';
import 'package:appmelmar/providers/salaire_statut_provider.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/foundation.dart';
 // Import des modèles et providers définis précédemment

class DatabaseService {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'app_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Création des tables
        await db.execute('''
          CREATE TABLE Utilisateur (
            id_utilisateur INTEGER PRIMARY KEY,
            nom TEXT,
            prenom TEXT,
            sexe TEXT,
            modifications_utilisateur TEXT,
            image_path TEXT,
            date_naissance TEXT,
            date_creation TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE Client (
            id_client INTEGER PRIMARY KEY,
            id_utilisateur INTEGER,
            login TEXT,
            password TEXT,
            nom TEXT,
            prenom TEXT,
            sexe TEXT,
            date_naissance TEXT,
            date_creation TEXT,
            FOREIGN KEY (id_utilisateur) REFERENCES Utilisateur(id_utilisateur)
          )
        ''');
        await db.execute('''
          CREATE TABLE Employe (
            id_employe INTEGER PRIMARY KEY,
            id_utilisateur INTEGER,
            login TEXT,
            password TEXT,
            id_secteur INTEGER,
            prise_service TEXT,
            salaire REAl,
            nom TEXT,
            prenom TEXT,
            sexe TEXT,
            login TEXT,
            password TEXT,
            date_naissance TEXT,
            date_creation TEXT,
            FOREIGN KEY (id_utilisateur) REFERENCES Utilisateur(id_utilisateur),
            FOREIGN KEY (id_secteur) REFERENCES Secteur(id_secteur)
          )
        ''');
        await db.execute('''
          CREATE TABLE Admin (
            id_admin INTEGER PRIMARY KEY,
            id_utilisateur INTEGER,
            login TEXT,
            password TEXT,
            nom TEXT,
            prenom TEXT,
            sexe TEXT,
            login TEXT,
            password TEXT,
            date_naissance TEXT,
            date_creation TEXT,
            FOREIGN KEY (id_utilisateur) REFERENCES Utilisateur(id_utilisateur)
          )
        ''');
        await db.execute('''
          CREATE TABLE Abonnement (
            id_abonnement INTEGER PRIMARY KEY,
            id_client INTEGER,
            id_employe INTEGER,
            id_secteur INTEGER,
            type TEXT,
            montantU REAL,
            montantT REAL,
            nombre_mois INTEGER,
            date_creation TEXT,
            FOREIGN KEY (id_employe) REFERENCES Employe(id_employe),
            FOREIGN KEY (id_client) REFERENCES Client(id_client),
            FOREIGN KEY (id_secteur) REFERENCES Secteur(id_secteur)
          )
        ''');
        await db.execute('''
          CREATE TABLE Seance (
            id_seance INTEGER PRIMARY KEY,
            id_abonnement INTEGER,
            id_client INTEGER,
            id_employe INTEGER,
            id_secteur INTEGER,
            date_creation TEXT,
            duree TEXT,
            FOREIGN KEY (abonnementId) REFERENCES Abonnement(id_abonnement),
            FOREIGN KEY (id_employe) REFERENCES Employe(id_employe),
            FOREIGN KEY (id_client) REFERENCES Client(id_client),
            FOREIGN KEY (id_secteur) REFERENCES Secteur(id_secteur)
          )
        ''');
        await db.execute('''
          CREATE TABLE Paiement (
            id_paiement INTEGER PRIMARY KEY,
            date_paiement TEXT,
            id_client INTEGER,
            id_employe INTEGER,
            id_model INTEGER,
            montant REAL,
            date_creation TEXT,
            FOREIGN KEY (id_client) REFERENCES Client(id_client),
            FOREIGN KEY (id_employe) REFERENCES Employe(id_employe),
            FOREIGN KEY (id_client) REFERENCES Client(id_client),
            FOREIGN KEY (id_model) REFERENCES Model_produit_services(id_model)
          )
        ''');
        await db.execute('''
          CREATE TABLE Reservation (
            id_reservation INTEGER PRIMARY KEY,
            date_creation TEXT,
            id_client INTEGER,
            id_employe INTEGER,
            id_model INTEGER,
            FOREIGN KEY (id_client) REFERENCES Client(id_client),
            FOREIGN KEY (id_employe) REFERENCES Employe(id_employe),
            FOREIGN KEY (id_model) REFERENCES Model_produit_services(id_model)
          )
        ''');
        await db.execute('''
          CREATE TABLE Secteur (
            id_secteur INTEGER PRIMARY KEY,
            libelle TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE Model_produit_service (
            id_model INTEGER PRIMARY KEY,
            nom_model TEXT,
            champs_model TEXT,
            id_secteur INTEGER,
            image_path TEXT,
            date_creation TEXT,
            FOREIGN KEY (id_secteur) REFERENCES Secteur(id_secteur)
          )
        ''');
        await db.execute('''
          CREATE TABLE Historique_model_produit_service (
            id_historique INTEGER PRIMARY KEY AUTOINCREMENT,
            id_model INTEGER NOT NULL,
            type_action TEXT NOT NULL,
            quantite INTEGER NOT NULL,
            montantU REAL,
            montantT REAL NOT NULL,
            date_creation TEXT NOT NULL,
            id_utilisateur INTEGER,
            commentaire TEXT,
            FOREIGN KEY (id_model) REFERENCES Model_produit_service(id_model)
          )
        ''');
        await db.execute('''
          CREATE TABLE Tache (
           id_tache INTEGER PRIMARY KEY,
            titre TEXT,
            contenu TEXT,
            priorite INTEGER,
            effectuer BOOLEAN,
            id_utilisateur INTEGER,
            date_creation TEXT,
            FOREIGN KEY (id_utilisateur) REFERENCES Utilisateur(id_utilisateur)
          )
        ''');
        await db.execute('''
          CREATE TABLE Planning (
            id_planning INTEGER PRIMARY KEY,
            jours_travail TEXT,
            id_admin INTEGER,
            id_employe INTEGER,
            date_creation TEXT,
            FOREIGN KEY (id_admin) REFERENCES Admin(id_admin),
            FOREIGN KEY (id_employe) REFERENCES Employe(id_employe)
          )
        ''');
        await db.execute('''
          CREATE TABLE Presence (
            id_presence INTEGER PRIMARY KEY,
            presence BOOLEAN,
            motif TEXT,
            id_employe INTEGER,
            date_creation TEXT,
            FOREIGN KEY (id_employe) REFERENCES Employe(id_employe)
          )
        ''');
        await db.execute('''
          CREATE TABLE Salaire_statut (
            id_salaire_statut INTEGER PRIMARY KEY,
            montant REAL,
            date_paie TEXT,
            payer BOOLEAN,
            id_employe INTEGER,
            id_admin INTEGER,
            FOREIGN KEY (id_employe) REFERENCES Employe(id_employe),
            FOREIGN KEY (id_admin) REFERENCES Admin(id_admin)
          )
        ''');
      },
    );
  }

  // CRUD pour User
  Future<void> addUser(UserModel user, UserProvider provider) async {
    final db = await database;
    await db.insert('Utilisateur', {
      'id_utilisateur': user.idUser,
      'nom': user.nom,
      'prenom': user.prenom,
      'sexe': user.sexe,
      'date_naissance': user.dateNaissance.toIso8601String(),
      'date_creation': user.dateCreation.toIso8601String(),
    });
    provider.addUser(user);
    
  }

  Future<UserModel?> getUser(int idUser) async {
    final db = await database;
    List<Map<String,dynamic>> maps = await db.query('Utilisateur', where: 'id_user = ?', whereArgs: [idUser]);
    if (maps.isNotEmpty) {
      return UserModel.fromMap(maps[0]);
    }
    return null;
  }

  Future<List<UserModel>> getAllUsers() async {
    final db = await database;
    List<Map<String,dynamic>> maps = await db.query('Utilisateur');
     return maps.map((map)=> UserModel.fromMap(map)).toList();
    /*return maps.map((map) => UserModel(
          idUser: map['id_user'],
          nom: map['nom'],
          prenom: map['prenom'],
          sexe: map['sexe'],

          dateNaissance: DateTime.parse(map['date_naissance']),
          dateCreation: DateTime.parse(map['date_creation']),
        )).toList();*/
  }

  Future<void> updateUser(UserModel user, UserProvider provider) async {
    final db = await database;
    await db.update(
      'Utilisateur',
      {
        'nom': user.nom,
        'prenom': user.prenom,
        'sexe': user.sexe,
        'modifications':user.updateInfoUser,
        'date_naissance': user.dateNaissance.toIso8601String(),
        'date_creation': user.dateCreation.toIso8601String(),
      },
      where: 'id_user = ?',
      whereArgs: [user.idUser],
    );
    provider.change(user);
  }

  Future<void> deleteUser(int idUser, UserProvider provider) async {
    final db = await database;
    await db.delete('Utilisateur', where: 'id_user = ?', whereArgs: [idUser]);
    provider.removeUser(idUser);
  }

  // CRUD pour CLIENT
  Future<void> addClient(ClientModel client, ClientProvider provider) async {
    final db = await database;
    await db.insert('Client', {
      'id_client': client.idCli,
      'id_user': client.idUser,
      'login': client.login,
      'password': client.password,
      'nom': client.nom,
      'prenom': client.prenom,
      'sexe': client.sexe,
      'modifications':client.updateInfoUser,
      'date_naissance': client.dateNaissance.toIso8601String(),
      'date_creation': client.dateCreation.toIso8601String(),
    });
    provider.addClient(client);
  }

  Future<ClientModel?> getClient(int idCli) async {
    final db = await database;
    List<Map<String,dynamic>> maps = await db.query('Client', where: 'id_client = ?', whereArgs: [idCli]);
    if (maps.isNotEmpty) {
      return ClientModel.fromMap(maps[0]);
    }
    return null;
  }

  Future<List<ClientModel>> getAllClients() async {
    final db = await database;
    List<Map<String,dynamic>> maps = await db.query('Client');
    return maps.map((map) => ClientModel.fromMap(map)).toList();
  }

  Future<void> updateClient(ClientModel client, ClientProvider provider) async {
    final db = await database;
    await db.update(
      'Client',
      {
        'login': client.login,
        'password': client.password,
        'nom': client.nom,
        'prenom': client.prenom,
        'sexe': client.sexe,
        'modifications':client.updateInfoUser,
        'date_naissance': client.dateNaissance.toIso8601String(),
        'date_creation': client.dateCreation.toIso8601String(),
      },
      where: 'id_client = ?',
      whereArgs: [client.idCli],
    );
    provider.change(client);
  }

  Future<void> deleteClient(int idCli, ClientProvider provider) async {
    final db = await database;
    await db.delete('Client', where: 'id_client = ?', whereArgs: [idCli]);
    provider.removeClient(idCli);
  }

  // CRUD pour EMPLOYE
  Future<void> addEmploye(EmployeModel employe, EmployeProvider provider) async {
    final db = await database;
    await db.insert('employes', {
      'idEmpl': employe.idEmpl,
      'idUser': employe.idUser,
      'login': employe.login,
      'password': employe.password,
      'priseService': employe.priseService.toIso8601String(),
      'nom': employe.nom,
      'prenom': employe.prenom,
      'sexe': employe.sexe,
      'modifications':employe.updateInfoUser,
      'dateNaissance': employe.dateNaissance.toIso8601String(),
      'dateCreation': employe.dateCreation.toIso8601String(),
    });
    provider.addEmploye(employe);
  }

  Future<EmployeModel?> getEmploye(int idEmpl) async {
    final db = await database;
    List<Map<String,dynamic>> maps = await db.query('Employe', where: 'id_employe = ?', whereArgs: [idEmpl]);
    if (maps.isNotEmpty) {
      return EmployeModel.fromMap(maps[0]);
    }
    return null;
  }

  Future<List<EmployeModel>> getAllEmployes() async {
    final db = await database;
    List<Map<String,dynamic>> maps = await db.query('Employe');
    return maps.map((map) => EmployeModel.fromMap(map)).toList();
  }

  Future<void> updateEmploye(EmployeModel employe, EmployeProvider provider) async {
    final db = await database;
    await db.update(
      'Employe',
      {
        'prise_service': employe.priseService.toIso8601String(),
        'login': employe.login,
        'password': employe.password,
        'nom': employe.nom,
        'prenom': employe.prenom,
        'sexe': employe.sexe,
        'modifications':employe.updateInfoUser,
        'date_naissance': employe.dateNaissance.toIso8601String(),
        'date_creation': employe.dateCreation.toIso8601String(),
      },
      where: 'id_employe = ?',
      whereArgs: [employe.idEmpl],
    );
    provider.change(employe);
  }

  Future<void> deleteEmploye(int idEmpl, EmployeProvider provider) async {
    final db = await database;
    await db.delete('Employe', where: 'id_employe = ?', whereArgs: [idEmpl]);
    provider.removeEmploye(idEmpl);
  }

  // CRUD pour ADMIN
  Future<void> addAdmin(AdminModel admin, AdminProvider provider) async {
    final db = await database;
    await db.insert('Admin', {
      'id_admin': admin.idAdmin,
      'id_utilisateur': admin.idUser,
      'login': admin.login,
      'password': admin.password,
      'nom': admin.nom,
      'prenom': admin.prenom,
      'sexe': admin.sexe,
      'modifications':admin.updateInfoUser,
      'date_naissance': admin.dateNaissance.toIso8601String(),
      'date_creation': admin.dateCreation.toIso8601String(),
    });
    provider.addAdmin(admin);
  }

  Future<AdminModel?> getAdmin(int idAdmin) async {
    final db = await database;
    List<Map<String,dynamic>> maps = await db.query('Admin', where: 'id_admin = ?', whereArgs: [idAdmin]);
    if (maps.isNotEmpty) {
      return AdminModel.fromMap(maps[0]);
    }
    return null;
  }

  Future<List<AdminModel>> getAllAdmins() async {
    final db = await database;
    List<Map<String,dynamic>> maps = await db.query('Admin');
    return maps.map((map) => AdminModel.fromMap(map)).toList();
  }

  Future<void> updateAdmin(AdminModel admin, AdminProvider provider) async {
    final db = await database;
    await db.update(
      'Admin',
      {
        'login': admin.login,
        'password': admin.password,
        'nom': admin.nom,
        'prenom': admin.prenom,
        'sexe': admin.sexe,
        'modifications':admin.updateInfoUser,
        'date_naissance': admin.dateNaissance.toIso8601String(),
        'date_creation': admin.dateCreation.toIso8601String(),
      },
      where: 'id_admin = ?',
      whereArgs: [admin.idAdmin],
    );
    provider.change(admin);
  }

  Future<void> deleteAdmin(int idAdmin, AdminProvider provider) async {
    final db = await database;
    await db.delete('Admin', where: 'id_admin = ?', whereArgs: [idAdmin]);
    provider.removeAdmin(idAdmin);
  }

  // CRUD pour ABONNEMENT
  Future<void> addAbonnement(AbonnementModel abonnement, AbonnementProvider provider) async {
    final db = await database;
    await db.insert('Abonnement', {
      'id_abonnement': abonnement.idAbonnement,
      'id_client':abonnement.idCli,
      'id_employe':abonnement.idEmpl,
      'id_secteur':abonnement.idSecteur,
      'type': abonnement.type,
      'montantU': abonnement.montantU,
      'montantT': abonnement.montantT,
      'nombre_mois': abonnement.nombreMois,
      'date_creation':abonnement.dateCreation
       // Peut être mis à jour plus tard via addObtenirRelation
    });
    provider.addAbonnement(abonnement);
  }

  Future<AbonnementModel?> getAbonnement(int idAbonnement) async {
    final db = await database;
    List<Map<String,dynamic>> maps = await db.query('Abonnement', where: 'id_abonnement = ?', whereArgs: [idAbonnement]);
    if (maps.isNotEmpty) {
      return AbonnementModel.fromMap(maps[0]);
    }
    return null;
  }

  Future<List<AbonnementModel>> getAllAbonnements() async {
    final db = await database;
    List<Map<String,dynamic>> maps = await db.query('Abonnement');
    return maps.map((map) => AbonnementModel.fromMap(map)).toList();
  }

  Future<void> updateAbonnement(AbonnementModel abonnement, AbonnementProvider provider) async {
    final db = await database;
    await db.update(
      'Abonnement',
      {
        'id_client':abonnement.idCli,
        'id_employe':abonnement.idEmpl,
        'id_secteur':abonnement.idSecteur,
        'type': abonnement.type,
        'montantU': abonnement.montantU,
        'montantT': abonnement.montantT,
        'nombre_mois': abonnement.nombreMois,
      },
      where: 'id_abonnement = ?',
      whereArgs: [abonnement.idAbonnement],
    );
    provider.change(abonnement);
  }

  Future<void> deleteAbonnement(int idAbonnement, AbonnementProvider provider) async {
    final db = await database;
    await db.delete('Abonnement', where: 'id_abonnement = ?', whereArgs: [idAbonnement]);
    provider.removeAbonnement(idAbonnement);
  }

  // CRUD pour SEANCE
  Future<void> addSeance(SeanceModel seance, SeanceProvider provider) async {
    final db = await database;
    await db.insert('Seance', {
      'id_seance': seance.idSeance,
      'id_abonnement':seance.idAbonnement,
      'id_client':seance.idCli,
      'id_employe':seance.idEmpl,
      'id_secteur':seance.idSecteur,
      'dateSeance': seance.dateCreation.toIso8601String(),
      'duree': seance.duree.toIso8601String(),
      'montantT': seance.montantT, // Peut être mis à jour via addLier3Relation
    });
    provider.addSeance(seance);
  }

  Future<SeanceModel?> getSeance(int idSeance) async {
    final db = await database;
    List<Map<String,dynamic>> maps = await db.query('Seance', where: 'id_seance = ?', whereArgs: [idSeance]);
    if (maps.isNotEmpty) {
      return SeanceModel.fromMap(maps[0]);
    }
    return null;
  }

  Future<List<SeanceModel>> getAllSeances() async {
    final db = await database;
    List<Map<String,dynamic>> maps = await db.query('Seance');
    return maps.map((map) => SeanceModel.fromMap(map)).toList();
  }

  Future<void> updateSeance(SeanceModel seance, SeanceProvider provider) async {
    final db = await database;
    await db.update(
      'Seance',
      {
        'id_client':seance.idCli,
        'date_seance': seance.dateCreation.toIso8601String(),
        'duree': seance.duree.toIso8601String(),
        'montantT':seance.montantT
      },
      where: 'id_seance = ?',
      whereArgs: [seance.idSeance],
    );
    provider.change(seance);
  }

  Future<void> deleteSeance(int idSeance, SeanceProvider provider) async {
    final db = await database;
    await db.delete('seances', where: 'id_seance = ?', whereArgs: [idSeance]);
    provider.removeSeance(idSeance);
  }

  // CRUD pour PAIEMENT
  Future<void> addPaiement(PaiementModel paiement, PaiementProvider provider) async {
    final db = await database;
    await db.insert('Paiement', {
      'id_paiement': paiement.idPaiement,
      'id_client':paiement.idCli,
      'id_employe':paiement.idEmpl,
      'date_creation': paiement.dateCreation.toIso8601String(),
      'montant': paiement.montant,
      // Peut être mis à jour via addEffectuerRelation
    });
    provider.addPaiement(paiement);
  }

  Future<PaiementModel?> getPaiement(int idPaiement) async {
    final db = await database;
    List<Map<String,dynamic>> maps = await db.query('Paiement', where: 'id_paiement = ?', whereArgs: [idPaiement]);
    if (maps.isNotEmpty) {
      return PaiementModel.fromMap(maps[0]);
    }
    return null;
  }

  Future<List<PaiementModel>> getAllPaiements() async {
    final db = await database;
    List<Map<String,dynamic>> maps = await db.query('Paiement');
    return maps.map((map) => PaiementModel.fromMap(map)).toList();
  }

  Future<void> updatePaiement(PaiementModel paiement, PaiementProvider provider) async {
    final db = await database;
    await db.update(
      'Paiement',
      {
        'date_creation': paiement.dateCreation.toIso8601String(),
        'montant': paiement.montant,
      },
      where: 'id_paiement = ?',
      whereArgs: [paiement.idPaiement],
    );
    provider.change(paiement);
  }

  Future<void> deletePaiement(int idPaiement, PaiementProvider provider) async {
    final db = await database;
    await db.delete('Paiement', where: 'id_paiement = ?', whereArgs: [idPaiement]);
    provider.removePaiement(idPaiement);
  }

  // CRUD pour RESERVATION
  Future<void> addReservation(ReservationModel reservation, ReservationProvider provider) async {
    final db = await database;
    await db.insert('Reservation', {
      'id_reservation': reservation.idReservation,
      'date_reservation': reservation.dateReservation.toIso8601String(),
      'id_client': null, // Peut être mis à jour via addEnregistrerRelation
      'id_seance': null, // Peut être mis à jour via addLier4Relation
    });
    provider.addReservation(reservation);
  }

  Future<ReservationModel?> getReservation(int idReservation) async {
    final db = await database;
    List<Map<String,dynamic>> maps = await db.query('Reservation', where: 'id_reservation = ?', whereArgs: [idReservation]);
    if (maps.isNotEmpty) {
      return ReservationModel.fromMap(maps[0]);
    }
    return null;
  }

  Future<List<ReservationModel>> getAllReservations() async {
    final db = await database;
    List<Map<String,dynamic>> maps = await db.query('Reservation');
    return maps.map((map) => ReservationModel.fromMap(map)).toList();
  }

  Future<void> updateReservation(ReservationModel reservation, ReservationProvider provider) async {
    final db = await database;
    await db.update(
      'Reservation',
      {
        'date_reservation': reservation.dateReservation.toIso8601String(),
      },
      where: 'id_reservation = ?',
      whereArgs: [reservation.idReservation],
    );
    provider.change(reservation);
  }

  Future<void> deleteReservation(int idReservation, ReservationProvider provider) async {
    final db = await database;
    await db.delete('Reservation', where: 'id_reservation = ?', whereArgs: [idReservation]);
    provider.removeReservation(idReservation);
  }

  // CRUD pour SECTEUR
  Future<void> addSecteur(SecteurModel secteur, SecteurProvider provider) async {
    final db = await database;
    await db.insert('Secteur', {
      'id_secteur': secteur.idSecteur,
      'libelle': secteur.libelle,
    });
    provider.addSecteur(secteur);
  }

  Future<SecteurModel?> getSecteur(int idSecteur) async {
    final db = await database;
    List<Map<String,dynamic>> maps = await db.query('Secteur', where: 'id_secteur = ?', whereArgs: [idSecteur]);
    if (maps.isNotEmpty) {
      return SecteurModel.fromMap(maps[0]);
    }
    return null;
  }

  Future<List<SecteurModel>> getAllSecteurs() async {
    final db = await database;
    List<Map<String,dynamic>> maps = await db.query('Secteur');
    return maps.map((map) => SecteurModel.fromMap(map)).toList();
  }

  Future<void> updateSecteur(SecteurModel secteur, SecteurProvider provider) async {
    final db = await database;
    await db.update(
      'Secteur',
      {
        'libelle': secteur.libelle,
      },
      where: 'id_secteur = ?',
      whereArgs: [secteur.idSecteur],
    );
    provider.change(secteur);
  }

  Future<void> deleteSecteur(int idSecteur, SecteurProvider provider) async {
    final db = await database;
    await db.delete('Secteur', where: 'id_secteur = ?', whereArgs: [idSecteur]);
    provider.removeSecteur(idSecteur);
  }

  // CRUD pour MODEL_PRODUIT_SERVICE
  Future<void> addModelProduitService(ModelProduitServiceModel modelProduitService, ModelProduitServiceProvider provider) async {
    final db = await database;
    await db.insert('Model_produit_service', {
      'id_model': modelProduitService.idModel,
      'nom_model': modelProduitService.nomModel,
      'champs_model': modelProduitService.champsModel,
      'id_secteur': modelProduitService.idSecteur,
      'image_path':modelProduitService.imagePath,
      'date_creation':modelProduitService.dateCreation.toIso8601String()
    });
    provider.addModelProduitService(modelProduitService);
  }

  Future<ModelProduitServiceModel?> getModelProduitService(int idModel) async {
    final db = await database;
    List<Map<String,dynamic>> maps = await db.query('Model_produit_service', where: 'id_model = ?', whereArgs: [idModel]);
    if (maps.isNotEmpty) {
      return ModelProduitServiceModel.fromMap(maps[0]);
    }
    return null;
  }

  Future<List<ModelProduitServiceModel>> getAllModelProduitServices() async {
    final db = await database;
    List<Map<String,dynamic>> maps = await db.query('Model_produit_service');
    return maps.map((map) => ModelProduitServiceModel.fromMap(map)).toList();
  }

  Future<void> updateModelProduitService(ModelProduitServiceModel modelProduitService, ModelProduitServiceProvider provider) async {
    final db = await database;
    await db.update(
      'Model_produit_service',
      {
        'nomModel': modelProduitService.nomModel,
        'champsModel': modelProduitService.champsModel,
      },
      where: 'id_model = ?',
      whereArgs: [modelProduitService.idModel],
    );
    provider.change(modelProduitService);
  }

  Future<void> deleteModelProduitService(int idModel, ModelProduitServiceProvider provider) async {
    final db = await database;
    await db.delete('Model_produit_service', where: 'id_model = ?', whereArgs: [idModel]);
    provider.removeModelProduitService(idModel);
  }

  // CRUD pour TACHE
  Future<void> addTache(TacheModel tache, TacheProvider provider) async {
    final db = await database;
    await db.insert('Tache', {
      'id_tache': tache.idTache,
      'titre': tache.titre,
      'contenu': tache.contenu,
      'priorite':tache.Priorite,
      'effectuer':tache.effectuer,
      'id_utilisateur':tache.idUser,
      'date_creation':tache.dateCreation.toIso8601String()
    });
    provider.addTache(tache);
  }

  Future<TacheModel?> getTache(int idTache) async {
    final db = await database;
    List<Map<String,dynamic>> maps = await db.query('Tache', where: 'id_tache = ?', whereArgs: [idTache]);
    if (maps.isNotEmpty) {
      return TacheModel.fromMap(maps[0]);
    }
    return null;
  }

  Future<List<TacheModel>> getAllTaches() async {
    final db = await database;
    List<Map<String,dynamic>> maps = await db.query('Tache');
    return maps.map((map) => TacheModel.fromMap(map)).toList();
  }

  Future<void> updateTache(TacheModel tache, TacheProvider provider) async {
    final db = await database;
    await db.update(
      'Tache',
      {
        'titre': tache.titre,
        'contenu': tache.contenu,
        'priorite':tache.Priorite,
        'effectuer':tache.effectuer
      },
      where: 'id_tache = ?',
      whereArgs: [tache.idTache],
    );
    provider.change(tache);
  }

  Future<void> deleteTache(int idTache, TacheProvider provider) async {
    final db = await database;
    await db.delete('Tache', where: 'id_tache = ?', whereArgs: [idTache]);
    provider.removeTache(idTache);
  }

  // CRUD pour PLANNING
  Future<void> addPlanning(PlanningModel planning, PlanningProvider provider) async {
    final db = await database;
    await db.insert('Planning', {
      'id_planning': planning.idPlanning,
      'jours_travail': planning.joursTravail,
      'id_admin': planning.idAdmin,
      'id_employe':planning.idEmpl,
      'date_creation':planning.dateCreation.toIso8601String()
    });
    provider.addPlanning(planning);
  }

  Future<PlanningModel?> getPlanning(int idPlanning) async {
    final db = await database;
    List<Map<String,dynamic>> maps = await db.query('Planning', where: 'id_planning = ?', whereArgs: [idPlanning]);
    if (maps.isNotEmpty) {
      return PlanningModel.fromMap(maps[0]);
    }
    return null;
  }

  Future<List<PlanningModel>> getAllPlannings() async {
    final db = await database;
    List<Map<String,dynamic>> maps = await db.query('Planning');
    return maps.map((map) => PlanningModel.fromMap(map)).toList();
  }

  Future<void> updatePlanning(PlanningModel planning, PlanningProvider provider) async {
    final db = await database;
    await db.update(
      'Planning',
      {
        'jours_travail': planning.joursTravail,
      },
      where: 'id_planning = ?',
      whereArgs: [planning.idPlanning],
    );
    provider.change(planning);
  }

  Future<void> deletePlanning(int idPlanning, PlanningProvider provider) async {
    final db = await database;
    await db.delete('Planning', where: 'id_planning = ?', whereArgs: [idPlanning]);
    provider.removePlanning(idPlanning);
  }

  // CRUD pour PRESENCE
  Future<void> addPresence(PresenceModel presence, PresenceProvider provider) async {
    final db = await database;
    await db.insert('Presence', {
      'id_presence': presence.idPresence,
      'id_employe':presence.idEmpl,
      'presence': presence.presence ? 1 : 0,
      'motif': presence.motif,
      'date_creation':presence.dateCreation.toIso8601String()
    });
    provider.addPresence(presence);
  }

  Future<PresenceModel?> getPresence(int idPresence) async {
    final db = await database;
    List<Map<String,dynamic>> maps = await db.query('Presence', where: 'id_presence = ?', whereArgs: [idPresence]);
    if (maps.isNotEmpty) {
      return PresenceModel.fromMap(maps[0]);
    }
    return null;
  }

  Future<List<PresenceModel>> getAllPresences() async {
    final db = await database;
    List<Map<String,dynamic>> maps = await db.query('Presence');
    return maps.map((map) => PresenceModel.fromMap(map)).toList();
  }

  Future<void> updatePresence(PresenceModel presence, PresenceProvider provider) async {
    final db = await database;
    await db.update(
      'Presence',
      {
        //'presence': presence.presence ? 1 : 0,
        'motif': presence.motif,
      },
      where: 'id_presence = ?',
      whereArgs: [presence.idPresence],
    );
    provider.change(presence);
  }

  Future<void> deletePresence(int idPresence, PresenceProvider provider) async {
    final db = await database;
    await db.delete('presences', where: 'id_presence = ?', whereArgs: [idPresence]);
    provider.removePresence(idPresence);
  }

  // CRUD pour SALAIRE_STATUT
  Future<void> addSalaireStatut(SalaireStatutModel salaireStatut, SalaireStatutProvider provider) async {
    final db = await database;
    await db.insert('Salaire_statut', {
      'id_salaire_statut': salaireStatut.idSalaireStatut,
      'payer': salaireStatut.payer ? 1 : 0,
      'adminId': null, // Peut être mis à jour via addConsulterRelation
    });
    provider.addSalaireStatut(salaireStatut);
  }

  Future<SalaireStatutModel?> getSalaireStatut(int idSalaireStatut) async {
    final db = await database;
    List<Map<String,dynamic>> maps = await db.query('Salaire_statut', where: 'id_salaire_statut = ?', whereArgs: [idSalaireStatut]);
    if (maps.isNotEmpty) {
      return SalaireStatutModel.fromMap(maps[0]);
    }
    return null;
  }

  Future<List<SalaireStatutModel>> getAllSalaireStatuts() async {
    final db = await database;
    List<Map<String,dynamic>> maps = await db.query('Salaire_statut');
    return maps.map((map) => SalaireStatutModel.fromMap(map)).toList();
  }

  Future<void> updateSalaireStatut(SalaireStatutModel salaireStatut, SalaireStatutProvider provider) async {
    final db = await database;
    await db.update(
      'Salaire_statut',
      {
        'payer': salaireStatut.payer ? 1 : 0,
      },
      where: 'id_salaire_statut = ?',
      whereArgs: [salaireStatut.idSalaireStatut],
    );
    provider.change(salaireStatut);
  }

  Future<void> deleteSalaireStatut(int idSalaireStatut, SalaireStatutProvider provider) async {
    final db = await database;
    await db.delete('Salaire_statut', where: 'id_salaire_statut = ?', whereArgs: [idSalaireStatut]);
    provider.removeSalaireStatut(idSalaireStatut);
  }

  //CRUD pour l'historique des produits
Future<void> addHistoriqueProduit(HistoriquePModel histo, HistoriqueProduitProvider provider) async {
    final db = await database;
    await db.insert('Historique_model_produit_service', {
      'id_historique':histo.idHistorique,
      'id_model':histo.idModel,
      'id_utilisateur':histo.idUser,
      'type_action':histo.typeAction,
      'quantite':histo.quantite,
      'montantU':histo.montantU,
      'montantT':histo.montantT,
      'date_creation':histo.dateCreation.toIso8601String(),
      'commentaire':histo.commentaire
       // Peut être mis à jour via addConsulterRelation
    });
    provider.addHistoriqueP(histo);
  }

  Future<HistoriquePModel?> getHistoriqueProduit(int idHisto) async {
    final db = await database;
    List<Map<String,dynamic>> maps = await db.query('Historique_model_produit_service', where: 'id_historique = ?', whereArgs: [idHisto]);
    if (maps.isNotEmpty) {
      return HistoriquePModel.fromMap(maps[0]);
    }
    return null;
  }

  Future<List<HistoriquePModel>> getAllHistoriqueProduit() async {
    final db = await database;
    List<Map<String,dynamic>> maps = await db.query('Historique_model_produit_service');
    return maps.map((map) => HistoriquePModel.fromMap(map)).toList();
  }

  Future<void> updateHistoriqueProduit(HistoriquePModel histo, HistoriqueProduitProvider provider) async {
    final db = await database;
    await db.update(
      'Historique_model_produit_service',
      {
       'quantite':histo.quantite,
      },
      where: 'id_historique = ?',
      whereArgs: [histo.idHistorique],
    );
    provider.change(histo);
  }

  Future<void> deleteHistoriqueProduit(int idHisto, HistoriqueProduitProvider provider) async {
    final db = await database;
    await db.delete('Historique_model_produit_service', where: 'id_historique = ?', whereArgs: [idHisto]);
    provider.removeHistoriqueP(idHisto);
  }


  // New Queries for Requested Functionalities

  // Get absences of an employee during their work period
  Future<List<PresenceModel>> getEmployeeAbsences(int idEmploye, String startDate, String endDate) async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'Presence',
      where: 'id_employe = ? AND presence = ? AND date_presence BETWEEN ? AND ?',
      whereArgs: [idEmploye, 0, startDate, endDate],
    );
    return maps.map((map) => PresenceModel.fromMap(map)).toList();
  }

  // Get list of planning for an employee
  Future<List<PlanningModel>> getEmployeePlannings(int idEmploye) async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'Planning',
      where: 'id_employe = ?',
      whereArgs: [idEmploye],
    );
    return maps.map((map) => PlanningModel.fromMap(map)).toList();
  }

  // Get list of subscriptions for a client
  Future<List<AbonnementModel>> getClientAbonnements(int idClient) async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'Abonnement',
      where: 'id_client = ?',
      whereArgs: [idClient],
    );
    return maps.map((map) => AbonnementModel.fromMap(map)).toList();
  }

  // Get list of sessions for a client
  Future<List<SeanceModel>> getClientSeances(int idClient) async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'Seance',
      where: 'id_client = ?',
      whereArgs: [idClient],
    );
    return maps.map((map) => SeanceModel.fromMap(map)).toList();
  }

  // Get list of payments for a client
  Future<List<PaiementModel>> getClientPaiements(int idClient) async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'Paiement',
      where: 'id_client = ?',
      whereArgs: [idClient],
    );
    return maps.map((map) => PaiementModel.fromMap(map)).toList();
  }

  // Get list of reservations for a client
  Future<List<ReservationModel>> getClientReservations(int idClient) async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'Reservation',
      where: 'id_client = ?',
      whereArgs: [idClient],
    );
    return maps.map((map) => ReservationModel.fromMap(map)).toList();
  }
  

  // New Statistical Queries

  // Get the employee with the highest revenue contribution in a period
  Future<Map<String, dynamic>?> getTopRevenueEmployee(String startDate, String endDate) async {
    final db = await database;
    List<Map<String, dynamic>> results = await db.rawQuery('''
      SELECT e.id_employe, e.nom, e.prenom, SUM(p.montant) as total_revenue
      FROM Employe e
      JOIN Paiement p ON e.id_employe = p.id_employe
      WHERE p.date_paiement BETWEEN ? AND ?
      GROUP BY e.id_employe, e.nom, e.prenom
      ORDER BY total_revenue DESC
      LIMIT 1
    ''', [startDate, endDate]);
    if (results.isNotEmpty) {
      return {
        'id_employe': results[0]['id_employe'],
        'nom': results[0]['nom'],
        'prenom': results[0]['prenom'],
        'total_revenue': results[0]['total_revenue'],
      };
    }
    return null;
  }

  // Get the most sold product or service (based on reservation counts)
  Future<Map<String, dynamic>?> getMostSoldProductService(String startDate, String endDate) async {
    final db = await database;
    List<Map<String, dynamic>> results = await db.rawQuery('''
      SELECT m.id_model, m.nom_model, COUNT(r.id_reservation) as sale_count
      FROM Model_produit_service m
      JOIN Reservation r ON m.id_model = r.id_model
      WHERE r.date_reservation BETWEEN ? AND ?
      GROUP BY m.id_model, m.nom_model
      ORDER BY sale_count DESC
      LIMIT 1
    ''', [startDate, endDate]);
    if (results.isNotEmpty) {
      return {
        'id_model': results[0]['id_model'],
        'nom_model': results[0]['nom_model'],
        'sale_count': results[0]['sale_count'],
      };
    }
    return null;
  }

  // Get percentage of total revenue per product or service in a period
  Future<List<Map<String, dynamic>>> getRevenuePercentageByProductService(String startDate, String endDate) async {
    final db = await database;
    // First, get total revenue
    List<Map<String, dynamic>> totalRevenueResult = await db.rawQuery('''
      SELECT SUM(montant) as total_revenue
      FROM Paiement
      WHERE date_paiement BETWEEN ? AND ?
    ''', [startDate, endDate]);
    double totalRevenue = totalRevenueResult.isNotEmpty ? (totalRevenueResult[0]['total_revenue'] ?? 0.0) : 0.0;

    // Then, get revenue per product/service
    List<Map<String, dynamic>> results = await db.rawQuery('''
      SELECT m.id_model, m.nom_model, SUM(p.montant) as product_revenue
      FROM Model_produit_service m
      JOIN Paiement p ON m.id_model = p.id_model
      WHERE p.date_paiement BETWEEN ? AND ?
      GROUP BY m.id_model, m.nom_model
    ''', [startDate, endDate]);

    // Calculate percentage for each product/service
    return results.map((result) {
      double productRevenue = result['product_revenue'] ?? 0.0;
      double percentage = totalRevenue > 0 ? (productRevenue / totalRevenue) * 100 : 0.0;
      return {
        'id_model': result['id_model'],
        'nom_model': result['nom_model'],
        'product_revenue': productRevenue,
        'percentage': percentage,
      };
    }).toList();
  }
  
}