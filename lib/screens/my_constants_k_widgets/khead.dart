import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class KidgetControl extends StatelessWidget{

   const KidgetControl({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:EdgeInsets.only(left:5) ,
    child: Container(
padding: EdgeInsets.only(left: 5),
      decoration: BoxDecoration(
          color: Color.fromRGBO(207, 207, 207,0.25),
          borderRadius:BorderRadius.all(Radius.circular(30.0))),
      width: MediaQuery.of(context).size.width-45,
      height: 50,
      child:Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(flex: 4
              ,child: TextFormField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: 'Search',
              border: InputBorder.none),
            ),),
            Expanded(
                flex: 1,
              child: Icon(CupertinoIcons.search),)
          ]
      ),),)
      ;

  }
}