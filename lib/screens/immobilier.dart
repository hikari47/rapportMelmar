import 'package:appmelmar/models/model_produit_service.dart';
import 'package:appmelmar/my_widgets/my_product.dart';
import 'package:appmelmar/my_widgets/top_bar.dart';
import 'package:appmelmar/providers/dynamic_provider.dart';
import 'package:appmelmar/providers/model_produit_service_provider.dart';
import 'package:appmelmar/providers/user_provider.dart';
import 'package:appmelmar/screens/my_constants_k_widgets/khead.dart';
import 'package:appmelmar/screens/my_constants_k_widgets/new_immo.dart';
import 'package:appmelmar/screens/my_constants_k_widgets/options_lmmo.dart';
import 'package:appmelmar/services/firebase_database_revisee.dart';
import 'package:appmelmar/services/sqflite_database.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Immo extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ImmoState();
  }
}

class _ImmoState extends State<Immo>
{
  final index=0;
  @override
  Widget build(BuildContext context) {
    final user=Provider.of<DynamicProvider>(context).object;
    //le provider dynamic sera utilise pour confiner toutes recherches d'un user pendant qu'il est connecte
    // ensuite un formattage en un format txt pour repertorier le user et toute les recherches effectuer et a quelle heure

    //------------------------------------------------------------------------------------------------------
      Future<List<ModelProduitServiceModel>> produits_services(int idS) async {
    List<ModelProduitServiceModel> data = [];
    var services = Provider.of<ModelProduitServiceProvider>(context, listen: false).modelProduitServices;
    if(services.isEmpty)
    {
        var connecter=await Connectivity().checkConnectivity();
     if(connecter.contains(ConnectivityResult.mobile))
     {
      print('Connecter----------------------------------');
      try {
      data = await FirebaseDatabaseService().getAllModelProduitServicesBySecteur(idS);
    } catch (e) {
      print('Erreur :$e');
    }
     }
     else{print('Non connecter----------------------------------');}
    // 1. Essayer Firebase
    
    // 2. Attendre 6 secondes puis essayer Sqflite si vide
    if (data.isEmpty) {
      await Future.delayed(Duration(seconds: 2));
      try {
        data = await DatabaseService().getAllModelProduitServicesBySecteur(idS);
      } catch (_) {}
    }
    // 3. Attendre 5 secondes puis utiliser une liste prédéfinie si toujours vide
    if (data.isEmpty) {
      await Future.delayed(Duration(seconds: 2));
      data = [
        ModelProduitServiceModel(nomModel: "Produit A", idModel: 1, idSecteur: idS, prix: 100,champsModel: 'description produit A',dateCreation: DateTime.now(),imagePath: '',type: 'terrain'),
        ModelProduitServiceModel(nomModel: "Produit B", idModel: 2, idSecteur: idS, prix: 200,champsModel: 'description produit B',dateCreation: DateTime.now(),imagePath: '',type: 'meublé'),
        ModelProduitServiceModel(nomModel: "Produit C", idModel: 3, idSecteur: idS, prix: 300,champsModel: 'description produit C',dateCreation: DateTime.now(),imagePath: '',type: 'appartement'),
        ModelProduitServiceModel(nomModel: "Produit D", idModel: 4, idSecteur: idS, prix: 400,champsModel: 'description produit D',dateCreation: DateTime.now(),imagePath: '',type: 'appartement'),
        ModelProduitServiceModel(nomModel: "Produit E", idModel: 5, idSecteur: idS, prix: 500,champsModel: 'description produit E',dateCreation: DateTime.now(),imagePath: '',type: 'terrain'),
        ModelProduitServiceModel(nomModel: "Produit F", idModel: 6, idSecteur: idS, prix: 600,champsModel: 'description produit F',dateCreation: DateTime.now(),imagePath: '',type: 'terrain'),
      ];
    }
    }
    else{
      data=services;
    }
     

    return data;
  }
   return Scaffold(
     backgroundColor: Colors.white,
     
     body:FutureBuilder(
      future:produits_services(4), 
      builder: (context,snapshot){
        if(snapshot.connectionState==ConnectionState.waiting)
          {
              return CircularProgressIndicator();
          }
          if(snapshot.hasError)
          {
            return Text('error au niveau de ${snapshot.hasError}');
          }
        final services=snapshot.data;
        final resultList=DatabaseService().getTypesFromModelProduitServiceList(services!);
/*WidgetsBinding.instance.addPostFrameCallback((_) {
        Provider.of<ModelProduitServiceProvider>(context).addList(services);
      });*/
        return  SafeArea(
          child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top:80),
              child: SingleChildScrollView(
       child:Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Container(
             padding: EdgeInsets.only(left: 15.0),
             child: Text(
               "Find a property",
               style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
             ),
           ),
           Options(servicesT: services),
           Container(
             padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10.0),
             child: Text(
               "What's new about ...",
               style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
             ),
           ),
          MyProduct(
            direction: Axis.horizontal,
             products: services),
           Container(
             padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10.0),
             child: Text(
               "Announces ...",
               style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
             ),
           ),
           Container(
             color: Colors.black,
             height: 150,
           ),
            Container(
                 color: Colors.black,
                 height: 150,
               )
         ],
       ) ,
     ),),
             
            TopBar(isUserConnected: user!=null, searchList:resultList),
          ],
        )
        )
        
        ;
      })
     
   );
  }
}