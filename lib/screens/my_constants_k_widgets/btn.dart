import 'package:flutter/material.dart';

class Btn extends StatelessWidget{
  final String text;
  final String route;
  Btn({super.key,required this.text,required this.route});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      width:MediaQuery.of(context).size.width-60,
      height:50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.blue,
      ),
      child: TextButton(
          onPressed:(){Navigator.pushNamed(context,this.route);},
          child:Text(
              this.text,
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,letterSpacing: 2.0),)
      ),
    );
  }
}