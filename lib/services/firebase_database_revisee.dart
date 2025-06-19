import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:appmelmar/models/user.dart';
import 'package:appmelmar/models/abonnement.dart';
import 'package:appmelmar/models/seance.dart';
import 'package:appmelmar/models/paiement.dart';
import 'package:appmelmar/models/reservation.dart';
import 'package:appmelmar/models/secteur.dart';
import 'package:appmelmar/models/model_produit_service.dart';
import 'package:appmelmar/models/tache.dart';
import 'package:appmelmar/models/planning.dart';
import 'package:appmelmar/models/presence.dart';
import 'package:appmelmar/models/salaire_statut.dart';
import 'package:appmelmar/models/historique_produit.dart';
import 'package:appmelmar/providers/user_provider.dart';
import 'package:appmelmar/providers/new_provider.dart';
import 'package:appmelmar/providers/event_provider.dart';
import 'package:appmelmar/providers/client_provider.dart';
import 'package:appmelmar/providers/employe_provider.dart';
import 'package:appmelmar/providers/admin_provider.dart';
import 'package:appmelmar/providers/abonnement_provider.dart';
import 'package:appmelmar/providers/seance_provider.dart';
import 'package:appmelmar/providers/paiement_provider.dart';
import 'package:appmelmar/providers/reservation_provider.dart';
import 'package:appmelmar/providers/secteur_provider.dart';
import 'package:appmelmar/providers/model_produit_service_provider.dart';
import 'package:appmelmar/providers/tache_provider.dart';
import 'package:appmelmar/providers/planning_provider.dart';
import 'package:appmelmar/providers/presence_provider.dart';
import 'package:appmelmar/providers/salaire_statut_provider.dart';
import 'package:appmelmar/providers/historique_produit_provider.dart';

class FirebaseDatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // USER CRUD
  Future<void> addUser(UserModel user, UserProvider provider) async {
    await _firestore.collection('Utilisateur').doc(user.idUser.toString()).set(user.toMap());
    provider.addUser(user);
  }

  Future<UserModel?> getUser(int idUser) async {
    final doc = await _firestore.collection('Utilisateur').doc(idUser.toString()).get();
    if (doc.exists) return UserModel.fromMap(doc.data()!);
    return null;
  }

  Future<List<UserModel>> getAllUsers() async {
    final query = await _firestore.collection('Utilisateur').get();
    return query.docs.map((doc) => UserModel.fromMap(doc.data())).toList();
  }

  Future<void> updateUser(UserModel user, UserProvider provider) async {
    await _firestore.collection('Utilisateur').doc(user.idUser.toString()).update(user.toMap());
    provider.change(user);
  }

  Future<void> deleteUser(int idUser, UserProvider provider) async {
    await _firestore.collection('Utilisateur').doc(idUser.toString()).delete();
    provider.removeUser(idUser);
  }

  // CLIENT CRUD
  Future<void> addClient(ClientModel client, ClientProvider provider) async {
    await _firestore.collection('Client').doc(client.idCli.toString()).set(client.toMap());
    provider.addClient(client);
  }

  Future<ClientModel?> getClient(int idCli) async {
    final doc = await _firestore.collection('Client').doc(idCli.toString()).get();
    if (doc.exists) return ClientModel.fromMap(doc.data()!);
    return null;
  }

  Future<List<ClientModel>> getAllClients() async {
    final query = await _firestore.collection('Client').get();
    return query.docs.map((doc) => ClientModel.fromMap(doc.data())).toList();
  }

  Future<void> updateClient(ClientModel client, ClientProvider provider) async {
    await _firestore.collection('Client').doc(client.idCli.toString()).update(client.toMap());
    provider.change(client);
  }

  Future<void> deleteClient(int idCli, ClientProvider provider) async {
    await _firestore.collection('Client').doc(idCli.toString()).delete();
    provider.removeClient(idCli);
  }

  // EMPLOYE CRUD
  Future<void> addEmploye(EmployeModel employe, EmployeProvider provider) async {
    await _firestore.collection('Employe').doc(employe.idEmpl.toString()).set(employe.toMap());
    provider.addEmploye(employe);
  }

  Future<EmployeModel?> getEmploye(int idEmpl) async {
    final doc = await _firestore.collection('Employe').doc(idEmpl.toString()).get();
    if (doc.exists) return EmployeModel.fromMap(doc.data()!);
    return null;
  }

  Future<List<EmployeModel>> getAllEmployes() async {
    final query = await _firestore.collection('Employe').get();
    return query.docs.map((doc) => EmployeModel.fromMap(doc.data())).toList();
  }

  Future<void> updateEmploye(EmployeModel employe, EmployeProvider provider) async {
    await _firestore.collection('Employe').doc(employe.idEmpl.toString()).update(employe.toMap());
    provider.change(employe);
  }

  Future<void> deleteEmploye(int idEmpl, EmployeProvider provider) async {
    await _firestore.collection('Employe').doc(idEmpl.toString()).delete();
    provider.removeEmploye(idEmpl);
  }

  // ADMIN CRUD
  Future<void> addAdmin(AdminModel admin, AdminProvider provider) async {
    await _firestore.collection('Admin').doc(admin.idAdmin.toString()).set(admin.toMap());
    provider.addAdmin(admin);
  }

  Future<AdminModel?> getAdmin(int idAdmin) async {
    final doc = await _firestore.collection('Admin').doc(idAdmin.toString()).get();
    if (doc.exists) return AdminModel.fromMap(doc.data()!);
    return null;
  }

  Future<List<AdminModel>> getAllAdmins() async {
    final query = await _firestore.collection('Admin').get();
    return query.docs.map((doc) => AdminModel.fromMap(doc.data())).toList();
  }

  Future<void> updateAdmin(AdminModel admin, AdminProvider provider) async {
    await _firestore.collection('Admin').doc(admin.idAdmin.toString()).update(admin.toMap());
    provider.change(admin);
  }

  Future<void> deleteAdmin(int idAdmin, AdminProvider provider) async {
    await _firestore.collection('Admin').doc(idAdmin.toString()).delete();
    provider.removeAdmin(idAdmin);
  }

  // ABONNEMENT CRUD
  Future<void> addAbonnement(AbonnementModel abonnement, AbonnementProvider provider) async {
    await _firestore.collection('Abonnement').doc(abonnement.idAbonnement.toString()).set(abonnement.toMap());
    provider.addAbonnement(abonnement);
  }

  Future<AbonnementModel?> getAbonnement(int idAbonnement) async {
    final doc = await _firestore.collection('Abonnement').doc(idAbonnement.toString()).get();
    if (doc.exists) return AbonnementModel.fromMap(doc.data()!);
    return null;
  }

  Future<List<AbonnementModel>> getAllAbonnements() async {
    final query = await _firestore.collection('Abonnement').get();
    return query.docs.map((doc) => AbonnementModel.fromMap(doc.data())).toList();
  }

  Future<void> updateAbonnement(AbonnementModel abonnement, AbonnementProvider provider) async {
    await _firestore.collection('Abonnement').doc(abonnement.idAbonnement.toString()).update(abonnement.toMap());
    provider.change(abonnement);
  }

  Future<void> deleteAbonnement(int idAbonnement, AbonnementProvider provider) async {
    await _firestore.collection('Abonnement').doc(idAbonnement.toString()).delete();
    provider.removeAbonnement(idAbonnement);
  }

  // SEANCE CRUD
  Future<void> addSeance(SeanceModel seance, SeanceProvider provider) async {
    await _firestore.collection('Seance').doc(seance.idSeance.toString()).set(seance.toMap());
    provider.addSeance(seance);
  }

  Future<SeanceModel?> getSeance(int idSeance) async {
    final doc = await _firestore.collection('Seance').doc(idSeance.toString()).get();
    if (doc.exists) return SeanceModel.fromMap(doc.data()!);
    return null;
  }

  Future<List<SeanceModel>> getAllSeances() async {
    final query = await _firestore.collection('Seance').get();
    return query.docs.map((doc) => SeanceModel.fromMap(doc.data())).toList();
  }

  Future<void> updateSeance(SeanceModel seance, SeanceProvider provider) async {
    await _firestore.collection('Seance').doc(seance.idSeance.toString()).update(seance.toMap());
    provider.change(seance);
  }

  Future<void> deleteSeance(int idSeance, SeanceProvider provider) async {
    await _firestore.collection('Seance').doc(idSeance.toString()).delete();
    provider.removeSeance(idSeance);
  }

  // PAIEMENT CRUD
  Future<void> addPaiement(PaiementModel paiement, PaiementProvider provider) async {
    await _firestore.collection('Paiement').doc(paiement.idPaiement.toString()).set(paiement.toMap());
    provider.addPaiement(paiement);
  }

  Future<PaiementModel?> getPaiement(int idPaiement) async {
    final doc = await _firestore.collection('Paiement').doc(idPaiement.toString()).get();
    if (doc.exists) return PaiementModel.fromMap(doc.data()!);
    return null;
  }

  Future<List<PaiementModel>> getAllPaiements() async {
    final query = await _firestore.collection('Paiement').get();
    return query.docs.map((doc) => PaiementModel.fromMap(doc.data())).toList();
  }

  Future<void> updatePaiement(PaiementModel paiement, PaiementProvider provider) async {
    await _firestore.collection('Paiement').doc(paiement.idPaiement.toString()).update(paiement.toMap());
    provider.change(paiement);
  }

  Future<void> deletePaiement(int idPaiement, PaiementProvider provider) async {
    await _firestore.collection('Paiement').doc(idPaiement.toString()).delete();
    provider.removePaiement(idPaiement);
  }

  // RESERVATION CRUD
  Future<void> addReservation(ReservationModel reservation, ReservationProvider provider) async {
    await _firestore.collection('Reservation').doc(reservation.idReservation.toString()).set(reservation.toMap());
    provider.addReservation(reservation);
  }

  Future<ReservationModel?> getReservation(int idReservation) async {
    final doc = await _firestore.collection('Reservation').doc(idReservation.toString()).get();
    if (doc.exists) return ReservationModel.fromMap(doc.data()!);
    return null;
  }

  Future<List<ReservationModel>> getAllReservations() async {
    final query = await _firestore.collection('Reservation').get();
    return query.docs.map((doc) => ReservationModel.fromMap(doc.data())).toList();
  }

  Future<void> updateReservation(ReservationModel reservation, ReservationProvider provider) async {
    await _firestore.collection('Reservation').doc(reservation.idReservation.toString()).update(reservation.toMap());
    provider.change(reservation);
  }

  Future<void> deleteReservation(int idReservation, ReservationProvider provider) async {
    await _firestore.collection('Reservation').doc(idReservation.toString()).delete();
    provider.removeReservation(idReservation);
  }

  // SECTEUR CRUD
  Future<void> addSecteur(SecteurModel secteur, SecteurProvider provider) async {
    await _firestore.collection('Secteur').doc(secteur.idSecteur.toString()).set(secteur.toMap());
    provider.addSecteur(secteur);
  }

  Future<SecteurModel?> getSecteur(int idSecteur) async {
    final doc = await _firestore.collection('Secteur').doc(idSecteur.toString()).get();
    if (doc.exists) return SecteurModel.fromMap(doc.data()!);
    return null;
  }

  Future<List<SecteurModel>> getAllSecteurs() async {
    final query = await _firestore.collection('Secteur').get();
    return query.docs.map((doc) => SecteurModel.fromMap(doc.data())).toList();
  }

  Future<void> updateSecteur(SecteurModel secteur, SecteurProvider provider) async {
    await _firestore.collection('Secteur').doc(secteur.idSecteur.toString()).update(secteur.toMap());
    provider.change(secteur);
  }

  Future<void> deleteSecteur(int idSecteur, SecteurProvider provider) async {
    await _firestore.collection('Secteur').doc(idSecteur.toString()).delete();
    provider.removeSecteur(idSecteur);
  }

  // MODEL_PRODUIT_SERVICE CRUD
  Future<void> addModelProduitService(ModelProduitServiceModel modelProduitService, ModelProduitServiceProvider provider) async {
    await _firestore.collection('Model_produit_service').doc(modelProduitService.idModel.toString()).set(modelProduitService.toMap());
    provider.addModelProduitService(modelProduitService);
  }

  Future<ModelProduitServiceModel?> getModelProduitService(int idModel) async {
    final doc = await _firestore.collection('Model_produit_service').doc(idModel.toString()).get();
    if (doc.exists) return ModelProduitServiceModel.fromMap(doc.data()!);
    return null;
  }

  Future<List<ModelProduitServiceModel>> getAllModelProduitServices() async {
    final query = await _firestore.collection('Model_produit_service').get();
    return query.docs.map((doc) => ModelProduitServiceModel.fromMap(doc.data())).toList();
  }
  
  Future<List<ModelProduitServiceModel>> getModelProduitServicesBySecteur(String idSecteur) async {
  final query = await _firestore
      .collection('Model_produit_service')
      .where('idSecteur', isEqualTo: idSecteur)
      .get();
  return query.docs.map((doc) => ModelProduitServiceModel.fromMap(doc.data())).toList();
}

  Future<List<ModelProduitServiceModel>> getAllModelProduitServicesBySecteur(int idSecteur) async {
    final query = await _firestore
        .collection('Model_produit_service')
        .where('idSecteur', isEqualTo: idSecteur)
        .get();
    return query.docs.map((doc) => ModelProduitServiceModel.fromMap(doc.data())).toList();
  }

  Future<void> updateModelProduitService(ModelProduitServiceModel modelProduitService, ModelProduitServiceProvider provider) async {
    await _firestore.collection('Model_produit_service').doc(modelProduitService.idModel.toString()).update(modelProduitService.toMap());
    provider.change(modelProduitService);
  }

  Future<void> deleteModelProduitService(int idModel, ModelProduitServiceProvider provider) async {
    await _firestore.collection('Model_produit_service').doc(idModel.toString()).delete();
    provider.removeModelProduitService(idModel);
  }

  // TACHE CRUD
  Future<void> addTache(TacheModel tache, TacheProvider provider) async {
    await _firestore.collection('Tache').doc(tache.idTache.toString()).set(tache.toMap());
    provider.addTache(tache);
  }

  Future<TacheModel?> getTache(int idTache) async {
    final doc = await _firestore.collection('Tache').doc(idTache.toString()).get();
    if (doc.exists) return TacheModel.fromMap(doc.data()!);
    return null;
  }

  Future<List<TacheModel>> getAllTaches() async {
    final query = await _firestore.collection('Tache').get();
    return query.docs.map((doc) => TacheModel.fromMap(doc.data())).toList();
  }

  Future<void> updateTache(TacheModel tache, TacheProvider provider) async {
    await _firestore.collection('Tache').doc(tache.idTache.toString()).update(tache.toMap());
    provider.change(tache);
  }

  Future<void> deleteTache(int idTache, TacheProvider provider) async {
    await _firestore.collection('Tache').doc(idTache.toString()).delete();
    provider.removeTache(idTache);
  }

  // PLANNING CRUD
  Future<void> addPlanning(PlanningModel planning, PlanningProvider provider) async {
    await _firestore.collection('Planning').doc(planning.idPlanning.toString()).set(planning.toMap());
    provider.addPlanning(planning);
  }

  Future<PlanningModel?> getPlanning(int idPlanning) async {
    final doc = await _firestore.collection('Planning').doc(idPlanning.toString()).get();
    if (doc.exists) return PlanningModel.fromMap(doc.data()!);
    return null;
  }

  Future<List<PlanningModel>> getAllPlannings() async {
    final query = await _firestore.collection('Planning').get();
    return query.docs.map((doc) => PlanningModel.fromMap(doc.data())).toList();
  }

  Future<void> updatePlanning(PlanningModel planning, PlanningProvider provider) async {
    await _firestore.collection('Planning').doc(planning.idPlanning.toString()).update(planning.toMap());
    provider.change(planning);
  }

  Future<void> deletePlanning(int idPlanning, PlanningProvider provider) async {
    await _firestore.collection('Planning').doc(idPlanning.toString()).delete();
    provider.removePlanning(idPlanning);
  }

  // PRESENCE CRUD
  Future<void> addPresence(PresenceModel presence, PresenceProvider provider) async {
    await _firestore.collection('Presence').doc(presence.idPresence.toString()).set(presence.toMap());
    provider.addPresence(presence);
  }

  Future<PresenceModel?> getPresence(int idPresence) async {
    final doc = await _firestore.collection('Presence').doc(idPresence.toString()).get();
    if (doc.exists) return PresenceModel.fromMap(doc.data()!);
    return null;
  }

  Future<List<PresenceModel>> getAllPresences() async {
    final query = await _firestore.collection('Presence').get();
    return query.docs.map((doc) => PresenceModel.fromMap(doc.data())).toList();
  }

  Future<void> updatePresence(PresenceModel presence, PresenceProvider provider) async {
    await _firestore.collection('Presence').doc(presence.idPresence.toString()).update(presence.toMap());
    provider.change(presence);
  }

  Future<void> deletePresence(int idPresence, PresenceProvider provider) async {
    await _firestore.collection('Presence').doc(idPresence.toString()).delete();
    provider.removePresence(idPresence);
  }

  // SALAIRE_STATUT CRUD
  Future<void> addSalaireStatut(SalaireStatutModel salaireStatut, SalaireStatutProvider provider) async {
    await _firestore.collection('Salaire_statut').doc(salaireStatut.idSalaireStatut.toString()).set(salaireStatut.toMap());
    provider.addSalaireStatut(salaireStatut);
  }

  Future<SalaireStatutModel?> getSalaireStatut(int idSalaireStatut) async {
    final doc = await _firestore.collection('Salaire_statut').doc(idSalaireStatut.toString()).get();
    if (doc.exists) return SalaireStatutModel.fromMap(doc.data()!);
    return null;
  }

  Future<List<SalaireStatutModel>> getAllSalaireStatuts() async {
    final query = await _firestore.collection('Salaire_statut').get();
    return query.docs.map((doc) => SalaireStatutModel.fromMap(doc.data())).toList();
  }

  Future<void> updateSalaireStatut(SalaireStatutModel salaireStatut, SalaireStatutProvider provider) async {
    await _firestore.collection('Salaire_statut').doc(salaireStatut.idSalaireStatut.toString()).update(salaireStatut.toMap());
    provider.change(salaireStatut);
  }

  Future<void> deleteSalaireStatut(int idSalaireStatut, SalaireStatutProvider provider) async {
    await _firestore.collection('Salaire_statut').doc(idSalaireStatut.toString()).delete();
    provider.removeSalaireStatut(idSalaireStatut);
  }

  // HISTORIQUE_PRODUIT CRUD
  Future<void> addHistoriqueProduit(HistoriquePModel histo, HistoriqueProduitProvider provider) async {
    await _firestore.collection('Historique_model_produit_service').doc(histo.idHistorique.toString()).set(histo.toMap());
    provider.addHistoriqueP(histo);
  }

  Future<HistoriquePModel?> getHistoriqueProduit(int idHisto) async {
    final doc = await _firestore.collection('Historique_model_produit_service').doc(idHisto.toString()).get();
    if (doc.exists) return HistoriquePModel.fromMap(doc.data()!);
    return null;
  }

  Future<List<HistoriquePModel>> getAllHistoriqueProduit() async {
    final query = await _firestore.collection('Historique_model_produit_service').get();
    return query.docs.map((doc) => HistoriquePModel.fromMap(doc.data())).toList();
  }

  Future<void> updateHistoriqueProduit(HistoriquePModel histo, HistoriqueProduitProvider provider) async {
    await _firestore.collection('Historique_model_produit_service').doc(histo.idHistorique.toString()).update(histo.toMap());
    provider.change(histo);
  }

  Future<void> deleteHistoriqueProduit(int idHisto, HistoriqueProduitProvider provider) async {
    await _firestore.collection('Historique_model_produit_service').doc(idHisto.toString()).delete();
    provider.removeHistoriqueP(idHisto);
  }

  // --- ADVANCED QUERIES ---

  // Get absences of an employee during their work period
  Future<List<PresenceModel>> getEmployeeAbsences(int idEmploye, String startDate, String endDate) async {
    final query = await _firestore
        .collection('Presence')
        .where('id_employe', isEqualTo: idEmploye)
        .where('presence', isEqualTo: false)
        .where('date_creation', isGreaterThanOrEqualTo: startDate)
        .where('date_creation', isLessThanOrEqualTo: endDate)
        .get();
    return query.docs.map((doc) => PresenceModel.fromMap(doc.data())).toList();
  }

  // Get list of planning for an employee
  Future<List<PlanningModel>> getEmployeePlannings(int idEmploye) async {
    final query = await _firestore
        .collection('Planning')
        .where('id_employe', isEqualTo: idEmploye)
        .get();
    return query.docs.map((doc) => PlanningModel.fromMap(doc.data())).toList();
  }

  // Get list of subscriptions for a client
  Future<List<AbonnementModel>> getClientAbonnements(int idClient) async {
    final query = await _firestore
        .collection('Abonnement')
        .where('id_client', isEqualTo: idClient)
        .get();
    return query.docs.map((doc) => AbonnementModel.fromMap(doc.data())).toList();
  }

  // Get list of sessions for a client
  Future<List<SeanceModel>> getClientSeances(int idClient) async {
    final query = await _firestore
        .collection('Seance')
        .where('id_client', isEqualTo: idClient)
        .get();
    return query.docs.map((doc) => SeanceModel.fromMap(doc.data())).toList();
  }

  // Get list of payments for a client
  Future<List<PaiementModel>> getClientPaiements(int idClient) async {
    final query = await _firestore
        .collection('Paiement')
        .where('id_client', isEqualTo: idClient)
        .get();
    return query.docs.map((doc) => PaiementModel.fromMap(doc.data())).toList();
  }

  // Get list of reservations for a client
  Future<List<ReservationModel>> getClientReservations(int idClient) async {
    final query = await _firestore
        .collection('Reservation')
        .where('id_client', isEqualTo: idClient)
        .get();
    return query.docs.map((doc) => ReservationModel.fromMap(doc.data())).toList();
  }

  // --- STATISTICAL QUERIES ---

  // Get the employee with the highest revenue contribution in a period
  Future<Map<String, dynamic>?> getTopRevenueEmployee(String startDate, String endDate) async {
    final query = await _firestore
        .collection('Paiement')
        .where('date_paiement', isGreaterThanOrEqualTo: startDate)
        .where('date_paiement', isLessThanOrEqualTo: endDate)
        .get();

    Map<int, double> revenueByEmployee = {};
    for (var doc in query.docs) {
      final data = doc.data();
      int idEmploye = data['id_employe'];
      double montant = (data['montant'] ?? 0).toDouble();
      revenueByEmployee[idEmploye] = (revenueByEmployee[idEmploye] ?? 0) + montant;
    }
    if (revenueByEmployee.isEmpty) return null;
    int topId = revenueByEmployee.entries.reduce((a, b) => a.value > b.value ? a : b).key;
    double topRevenue = revenueByEmployee[topId]!;
    final employeDoc = await _firestore.collection('Employe').doc(topId.toString()).get();
    if (!employeDoc.exists) return null;
    final employe = employeDoc.data()!;
    return {
      'id_employe': topId,
      'nom': employe['nom'],
      'prenom': employe['prenom'],
      'total_revenue': topRevenue,
    };
  }

  // Get the most sold product or service (based on reservation counts)
  Future<Map<String, dynamic>?> getMostSoldProductService(String startDate, String endDate) async {
    final query = await _firestore
        .collection('Reservation')
        .where('date_reservation', isGreaterThanOrEqualTo: startDate)
        .where('date_reservation', isLessThanOrEqualTo: endDate)
        .get();

    Map<int, int> countByModel = {};
    for (var doc in query.docs) {
      final data = doc.data();
      int idModel = data['id_model'];
      countByModel[idModel] = (countByModel[idModel] ?? 0) + 1;
    }
    if (countByModel.isEmpty) return null;
    int topModel = countByModel.entries.reduce((a, b) => a.value > b.value ? a : b).key;
    int saleCount = countByModel[topModel]!;
    final modelDoc = await _firestore.collection('Model_produit_service').doc(topModel.toString()).get();
    if (!modelDoc.exists) return null;
    final model = modelDoc.data()!;
    return {
      'id_model': topModel,
      'nom_model': model['nom_model'],
      'sale_count': saleCount,
    };
  }

  // Get percentage of total revenue per product or service in a period
  Future<List<Map<String, dynamic>>> getRevenuePercentageByProductService(String startDate, String endDate) async {
    final query = await _firestore
        .collection('Paiement')
        .where('date_paiement', isGreaterThanOrEqualTo: startDate)
        .where('date_paiement', isLessThanOrEqualTo: endDate)
        .get();

    double totalRevenue = 0;
    Map<int, double> revenueByModel = {};
    for (var doc in query.docs) {
      final data = doc.data();
      int idModel = data['id_model'];
      double montant = (data['montant'] ?? 0).toDouble();
      totalRevenue += montant;
      revenueByModel[idModel] = (revenueByModel[idModel] ?? 0) + montant;
    }
    List<Map<String, dynamic>> result = [];
    for (var entry in revenueByModel.entries) {
      final modelDoc = await _firestore.collection('Model_produit_service').doc(entry.key.toString()).get();
      String nomModel = modelDoc.exists ? modelDoc.data()!['nom_model'] : '';
      double percentage = totalRevenue > 0 ? (entry.value / totalRevenue) * 100 : 0.0;
      result.add({
        'id_model': entry.key,
        'nom_model': nomModel,
        'product_revenue': entry.value,
        'percentage': percentage,
      });
    }
    return result;
  }

  /// Firebase: Retourne la liste des ModelProduitServiceModel selon idSecteur et type
  Future<List<ModelProduitServiceModel>> getModelProduitServicesBySecteurAndType(int idSecteur, String type) async {
    final query = await _firestore
        .collection('Model_produit_service')
        .where('idSecteur', isEqualTo: idSecteur)
        .where('type', isEqualTo: type)
        .get();
    return query.docs.map((doc) => ModelProduitServiceModel.fromMap(doc.data())).toList();
  }

  /// Firebase: Retourne la liste des différents types de produits pour un secteur donné
  Future<List<String>> getTypesBySecteur(int idSecteur) async {
    final query = await _firestore
        .collection('Model_produit_service')
        .where('idSecteur', isEqualTo: idSecteur)
        .get();
    final types = <String>{};
    for (var doc in query.docs) {
      final data = doc.data();
      if (data['type'] != null) {
        types.add(data['type']);
      }
    }
    return types.toList();
  }

  /// Supprime toute la base de données Firestore (toutes les collections et documents)
 /* Future<void> deleteEntireDatabase() async {
    final collections = await _firestore.listCollections();
    for (final collection in collections) {
      final docs = await collection.get();
      for (final doc in docs.docs) {
        await doc.reference.delete();
      }
    }
  }*/

  /// Supprime tous les documents d'une collection précise
  Future<void> deleteCollection(String collectionName) async {
    final collection = _firestore.collection(collectionName);
    final snapshot = await collection.get();
    for (final doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }

  /// Supprime un document précis dans une collection
  Future<void> deleteDocument(String collectionName, String docId) async {
    await _firestore.collection(collectionName).doc(docId).delete();
  }

  // NEWMODEL CRUD
  Future<void> addNewModel(NewModel newModel, NewModelProvider provider) async {
    await _firestore.collection('NewModel').doc(newModel.id.toString()).set(newModel.toMap());
    provider.addNewModel(newModel);
  }

  Future<NewModel?> getNewModel(int id) async {
    final doc = await _firestore.collection('NewModel').doc(id.toString()).get();
    if (doc.exists) return NewModel.fromMap(doc.data()!);
    return null;
  }

  Future<List<NewModel>> getAllNewModels() async {
    final query = await _firestore.collection('NewModel').get();
    return query.docs.map((doc) => NewModel.fromMap(doc.data())).toList();
  }

  Future<void> updateNewModel(NewModel newModel, NewModelProvider provider) async {
    await _firestore.collection('NewModel').doc(newModel.id.toString()).update(newModel.toMap());
    provider.change(newModel);
  }

  Future<void> deleteNewModel(int id, NewModelProvider provider) async {
    await _firestore.collection('NewModel').doc(id.toString()).delete();
    provider.removeNewModel(id);
  }

  // EVENTMODEL CRUD
  Future<void> addEventModel(EventModel event, EventModelProvider provider) async {
    await _firestore.collection('EventModel').doc(event.id.toString()).set(event.toMap());
    provider.addEvent(event);
  }

  Future<EventModel?> getEventModel(int id) async {
    final doc = await _firestore.collection('EventModel').doc(id.toString()).get();
    if (doc.exists) return EventModel.fromMap(doc.data()!);
    return null;
  }

  Future<List<EventModel>> getAllEventModels() async {
    final query = await _firestore.collection('EventModel').get();
    return query.docs.map((doc) => EventModel.fromMap(doc.data())).toList();
  }

  Future<void> updateEventModel(EventModel event, EventModelProvider provider) async {
    await _firestore.collection('EventModel').doc(event.id.toString()).update(event.toMap());
    provider.change(event);
  }

  Future<void> deleteEventModel(int id, EventModelProvider provider) async {
    await _firestore.collection('EventModel').doc(id.toString()).delete();
    provider.removeEvent(id);
  }
}
