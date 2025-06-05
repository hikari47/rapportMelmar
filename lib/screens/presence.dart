import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PresencePage extends StatelessWidget
{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("presence"),
        elevation:10.0 ,
      actions: [
        OutlinedButton.icon(icon:Icon(CupertinoIcons.person),label: Text("employé"),onPressed: (){},),
      ],),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: Text( "verifiier que vous etes connecte au wifi de l'entreprise sinon l'operation ne reussira pas" ),
              leading: Icon(Icons.arrow_right,color: Colors.green,),
            ),
            ListTile(
              title: Text( 'entrer votre login et password pour marquer votre presence en ce jour'),
              leading: Icon(Icons.arrow_right,color: Colors.green,),
            ),
            SizedBox(height: 65),
            Form(child:
            Column(
              children: [
                Container(
                  height: 70,
                  width: MediaQuery.of(context).size.width-30,
                  child: TextFormField(
                    validator: (val){
                      if(val!=null && val.length<6)
                      {
                        return 'invalide login';
                      }
                      else  {
                        return 'valide login';
                      }

                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(labelText: 'login'),
                  ),
                ),
                Container(
                  height: 70,
                  width: MediaQuery.of(context).size.width-30,
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    validator: (val){
                      if(val!=null && (val=='1234' || val=='abcd'))
                      {
                        return 'invalide password';
                      }
                      else  {
                        return 'valide password';
                      }

                    },
                    decoration: InputDecoration(labelText: 'password'),
                  ),
                ),

                OutlinedButton(onPressed: (){}, child: Text('VALIDER')),
                SpinKitFadingCircle(color: Colors.green,size: 70,)
              ],
            ))
          ],
        ),
      ),
    );
  }
}