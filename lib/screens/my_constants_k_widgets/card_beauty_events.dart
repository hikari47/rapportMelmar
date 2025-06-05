import 'package:flutter/material.dart';

class CardBeauty extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Card(
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
    );
  }
}