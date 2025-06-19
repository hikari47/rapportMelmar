import 'package:appmelmar/models/model_produit_service.dart';
import 'package:sqflite/sqflite.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class FetchService {

  final _services = <ModelProduitServiceModel>[];
  List<ModelProduitServiceModel> get services => _services;
  // Récupérer les services depuis Sqflite
   Future<void> fromSqflite(Database db) async {
    clear(); // Nettoyer la liste avant de charger les données
    final List<Map<String, dynamic>> maps = await db.query('Service');
    _services.addAll(maps.map((map) => ModelProduitServiceModel.fromMap(map)).toList());
  }

  // Récupérer les services depuis Firebase Firestore
  Future<void> fromFirebase() async {
    clear(); // Nettoyer la liste avant de charger les données
    final QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('Service').get();
    _services.addAll(snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return ModelProduitServiceModel.fromMap(data);
    }).toList());
  }

  // Utiliser une liste passée en paramètre
 void fromList(List<ModelProduitServiceModel> services) {
  clear(); // Nettoyer la liste avant de charger les données
   _services.addAll(services);
  }

  void clear() {
    _services.clear();
  }
}
