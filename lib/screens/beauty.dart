import 'package:appmelmar/screens/my_constants_k_widgets/card_beauty_events.dart';
import 'package:appmelmar/screens/my_constants_k_widgets/drawer_beauty.dart';
import 'package:appmelmar/screens/my_constants_k_widgets/employe_beauty.dart';
import 'package:appmelmar/screens/my_constants_k_widgets/khead.dart';
import 'package:appmelmar/screens/my_constants_k_widgets/recommandation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class BeautyPage extends StatefulWidget{
  bool drawerCliqued=false;
  @override
  State<BeautyPage> createState() {
    return _BeautyPageState();
  }
}

class _BeautyPageState extends State<BeautyPage>
{
final GlobalKey<ScaffoldState> _scaffoldKey=GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    
    final List<List<Widget>> todo=[
      [Image.asset(
        'assets/imgs/nail.jpg',
        fit: BoxFit.fill,
        width: MediaQuery.of(context).size.width/4,),
        Text(
          'NAILS',
          style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold),)],
      [Image.asset(
        'assets/imgs/coiffure8.jpg',
         fit: BoxFit.fill,
         width: MediaQuery.of(context).size.width/4,),
        Text(
            'HAIRCUT',
          style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold),)],
      [Image.asset(
        'assets/imgs/coiffure6.jpg',
        fit: BoxFit.fill,
        width: MediaQuery.of(context).size.width/4,),
        Text(
            'COIFFURE',
          style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold),)],
      [Image.asset(
        'assets/imgs/colory.jpg',
        fit: BoxFit.fill,
        width: MediaQuery.of(context).size.width/4,),
        Text(
            'COLORY',
          style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold),)],
      [Image.asset(
        'assets/imgs/makeup.jpg',
        fit: BoxFit.fill,
        width: MediaQuery.of(context).size.width/4,),
        Text(
            'MAKEUP',
          style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold),)],
      [Image.asset(
        'assets/imgs/waxing.jpg',
        fit: BoxFit.fill,
        width: MediaQuery.of(context).size.width/4,),
        Text(
            'WAXING',
          style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold),)],
      [Image.asset(
        'assets/imgs/app2.jpg',
        fit: BoxFit.fill,
        width: MediaQuery.of(context).size.width/4,),
        Text(
            'SPA',
          style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold),)],
      [Image.asset(
        'assets/imgs/produit_beauty2.jpg',
         fit: BoxFit.fill,
         width: MediaQuery.of(context).size.width/4,),
        Text(
            'VENTE',
          style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold),)],

    ];
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      drawer: DrawerBeauty(),
      body: SafeArea(
          child:Stack(
            children:[
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(height: 50,),
                    Padding(
                      padding: EdgeInsets.only(left: 17.0),
                      child:Text(
                        "EVENTS /PROMOTION",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CardBeauty(),
                          CardBeauty(),
                          CardBeauty(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 17.0),
                      child:Text(
                        "WHAT TO DO ?",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                        itemCount: 8,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context,index){
                          return InkWell(
                            onTap: (){},
                            child:Container(
                              width: MediaQuery.of(context).size.width/4,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black,width: 2),
                                borderRadius:BorderRadius.circular(10.0)
                              ),
                              child: Stack(
                                children: [
                                 todo[index][0],
                                  Positioned(
                                    top: 25,
                                    left: 3,
                                    child: todo[index][1],)

                                ],
                              ),
                            ) ,
                          );
                        }
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 17.0),
                      child:Text(
                        "TODAY'S RECOMMANDATION ...",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          RecommandT(img: 'assets/imgs/coiffure5.jpg'),
                          RecommandT(img: 'assets/imgs/coiffure6.jpg'),
                          RecommandT(img: 'assets/imgs/coiffure7.jpg'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 17.0),
                      child:Text(
                        "OUR STAFF ...",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                     scrollDirection: Axis.horizontal,
                      child:  Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          EmployBeauty(img: 'assets/imgs/employe1.jpg'),
                          EmployBeauty(img: 'assets/imgs/employe2.jpg'),
                          EmployBeauty(img: 'assets/imgs/employe3.jpg'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                //padding: EdgeInsets.only(left: 15.0),
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child:Row(
                  mainAxisSize: MainAxisSize.min ,
                  children: [
                    IconButton(
                      onPressed:(){
                        setState((){
                          widget.drawerCliqued=!widget.drawerCliqued;
                          _scaffoldKey.currentState?.openDrawer();
                        });
                      },
                      icon:Icon(Icons.menu)
                    ),
                    Expanded(child: KidgetControl(),)

                  ],
                )
              ),
             /* widget.drawerCliqued?Padding(
                  padding: EdgeInsets.only(top: 35),
                child: DrawerBeauty(),) :SizedBox(height:5),*/
            ]
          ),
      ),
    );
  }
}