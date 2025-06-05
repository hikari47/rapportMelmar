import 'package:appmelmar/screens/my_constants_k_widgets/khead.dart';
import 'package:flutter/material.dart';

class FitnessPage extends StatefulWidget{
  @override
  State<FitnessPage> createState() {
    return _FitnessPageState();
  }
}

class _FitnessPageState extends State<FitnessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body:SafeArea(
        child:Stack(
          children: [
            
             SingleChildScrollView(
              child: Padding(
              padding:EdgeInsets.only(top: 90),
              child:Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 30,),
                  Text("MES EVENEMENTS",),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                   child: Row(
                    children: [
                      Card(
      child: Container(
        height: 200,
        width: MediaQuery.of(context).size.width-30,
        child:Stack(
          children: [
            Image.asset(
              'assets/imgs/sport1.jpg',
              width: MediaQuery.of(context).size.width-30,
              fit: BoxFit.cover, ),
           ListTile(
                  onTap:(){
                    Navigator.pushNamed(context, '/events_beauty');
                  } ,
                  title: Text(
                    "10 SEMAINES DE FITNESS ABSOLU",
                    softWrap: true,
                    maxLines: 3,
                    style: TextStyle(
                        fontSize: 30,
                        wordSpacing: -3.0,
                        letterSpacing: 0.0),),
                  subtitle: Text(
                    "plus de 25 produits en promotion des le 25 novembre",
                    softWrap: true,
                    maxLines: 4,),
                )

          ],
        )
      ),
    ),
    Card(
      child: Container(
        height: 200,
        width: MediaQuery.of(context).size.width-30,
        child:Stack(
          children: [
            Image.asset(
              'assets/imgs/produit_beauty5.jpg',
              width: MediaQuery.of(context).size.width-30,
              fit: BoxFit.cover, ),
           ListTile(
                  onTap:(){
                    Navigator.pushNamed(context, '/events_beauty');
                  } ,
                  title: Text(
                    "GRANDE PROMOTION",
                    softWrap: true,
                    maxLines: 3,
                    style: TextStyle(
                        fontSize: 30,
                        wordSpacing: -3.0,
                        letterSpacing: 0.0),),
                  subtitle: Text(
                    "plus de 25 produits en promotion des le 25 novembre",
                    softWrap: true,
                    maxLines: 4,),
                )

          ],
        )
      ),
    ),
                    ],
                  ),),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Container(
                    width: MediaQuery.of(context).size.width-5,
                    height: 300,
                    //padding: EdgeInsets.symmetric(horizontal: 20),
                     decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black,width: 2),
                                borderRadius:BorderRadius.circular(10.0)
                              ),
                    child:  Card(
                       child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius:BorderRadius.circular(10.0),
                            child: Image.asset(
                          'assets/imgs/f5ae39d0a4efdd121204602fb22677d4.jpg',
                          fit:BoxFit.cover,
                          width: MediaQuery.of(context).size.width-20,
                          ),),
                          Positioned(
                            top: 200,
                            child: Text(
                          "MON ABONNEMENT",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize:30),),
                          ),
                            Positioned(
                            top: 230,
                            child: Text(
                          "consulter votre abonnement ou reabonnez-vous",
                          softWrap: true,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize:15),),
                          ),
                        
                      ],
                    ),
                  ),
                  ),
                  
                  ),
                  Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Container(
                    width: MediaQuery.of(context).size.width-5,
                    height: 300,
                    //padding: EdgeInsets.symmetric(horizontal: 20),
                     decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black,width: 2),
                                borderRadius:BorderRadius.circular(10.0)
                              ),
                    child:  Card(
                       child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius:BorderRadius.circular(10.0),
                            child: Image.asset(
                          'assets/imgs/sport1.jpg',
                          fit:BoxFit.cover,
                          width: MediaQuery.of(context).size.width-20,
                          ),),
                          Positioned(
                            top: 200,
                            child: Text(
                          "MES OBJECTIFS",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize:30),),
                          ),
                            Positioned(
                            top: 230,
                            child: Text(
                          "Etablissez une liste de vos objectifs et suivez leurs avancements",
                          softWrap: true,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize:15),),
                          ),
                        
                      ],
                    ),
                  ),
                  ),
                  
                  ),
                  
                 
                ],
              ) ,),
             ),
            KidgetControl()
          ],
        ) )
    );
  }
}