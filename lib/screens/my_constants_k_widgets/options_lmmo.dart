import 'package:appmelmar/models/model_produit_service.dart';
import 'package:appmelmar/my_widgets/my_product.dart';
import 'package:appmelmar/providers/model_produit_service_provider.dart';
import 'package:appmelmar/services/firebase_database_revisee.dart';
import 'package:appmelmar/services/sqflite_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Options extends StatefulWidget{

 final List<ModelProduitServiceModel> servicesT;
 Options({super.key,required this.servicesT});

  @override
  State<Options> createState() {
    return _OptionsState();
  }
}


class _OptionsState extends State<Options>{
late List<ModelProduitServiceModel> services;
 @override void initState() {
    super.initState();
  // Provider.of<ModelProduitServiceProvider>(context).addList(widget.servicesT);
  }


  @override
  Widget build(BuildContext context) {
  //final  List<ModelProduitServiceModel> services=produits_services(2);
  services=widget.servicesT;
  WidgetsBinding.instance.addPostFrameCallback((_) {
   Provider.of<ModelProduitServiceProvider>(context,listen: false).addList(services);
      });
//   print('voir ce qui se passe :${Provider.of<ModelProduitServiceProvider>(context,listen: false).modelProduitServices}');
   
  final List<String> types=DatabaseService().getTypesFromModelProduitServiceList(services);
    return Container(
      color: Colors.white,
      height: 90,
      padding: EdgeInsets.only(left: 10.0,top:0,bottom: 0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: types.map((type) {
            return InkWell(
              onTap: () {
                final ps = DatabaseService().filterModelProduitServiceByType(services, type);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Scaffold(
                      appBar: AppBar(title: Text("Produits de type $type")),
                      body: MyProduct(
                        direction: Axis.vertical,
                        l: 350,
                        products: ps,
                      ),
                    ),
                  ),
                );
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.0),
                child: Container(
                  width: 160,
                  height: 65,
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    border: Border.all(width: 3, color: Colors.black12),
                  ),
                  child: Stack(
                    children: [
                      SizedBox(width: 10),
                      Icon(CupertinoIcons.home, size: 50, color: Colors.white),
                      Text(
                        "$type",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
    }
   
  }


// Nouvelle page pour afficher les produits/services filtrés par type
class ProduitsParTypePage extends StatelessWidget {
  final String type;
  final List<ModelProduitServiceModel> produits;

  ProduitsParTypePage({required this.type, required this.produits});

  @override
  Widget build(BuildContext context) {
    final produitsFiltres = produits.where((p) => p.type == type).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text('Produits: $type'),
      ),
      body: ListView.builder(
        itemCount: produitsFiltres.length,
        itemBuilder: (context, index) {
          final produit = produitsFiltres[index];
          return ListTile(
            title: Text(produit.nomModel),
            subtitle: Text(produit.champsModel ?? ''),
            trailing: Text('${produit.prix ?? ''}'),
          );
        },
      ),
    );
  }
}


