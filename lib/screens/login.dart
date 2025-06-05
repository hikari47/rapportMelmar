import 'package:appmelmar/screens/my_constants_k_widgets/btn.dart';
import 'package:appmelmar/screens/my_constants_k_widgets/text.dart';
import 'package:appmelmar/services/firebase_authentication.dart';
import 'package:appmelmar/services/provider_class.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>  {
  final TextEditingController loginCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
 final AuthService _auth= AuthService();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child:Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding:EdgeInsets.only(left: 50),
            child: Text(
              'Welcome Back',
              style: TextStyle(
                  fontSize: 30
              ),),
          ),
          Expanded(child:Padding(
            padding: EdgeInsets.only(top: 20),
            child: Container(
              decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.only(topLeft: Radius.circular(50.0),topRight: Radius.circular(50.0))),

              child: SingleChildScrollView(
                scrollDirection:Axis.vertical,
                child: Column(
                    children: [
                      SizedBox(height: 40,),
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child:TextK(label: 'login', obscure: false, ctrl:  loginCtrl)
                      ),

                      SizedBox(height: 30,),
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: TextK(label: 'password', obscure: true, ctrl: passwordCtrl)
                      ),
                      SizedBox(height: 30,),
                      Btn(text: 'Login', route: '/accueil'),
                      SizedBox(height: 30,),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 70),
                          child:    Row(
                            children: [
                              Container(
                                height: 1,
                                width: 50,
                                color: Colors.black,
                              ),
                              Text(' Or continue with',),
                              Container(
                                height: 1,
                                width: 50,
                                color: Colors.black,
                              ),
                            ],
                          ),),

                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                        child: Row(
                          children: [
                            Expanded(
                              child:  ListTile(
                                visualDensity: VisualDensity(horizontal: -4.0),
                                leading:Icon(Icons.facebook,color: Colors.blueAccent,),
                                title:Text('Facebook'),
                              ),
                            ),

                            Expanded(
                                child:   ListTile(
                                  visualDensity: VisualDensity(horizontal: -4.0),
                                  leading:Icon(Icons.alternate_email_sharp,),
                                  title:Text(
                                    'yahoo/Gmail',
                                    style: TextStyle(fontSize: 15),),
                                )
                            )

                          ],
                        ),
                      )
                      /* Container(
                          width: MediaQuery.of(context).size.width-50,
                          child:  OutlinedButton(
                              style: OutlinedButton.styleFrom(backgroundColor: Colors.purple),
                              onPressed: ()async{
                                dynamic userFirebase=await AuthService().signInAnon();
                                print('user: ${userFirebase}');
                              // dynamic userFirebase= await AuthService().signWithEmailAndPassword(loginCtrl.text, passwordCtrl.text);
                                if(userFirebase!=null){
                                  print('userFirebase : $userFirebase.user');
                                }
                                else{
                                  print('userFirebase : null');
                                }

                                Provider.of<UserProvider>(context, listen: false).login(loginCtrl.text,passwordCtrl.text,userFirebase);
                                Navigator.pushNamed(context, '/espace_personnel');
                                },
                              child: Text('LOGIN IN',style: TextStyle(color:Colors.black ),)),
                        ),
*/

                    ]
                ),

              ),
            ),))


        ],
      ) ,
    ) ;
  }
}
