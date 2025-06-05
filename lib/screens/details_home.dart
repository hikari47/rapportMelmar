import 'package:flutter/material.dart';

class DetailsImmo extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                  padding:EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    //padding: EdgeInsets.symmetric(horizontal: 20),
                    height:MediaQuery.of(context).size.height-200,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black,width: 2.0),
                      borderRadius: BorderRadius.circular(10.0)
                    ),
                    // color: Colors.blue,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.asset(
                            'assets/imgs/app6.jpg',
                            width: MediaQuery.of(context).size.width,
                            height:MediaQuery.of(context).size.height-200,
                            fit: BoxFit.cover,),
                        ),
                        Positioned(
                            left: 0,
                            child: BackButton(color: Colors.red,))
                      ],
                    ),
                  ),
              ),
              Padding(
                  padding:EdgeInsets.only(left: 10) ,
                  child: Text(
                      "Appartement meuble simple",
                       style: TextStyle(
                         fontSize: 20,
                         color: Colors.black,
                       ),),
              ),
              Padding(
                  padding:EdgeInsets.only(left: 10) ,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text("5 Bed"),
                      Text("2 Baths"),
                      Text("57.9 m²"),
                    ],
                  ),
              ),
              Padding(
                  padding:EdgeInsets.only(left: 10),
                  child: ListTile(
                    leading: Icon(Icons.place_outlined,color: Colors.blue,),
                    title: Text("Yaounde ,Awae apres laverie"),
                  ),
              ),
              Padding(
                padding:EdgeInsets.only(left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Prix : 150.000CFA",
                       style: TextStyle(
                         fontSize: 20
                       ),),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow:   [
                            BoxShadow(
                              color: Colors.tealAccent,
                              spreadRadius: 0.5,
                              blurRadius: 1.0,
                            )
                          ]
                      ),
                      child:TextButton(
                          onPressed: (){},
                          child: Text("BOOK NOW")),
                    ),
                  ],
                ),)

            ],
          )
        ,)
    );
  }
}