import 'package:appmelmar/models/user.dart';
import 'package:appmelmar/my_widgets/top_bar.dart';
import 'package:appmelmar/providers/user_provider.dart';
import 'package:appmelmar/screens/my_constants_k_widgets/khead.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class AccueilPage extends StatelessWidget {

  final List<List<String>> services=[
    ["assets/imgs/produit_beauty3.jpg","beauty et cosmetique","votre service beauté","/beauty"],
    ["assets/imgs/app7.jpg","Immobilier","nous avons une planauplie de logements","/immobilier"],
    ["assets/imgs/shoting1.jpg","Shoting photos","Immortaliser vos simples et meilleurs moments","/shoting"],
    ["assets/imgs/sport1.jpg","Salle de fitnex","tenez la forme ","/sport"]
  ];
  @override
  Widget build(BuildContext context) {
    UserModel? user=Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Expanded(
              child: Row(
                children: [
                  SizedBox(width: 10,),
                  CircleAvatar(
                    maxRadius: 20,
                    child: Icon(Icons.person),),
                  SizedBox(width: 10,),
                  Icon(Icons.menu),
                  Spacer(),
                  CircleAvatar(
                    maxRadius: 20,
                    child: Icon(Icons.notifications),),
                  SizedBox(width: 10,),
                ],
              ))
        ],
      ),
      body:Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          user!=null?Text('Welcome back... '):Text('Enjoy your first experience with us...'),
          KidgetControl(),
          Container(
            padding: EdgeInsets.only(top: 10,left: 10),
            child: Text("Nos Services",style: TextStyle(
              fontSize: 25
            ),),
          ),
          GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: 4,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context,index){
                return InkWell(
                  onTap: (){
                    Navigator.pushNamed(context,services[index][3]);
                  },
                  child: Container(

                    //margin: EdgeInsets.all(10.0),
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color:  Colors.black12,
                          blurRadius: 4,
                          spreadRadius: 2
                        )
                      ]
                    ),
                    child: Column(
                     children: [
                      Image.asset(
                          services[index][0],
                      height: 150,),
                       Text(services[index][1])
                     ],
                    ),
                  ),
                );
              }),
              //TopBar(titre: null, isUserConnected: true),
        ],
      )
    );
  }
}


