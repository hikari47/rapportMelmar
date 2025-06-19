import 'package:appmelmar/models/user.dart';
import 'package:appmelmar/providers/abonnement_provider.dart';
import 'package:appmelmar/providers/dynamic_provider.dart';
import 'package:appmelmar/providers/model_produit_service_provider.dart';
import 'package:appmelmar/providers/paiement_provider.dart';
import 'package:appmelmar/providers/reservation_provider.dart';
import 'package:appmelmar/providers/seance_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppProvidersWrapper extends StatelessWidget{
   final Widget child;
   AppProvidersWrapper({required this.child, Key? key}) : super(key: key);

   @override
  Widget build(BuildContext context) {
    Object? user=Provider.of<DynamicProvider?>(context)!.object;
    if(user is ClientModel)
    {
      
      return MultiProvider(
        providers:
        [
          ChangeNotifierProvider(create: (_) => AbonnementProvider()),
          ChangeNotifierProvider(create: (_) => ModelProduitServiceProvider()),
          ChangeNotifierProvider(create: (_) => SeanceProvider()),
          ChangeNotifierProvider(create: (_) => ReservationProvider()),
          ChangeNotifierProvider(create: (_) => PaiementProvider()),
        ],
        child:child ,);
    }
    if(user is EmployeModel )
    { return child;}
    if(user is AdminModel)
    {return child;}
    return child ;
  }

  
}