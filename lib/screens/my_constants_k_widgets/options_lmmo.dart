import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OptionsSport extends StatelessWidget{
  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 10.0),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                  padding: EdgeInsets.all( 3.0),
                  child:Container(
                    width: 160,
                    decoration: BoxDecoration(
                        color: Colors.teal,
                        border: Border.all(width: 3,color: Colors.black12)
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 10,),
                        Icon(CupertinoIcons.home,size: 50,color: Colors.white,),
                        Text(
                          "HOME",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold
                          ),)
                      ],
                    ),
                  ) ,),
              Padding(
                padding: EdgeInsets.all( 3.0),
                child:Container(
                  width: 160,
                  decoration: BoxDecoration(
                      color: Colors.teal,
                      border: Border.all(width: 3,color: Colors.black12)
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 10,),
                      Icon(Icons.hotel,size: 50,color: Colors.white,),
                      Text(
                        "HOTEL",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold
                        ),)
                    ],
                  ),
                ) ,),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all( 3.0),
                child:Container(
                  width: 160,
                  decoration: BoxDecoration(
                      color: Colors.teal,
                      border: Border.all(width: 3,color: Colors.black12)
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 10,),
                      Icon(CupertinoIcons.home,size: 50,color: Colors.white,),
                      Text(
                        "HOME",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold
                        ),)
                    ],
                  ),
                ) ,),
              Padding(
                padding: EdgeInsets.all( 3.0),
                child:Container(
                  width: 160,
                  decoration: BoxDecoration(
                      color: Colors.teal,
                      border: Border.all(width: 3,color: Colors.black12)
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 10,),
                      Icon(CupertinoIcons.home,size: 50,color: Colors.white,),
                      Text(
                        "HOME",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold
                        ),)
                    ],
                  ),
                ) ,),
            ],
          ),
        ],
      ),
    );
  }
}