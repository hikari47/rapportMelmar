import 'package:appmelmar/screens/my_constants_k_widgets/khead.dart';
import 'package:appmelmar/screens/my_constants_k_widgets/new_immo.dart';
import 'package:appmelmar/screens/my_constants_k_widgets/options_lmmo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
   return Scaffold(
     backgroundColor: Colors.white,
     appBar: AppBar(
       automaticallyImplyLeading: false,
       leading:Icon(Icons.place,color: Colors.blue,) ,
       title: Text("Odza ,auberge bleu"),
       actions: [
             Row(
               children: [
                 SizedBox(width: 10,),
                 CircleAvatar(
                   maxRadius: 20,
                   child: Icon(Icons.person),),
               ],
             )
       ],
     ),
     body:SingleChildScrollView(
       child:Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           KidgetControl(),
           SizedBox(height: 10,),
           Container(
             padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10.0),
             child: Text(
               "Find a property",
               style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
             ),
           ),
           OptionsSport(),
           Container(
             padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10.0),
             child: Text(
               "What's new about ...",
               style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
             ),
           ),
           SingleChildScrollView(
             scrollDirection: Axis.horizontal,
             child: Row(
               children: [
                 NewImmo(path_img: 'assets/imgs/app6.jpg',prix: 150000,),
                 NewImmo(path_img: 'assets/imgs/app6.jpg',prix: 150000,),
                 NewImmo(path_img: 'assets/imgs/app6.jpg',prix: 150000,),
                 NewImmo(path_img: 'assets/imgs/app6.jpg',prix: 150000,),
               ],
             ),
           ),
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
     )
   );
  }
}