import 'package:appmelmar/providers/user_provider.dart';
import 'package:appmelmar/screens/my_constants_k_widgets/khead.dart';
import 'package:appmelmar/screens/my_constants_k_widgets/kidget_param.dart';
import 'package:appmelmar/services/firebase_authentication.dart';
import 'package:appmelmar/services/provider_class.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EspacePersonnel extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    if (userProvider.user!=null)
      {
        return Scaffold(
          body:Center(child:Text("vous n'etes pas connecté !"),)
        );
      }
    else{
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title:StreamBuilder(
              stream: AuthService().userChange,
              builder: (context, snapshot)
              {
                return snapshot.data!=null ?Text('${userProvider.user?.nom}'): Text("userFb :null");
              }
          ),
          actions: [CircleAvatar(
            radius:25.0,
            child:Icon(CupertinoIcons.person_alt) ,
          ) ,],
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            KidgetControl(),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Param(icon_k: Icon(Icons.settings,color: Color.fromRGBO(0, 0, 255, 0.7),size: 70,),link: 'jndsl'),
                  Param(icon_k: Icon(Icons.calendar_month_outlined,color: Color.fromRGBO(0, 0, 255, 0.7),size: 70,),link: 'jndsl'),
                  Param(icon_k: Icon(Icons.add,color: Color.fromRGBO(255, 36, 146, 0.7),size: 70,),link: '/inscriptionEmploye'),
                  Param(icon_k: Icon(Icons.settings,color: Color.fromRGBO(255, 36, 146, 0.7),size: 70,),link: 'jndsl'),
                  Param(icon_k: Icon(Icons.settings,color: Color.fromRGBO(255, 36, 146, 0.7),size: 70,),link: 'jndsl'),
                  Param(icon_k: Icon(Icons.settings,color: Color.fromRGBO(255, 36, 146, 0.7),size: 70,),link: 'jndsl'),
                  Param(icon_k: Icon(Icons.settings,color: Color.fromRGBO(255, 36, 146, 0.7),size: 70,),link: 'jndsl'),
                  Param(icon_k: Icon(Icons.settings,color: Color.fromRGBO(255, 36, 146, 0.7),size: 70,),link: 'jndsl'),
                  Param(icon_k: Icon(Icons.settings,color: Color.fromRGBO(255, 36, 146, 0.7),size: 70,),link: 'jndsl'),
                  Param(icon_k: Icon(Icons.settings,color: Color.fromRGBO(255, 36, 146, 0.7),size: 70,),link: 'jndsl'),
                ],
              ),
            )

          ],
        ),

      );
    }

  }
}