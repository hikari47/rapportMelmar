import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Param extends StatelessWidget{
  final Icon icon_k;
  final String link;
  const Param({super.key,required this.icon_k,required this.link});
  @override
  Widget build(BuildContext context) {
    return 
      Padding(
          padding: EdgeInsets.all(15.0),
          child: Container(
        width: 100,
        height: 100,
        decoration:BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            color: Color.fromRGBO(0,0,255, 0.25)
        ),
        child: IconButton(
            onPressed:(){
              Navigator.pushNamed(context,link);
              print("$link");
            }, icon: icon_k),
      ) ,
      );
     
  }

}