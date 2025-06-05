import 'package:carousel_slider/carousel_slider.dart';
import'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Intro extends StatefulWidget{

  @override
  State<Intro> createState(){return _IntroPageState();}
}

class _IntroPageState extends State<Intro>{
  int activeIndex=0;
  final urlImages=[
    'assets/imgs/immo_inter_7.jpg',
    'assets/imgs/catalogue1.jpg',
    'assets/imgs/coiffure1.jpg',
    'assets/imgs/melmar_pink.png',
  ];
  final desc=[
    ["Nos logements","nous possedons des logemebts varies pour tous vos besoins"],
    ["Nos Footing","nous disposons d'atelier de photos pour immortaliser vous meilleur moments"],
    ["Notre salon a votre disposition","pour toutes vos besoins de beaute"],
    ["Debutez l'experience MelMar Empire","..."]
  ];
@override
  Widget build(BuildContext context) {
   return Scaffold(
     body: SafeArea(
         child:Column(
           children:[ CarouselSlider.builder(
               options: CarouselOptions(
                   height: 500,
               enableInfiniteScroll: false,

               enlargeCenterPage: true,
               onPageChanged: (index,reason) => setState(()=> activeIndex=index),
               ),
               itemCount: urlImages.length,
               itemBuilder: (context,index,realIndex){
                 final urlImage=urlImages[index];
                 final d=desc[index];
                 return builderImage(urlImage,index,d);
               },),
             const SizedBox(height: 10,),
             if(activeIndex!=3)
             buildIndicator(),
             if(activeIndex==3)
               Column(
                 children: [
                   Container(
                     height: 50,
                     width: MediaQuery.of(context).size.width-30,

                     child: ElevatedButton(
                         onPressed: (){Navigator.pushNamed(context, '/first');},
                         child: Text("Get Started",style: TextStyle(
                           fontSize: 16,
                           color: Colors.blue,
                         ),)),
                   )
                 ],
               ),
           ]
         ) ),
   );

  }
  Widget builderImage(String urlImg,int index,List<String> description){
    return Column(

      children: [
    Container(
    margin: EdgeInsets.only(top:10,left:10,right:10,bottom: 0),
    width: MediaQuery.of(context).size.width-20,
   // color: Colors.grey,
    child: Image.asset(
    urlImg,
    fit: BoxFit.cover,
      height: 300,
      width: MediaQuery.of(context).size.width,
    ),
    ),
        ListTile(
            title:Text(description[0],softWrap: true,style: TextStyle(fontWeight: FontWeight.bold),),
            subtitle: Text(description[1],softWrap: true,),
          ),
    ],) ;
  }
  Widget buildIndicator(){
  return AnimatedSmoothIndicator(
      activeIndex: activeIndex,
      count: urlImages.length,
  );
  }
}