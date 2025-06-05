import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewImmo extends StatefulWidget
{
  final String path_img;
  final double prix;
   bool heartSelected=false;
  //bool  imageClicked=false;
  NewImmo({super.key,required this.path_img,required this.prix});
  @override
  State<NewImmo> createState() {
 return _NewImmoState();
  }
}
class _NewImmoState  extends State<NewImmo>
{

  @override
  Widget build(BuildContext context) {

    return Card(
      child:Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0)
        ),
        height: 200,
        width: 300,
        child: Stack(
          children: [
            InkWell(
              onTap: (){
                Navigator.pushNamed(context, '/details_immo');
              },
              child:Image.asset(widget.path_img,fit: BoxFit.fill,) ,
            ),
            Positioned(
              top: 10,
              left: 250,
              child:CircleAvatar(
                  child: IconButton(
                    icon:widget.heartSelected?Icon(CupertinoIcons.heart_fill,color: Colors.red,):Icon(CupertinoIcons.heart),
                    onPressed: (){
                      setState(() {
                        widget.heartSelected=!widget.heartSelected;
                      });
                    },
              ),
            ),
            ),
            Positioned(
              left: 170,
                top: 100,
                child: Text(
                  "${widget.prix} CFA",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),)
            ),
            Positioned(
              top: 150,
              left: 200,
              child:Container(
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
            ),
          ],
        ),
      ),
    );
  }
}