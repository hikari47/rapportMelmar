import 'package:flutter/material.dart';

class EmployBeauty extends StatelessWidget{
  final String img;
  //final String text;
  EmployBeauty({super.key,required this.img});
  @override
  Widget build(BuildContext context) {
    return
      Container(
        child:
        Image.asset(
          this.img,
          width: MediaQuery.of(context).size.width-30,
          height:300 ,),
      );
  }
}