import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextK extends StatefulWidget{
  final String label;
  final bool obscure;
  final TextEditingController ctrl;
  TextK({super.key,required this.label,required this.obscure,required this.ctrl});
  @override
  State<TextK> createState() {
    return _TextKState();
  }
}
class _TextKState extends State<TextK>{
  final FocusNode _focusNode=FocusNode();
  bool _hasFocus=false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener((){
      setState(() {
        _hasFocus=_focusNode.hasFocus;
      });
    });
  }
  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(

      width:MediaQuery.of(context).size.width-30,
      height:50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color:_hasFocus?Colors.blue:Colors.black,width:_hasFocus?2: 1)
      ),
      child:Padding(
          padding:EdgeInsets.only(left: 10,bottom: 5),
          child:widget.obscure?Row(
            children: [
              Expanded(
                  flex: 5,
                  child:TextFormField(
                  obscureText: widget.obscure?true:false,
                  focusNode: _focusNode,
                  controller: widget.ctrl,
                  decoration: InputDecoration(
                    label: Text(widget.label),
                    border: InputBorder.none,
                   /*enabledBorder: OutlineInputBorder(
                     borderSide: BorderSide(color: Colors.grey)
                   ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue)
                    )*/
                  )
              ) ),

              Expanded(
                flex: 1,
                  child:IconButton(onPressed: (){}, icon:Icon(CupertinoIcons.eye_fill) ) )
            ],
          ):TextFormField(
            obscureText: widget.obscure?true:false,
             controller: widget.ctrl,
            focusNode: _focusNode,
            decoration: InputDecoration(
                label: Text(widget.label),
                border: InputBorder.none,

                )
          )
        ,)

    );
  }
}