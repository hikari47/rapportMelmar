import 'package:appmelmar/my_widgets/qrcode_widget.dart';
import 'package:appmelmar/my_widgets/top_bar.dart';
import 'package:appmelmar/my_widgets/events.dart';
import 'package:appmelmar/my_widgets/plan.dart';
import 'package:appmelmar/my_widgets/product_service_achat_form.dart';
import 'package:appmelmar/my_widgets/product_service_form_reservation.dart';
import 'package:appmelmar/screens/accueil.dart';
import 'package:flutter/material.dart';
//import 'package:appmelmar/Widgets/video_gallery_vlc.dart';
import 'package:appmelmar/widgets/lecture_vignette.dart';
import 'package:appmelmar/screens/test_marquer_presence.dart';
import 'package:image_picker/image_picker.dart';


class PageTest extends StatefulWidget  {
  @override
  State<StatefulWidget> createState() {
    return _PageTestState();
  }
}

class _PageTestState extends State<PageTest>{



   // Sample data for productOrService
 late Map<String, dynamic> productOrService1;

  // Sample reservations data
  late  List<Map<String, dynamic>> reservations;
   late Widget pageEncour;
  @override
  void initState() {
     super.initState();
    reservations = [
    {'date': DateTime(2025, 6, 9)}, // Reserved date: June 9, 2025
    {'date': DateTime(2025, 6, 10)}, // Reserved date: June 10, 2025
  ];
  productOrService1 = {
    'title': 'Coupe de Cheveux',
  };
  pageEncour = const Center(child: Text('Bienvenue sur la page test'));
  }

  int idx=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page Test'),
      ),
      body:  pageEncour,
      drawer: Drawer(

        child: Column(
          children: 
          [
             ListTile(
            title: Text('planning'),
            onTap: (){
              setState(() {
                pageEncour=YearDaysPlanner(redDays: [DateTime.utc(2025,4,1),DateTime(2025,4,10),DateTime.utc(2025,4,21)],);
              });
            },
          ),
           ListTile(
            title: Text('presence'),
            onTap: (){
              setState(() {
                pageEncour= PresenceScreen();
              });
            },
          ),
           ListTile(
            title: Text('booking'),
            onTap: (){
              setState(() {
                pageEncour=ProductServiceFormReservation(productOrService: productOrService1, reservations: reservations,);
              });
            },
          ),
           ListTile(
            title: Text('paiement'),
            onTap: (){
              setState(() {
                pageEncour=ProductServiceAchatForm(
                  products: [{'title':'parasoleil','price':5000}],
                );
              });
            },
          ),
           ListTile(
            title: Text('accueil'),
            onTap: (){
              setState(() {
                pageEncour=AccueilPage();
              });
            },
          ),
           ListTile(
            title: Text('topBar'),
            onTap: ()async{
                final ImagePicker picker = ImagePicker();
                final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                if (image != null) 
               { 
                  setState(() {
                pageEncour=TopBar(
                  isUserConnected:true,
                  searchList: ["alex cassandra","rapport de mars 2025","le president de melmar apprend l'alchimie"],
                  backgroundImage: null,
                  userName: 'Alex Cassandra',
                  onNotificationTap: null,
                  onSearch: null,
                   userImageUrl: image.path);
              });
               }
            },
          ),
           ListTile(
            title: Text('event widget'),
            onTap: ()async{
               final ImagePicker picker = ImagePicker();
               final XFile? image = await picker.pickImage(source: ImageSource.gallery);
               if (image != null) 
               {
                 print('Image sélectionnée : ${image.path}');
                 setState(() {
                   pageEncour= Event(
                    imageUrl:image.path,
                    rating: 3.5,
                    title: 'produit miracle',
                    onTap:(){Navigator.pushNamed(context,'/accueil');}
                    );
                   });
               }
              
            },
          ),
           ListTile(
            title: Text('creer qrcode'),
            onTap: (){
              Navigator.pushNamed(context,'/qrcode');
               /*List<Map<String, dynamic>> productsK=[
                {
                'name': 'cendrier',
                'price': 500.0,
                'quantity': 26,
                },
                {
                'name': 'fer a repasser',
                'price': 2000,
                'quantity': 10,
                },
               ];
                print('debut encode0');
              pageEncour=QRCodeGeneration(clientName: 'harry poter',products:productsK,purchaseDate: DateTime(2025,06,15),);*/
            },
          ),
          ListTile(
            title: Text('decode Qrcode'),
            onTap: (){
              print('debut decode0');
              pageEncour=QRCodeDecryption();
            },
          ),
          /* ListTile(
            title: Text('pour les videos'),
            onTap: (){
             
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VideoGalleryVlcPlayer(),
                ),
              );
            },
          ),*/
           ListTile(
            title: Text('pour les videos 1'),
            onTap: (){
             
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VideoSelectorScreen(),
                ),
              );
            },
          )
          ]
        ),
      ),
     /* bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'acceuil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.play_arrow_outlined),
            label: 'presence',
          ),
         BottomNavigationBarItem(
            icon: Icon(Icons.book_outlined),
            label: 'booking',
          ),
         /* BottomNavigationBarItem(
            icon: Icon(Icons.two_k),
            label: 'booking',
          ),*/
         /* BottomNavigationBarItem(
            icon: Icon(Icons.mail_outline_sharp),
            label: 'booking',
          ),*/
        ],
        currentIndex: 0,
        selectedItemColor: Colors.blue,
        onTap: (index) {
          setState((){idx=index;});
        },
      ),*/
    );
  }
}