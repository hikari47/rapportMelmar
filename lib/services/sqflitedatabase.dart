import 'package:appmelmar/models/client_model.dart';
import 'package:appmelmar/models/user_model.dart';
import 'package:appmelmar/providers/client_model_provider.dart';
import 'package:appmelmar/providers/user_model_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/foundation.dart';


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
          CREATE TABLE utilisateur (
            id_utilisateur INTEGER PRIMARY KEY,
            nom TEXT,
            prenom TEXT,
            sexe TEXT,
            date_naissance TEXT,
            date_creation TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE clients (
            idCli INTEGER PRIMARY KEY,
            idUser INTEGER,
            login TEXT,
            password TEXT,
            nom TEXT,
            prenom TEXT,
            sexe TEXT,
            dateNaissance TEXT,
            dateCreation TEXT,
            FOREIGN KEY (idUser) REFERENCES users(idUser)
          )
        ''');
       
      },
    );
  }

  // CRUD pour USER
  Future<void> addUser(UserModel user, UserProvider provider) async {
    final db = await database;
    await db.insert('users', {
      'idUser': user.idUser,
      'nom': user.nom,
      'prenom': user.prenom,
      'sexe': user.sexe,
      'dateNaissance': user.dateNaissance.toIso8601String(),
      'dateCreation': user.dateCreation.toIso8601String(),
    });
    provider.addUser(user);
  }

  Future<UserModel?> getUser(int idUser) async {
    final db = await database;
    List<Map> maps = await db.query('users', where: 'idUser = ?', whereArgs: [idUser]);
    if (maps.isNotEmpty) {
     // return UserModel.fromMap(maps);//cette presente une erreur
     return UserModel(
        idUser: maps[0]['idUser'],
        nom: maps[0]['nom'],
        prenom: maps[0]['prenom'],
        sexe: maps[0]['sexe'],
        dateNaissance: DateTime.parse(maps[0]['dateNaissance']),
        dateCreation: DateTime.parse(maps[0]['dateCreation']),
      );
    }
    return null;
  }

  Future<List<UserModel>> getAllUsers() async {
    final db = await database;
    List<Map> maps = await db.query('users');
    return maps.map((map) => UserModel(
          idUser: map['idUser'],
          nom: map['nom'],
          prenom: map['prenom'],
          sexe: map['sexe'],
          dateNaissance: DateTime.parse(map['dateNaissance']),
          dateCreation: DateTime.parse(map['dateCreation']),
        )).toList();
  }

  Future<void> updateUser(UserModel user, UserProvider provider) async {
    final db = await database;
    await db.update(
      'users',
      {
        'nom': user.nom,
        'prenom': user.prenom,
        'sexe': user.sexe,
        'dateNaissance': user.dateNaissance.toIso8601String(),
        'dateCreation': user.dateCreation.toIso8601String(),
      },
      where: 'idUser = ?',
      whereArgs: [user.idUser],
    );
    provider.change(user);
  }

  Future<void> deleteUser(int idUser, UserProvider provider) async {
    final db = await database;
    await db.delete('users', where: 'idUser = ?', whereArgs: [idUser]);
    provider.removeUser(idUser);
  }

  // CRUD pour CLIENT
  Future<void> addClient(ClientModel client, ClientProvider provider) async {
    final db = await database;
    await db.insert('clients', {
      'idCli': client.idCli,
      'idUser': client.idUser,
      'login': client.login,
      'password': client.password,
      'nom': client.nom,
      'prenom': client.prenom,
      'sexe': client.sexe,
      'dateNaissance': client.dateNaissance.toIso8601String(),
      'dateCreation': client.dateCreation.toIso8601String(),
    });
    provider.addClient(client);
  }

  Future<ClientModel?> getClient(int idCli) async {
    final db = await database;
    List<Map> maps = await db.query('clients', where: 'idCli = ?', whereArgs: [idCli]);
    if (maps.isNotEmpty) {
      return ClientModel(
        idCli: maps[0]['idCli'],
        idUser: maps[0]['idUser'],
        login: maps[0]['login'],
        password: maps[0]['password'],
        nom: maps[0]['nom'],
        prenom: maps[0]['prenom'],
        sexe: maps[0]['sexe'],
        dateNaissance: DateTime.parse(maps[0]['dateNaissance']),
        dateCreation: DateTime.parse(maps[0]['dateCreation']),
      );
    }
    return null;
  }

  Future<List<ClientModel>> getAllClients() async {
    final db = await database;
    List<Map> maps = await db.query('clients');
    return maps.map((map) => ClientModel(
          idCli: map['idCli'],
          idUser: map['idUser'],
          login: map['login'],
          password: map['password'],
          nom: map['nom'],
          prenom: map['prenom'],
          sexe: map['sexe'],
          dateNaissance: DateTime.parse(map['dateNaissance']),
          dateCreation: DateTime.parse(map['dateCreation']),
        )).toList();
  }

  Future<void> updateClient(ClientModel client, ClientProvider provider) async {
    final db = await database;
    await db.update(
      'clients',
      {
        'login': client.login,
        'password': client.password,
        'nom': client.nom,
        'prenom': client.prenom,
        'sexe': client.sexe,
        'dateNaissance': client.dateNaissance.toIso8601String(),
        'dateCreation': client.dateCreation.toIso8601String(),
      },
      where: 'idCli = ?',
      whereArgs: [client.idCli],
    );
    provider.change(client);
  }

  Future<void> deleteClient(int idCli, ClientProvider provider) async {
    final db = await database;
    await db.delete('clients', where: 'idCli = ?', whereArgs: [idCli]);
    provider.removeClient(idCli);
  }

  
}