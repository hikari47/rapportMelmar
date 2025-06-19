import 'package:appmelmar/models/model_produit_service.dart';
import 'package:appmelmar/models/user.dart';
import 'package:appmelmar/my_widgets/top_bar.dart';
import 'package:appmelmar/my_widgets/services_grid.dart';
import 'package:appmelmar/providers/abonnement_provider.dart';
import 'package:appmelmar/providers/dynamic_provider.dart';
import 'package:appmelmar/providers/model_produit_service_provider.dart';
import 'package:appmelmar/providers/paiement_provider.dart';
import 'package:appmelmar/providers/reservation_provider.dart';
import 'package:appmelmar/providers/seance_provider.dart';
import 'package:appmelmar/providers/user_provider.dart';
import 'package:appmelmar/screens/my_constants_k_widgets/khead.dart';
import 'package:appmelmar/services/sqflite_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class AccueilPage extends StatelessWidget {

 
  @override
  Widget build(BuildContext context) {
    Object? user=Provider.of<DynamicProvider?>(context)!.object;
    
    
    return Scaffold(

      body:SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          user!=null?Padding(
            padding: EdgeInsets.only(left: 50.0,top: 5.0),
            child: Text('Welcome back... '))
            :Padding(
            padding: EdgeInsets.only(left: 10.0,top: 5.0),
            child: Text('Enjoy your first experience with us...')),
          
          TopBar(isUserConnected: (user!=null), searchList: serviceMaps.map((e) => e['nom_model'] as String).toList()),
         
          Container(
            padding: EdgeInsets.only(top: 10.0,left: 10.0),
            child: Text("Nos Services",style: TextStyle(
              fontSize: 25
            ),),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
           FloatingActionButton(
            onPressed: () {
              DatabaseService().deleteDatabaseFile().then((value) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Database deleted successfully')),
                );
              }).catchError((error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error deleting database: $error')),
                );
              });
            },
            child: Icon(CupertinoIcons.delete_solid),
          ),
          FloatingActionButton(
            onPressed: (){Navigator.pushNamed(context, '/qrcode');},
            child: Icon(CupertinoIcons.qrcode),
          )
            ],
          ),
          
          ServicesGrid(services: serviceMaps.map((map)=>ModelProduitServiceModel.fromMap(map)).toList()),
              //TopBar(titre: null, isUserConnected: true),
          
        ],
      ),
    ),
  )
    );
}
}

//donnees pour la simulation des services
// Ces données sont utilisées pour simuler les services dans l'application
final List<Map<String, dynamic>> serviceMaps = [
  {
    'id_model': 1,
    'nom_model': 'Beauty',
    'prix': 99.99,
    'champs_model': 'Soins de beauté, maquillage, etc.',
    'id_secteur': 101,
    'image_path': 'assets/imgs/produit_beauty3.jpg',
    'date_creation': DateTime.now(),
  },
  {
    'id_model': 2,
    'nom_model': 'Immobilier',
    'prix': 199.99,
    'champs_model': 'Vente et location de biens immobiliers',
    'id_secteur': 102,
    'image_path': 'assets/imgs/app7.jpg',
    'date_creation': DateTime.now(),
  },
  {
    'id_model': 3,
    'nom_model': 'Shooting Photos',
    'prix': 299.99,
    'champs_model': 'Photographie professionnelle',
    'id_secteur': 103,
    'image_path': 'assets/imgs/shoting1.jpg',
    'date_creation': DateTime.now(),
  },
  {
    'id_model': 4,
    'nom_model': 'Salle de Fitness',
    'prix': 49.99,
    'champs_model': 'Remise en forme, coaching sportif',
    'id_secteur': 104,
    'image_path': 'assets/imgs/sport1.jpg',
    'date_creation': DateTime.now(),
  },
  {
    'id_model': 5,
    'nom_model': 'Restauration',
    'prix': 89.99,
    'champs_model': 'Livraison de repas, traiteur',
    'id_secteur': 105,
    'image_path': 'assets/imgs/produit_beauty3.jpg',
    'date_creation': DateTime.now(),
  },
  {
    'id_model': 6,
    'nom_model': 'Transport',
    'prix': 59.99,
    'champs_model': 'Taxi, location de véhicules',
    'id_secteur': 106,
    'image_path': 'assets/imgs/produit_beauty3.jpg',
    'date_creation': DateTime.now(),
  },
];


