
import 'package:flutter/material.dart';

class Sign extends StatefulWidget{
  final ValueChanged<bool>? val;
 Sign({super.key,required this.val});
  @override
  _SignState createState() {
   return _SignState();
  }
}
class _SignState extends State<Sign>{
  bool btn1Active=true;
  bool btn2Active=false;
  Color txtActiveColor=Colors.black;
  Color txtInactiveColor=Color.fromRGBO(0, 0, 0,0.3);
  Color bgActiveColor=Colors.white;
  Color bgInactiveColor=Colors.transparent;
  BorderRadius activeBdRadius=BorderRadius.circular(50.0);
  BorderRadius inactiveBdRadius=BorderRadius.zero;
  @override
  Widget build(BuildContext context) {
    final double widthW=MediaQuery.of(context).size.width-60;
    return Container(
      width:widthW,
      height: 40,
      decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(10.0),
           border: Border.all(
               color:Colors.black,
               width: 1)),
      child: Row(
        children: [
          Container(
            width: widthW-150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white
            ),
            child: TextButton(
              onPressed:(){
                setState(() {
                  btn1Active=!btn1Active;
                  btn2Active=!btn2Active;
                  widget.val?.call(btn1Active);
                });
              },
              child: Text(
                  'sign in',
                  style: TextStyle(
                      color: btn1Active?txtActiveColor:txtInactiveColor)),
              style: TextButton.styleFrom(
                  backgroundColor:btn1Active?bgActiveColor:bgInactiveColor ),),
          ),

          Spacer(),
          Container(
              width: widthW-170,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white
            ),
            child:  TextButton(
                onPressed:(){
                  setState(() {
                    btn1Active=!btn1Active;
                    btn2Active=!btn2Active;
                    widget.val?.call(btn1Active);
                  });
                },
                child: Text(
                  'sign up',
                  style: TextStyle(
                      color: btn2Active?txtActiveColor:txtInactiveColor),
                ),
                style: TextButton.styleFrom(
                    backgroundColor:btn2Active?bgActiveColor:bgInactiveColor )
            ),
          ),

        ],
      ),
    );

  }


}