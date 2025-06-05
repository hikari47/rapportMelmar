import 'package:appmelmar/screens/inscriptionC.dart';
import 'package:appmelmar/screens/login.dart';
import 'package:appmelmar/screens/my_constants_k_widgets/sign.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class FirstPage extends StatefulWidget{
  @override
  State<FirstPage> createState() {
    return _FirstPageState();
  }
}

class _FirstPageState extends State<FirstPage>{
final String title='';
final ValueNotifier<bool> valBool = ValueNotifier(false);
final btnSelected=[true,false];
final List<Widget> page=[LoginPage(),InscriptionClientPage()];
int index =0;
@override
void dispose() {
valBool.dispose();
}
  @override
  Widget build(BuildContext context) {
    return
        Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title:  Sign(val:(valid){
              setState(() {
                valBool.value=valid;
                print('valBool.value :${valBool.value}');
                valBool.value?index=0:index=1;
              });
            },),
          ),
          backgroundColor: Colors.white,
          body:page[index],

        );


  }
}