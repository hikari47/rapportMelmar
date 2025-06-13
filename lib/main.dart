
import 'package:appmelmar/providers/client_provider.dart';
import 'package:appmelmar/providers/user_provider.dart';
import 'package:appmelmar/screens/accueil.dart';
import 'package:appmelmar/screens/beauty.dart';
import 'package:appmelmar/screens/details_home.dart';
import 'package:appmelmar/screens/events_beauty.dart';
import 'package:appmelmar/screens/first.dart';
import 'package:appmelmar/screens/fitness.dart';
import 'package:appmelmar/screens/immobilier.dart';
import 'package:appmelmar/screens/inscriptionC.dart';
import 'package:appmelmar/screens/inscriptionE.dart';
import 'package:appmelmar/screens/intro.dart';
import 'package:appmelmar/screens/login.dart';
import 'package:appmelmar/screens/presence.dart';
import 'package:appmelmar/screens/espace_prive.dart';
import 'package:appmelmar/screens/test_marquer_presence.dart';
import 'package:appmelmar/screens/testqrcode.dart';
import 'package:appmelmar/services/provider_class.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:appmelmar/screens/page_test.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform);
  print('initialisation reussi');
  await initializeDateFormatting('fr_FR', null);
  runApp(
    MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => UserProvider()),
    ChangeNotifierProvider(create: (_) => ClientProvider()),
    ],
    child: const MyApp(),)
  );
 // runApp(MyApp());
}

Map<String, WidgetBuilder> getAppRoutes() {
  return {
    //'/': (context) => AccueilPage(),
    //'/': (context) =>  Intro(),
    '/':(context)=>PageTest(),
    '/inscriptionClient': (context) =>  InscriptionClientPage(),
    '/inscriptionEmploye': (context) =>  InscriptionEmployePage(),
    '/login': (context) =>  LoginPage(),
    '/presence': (context) =>  PresencePage(),
    '/espace_personnel': (context) => EspacePersonnel(),
    '/first': (context) =>  FirstPage(),
    '/accueil': (context) =>  AccueilPage(),
    '/immobilier': (context) =>  Immo(),
    '/details_immo': (context) =>  DetailsImmo(),
    '/beauty': (context) =>  BeautyPage(),
    '/events_beauty': (context) =>  EventsBeautyPage(),
    '/sport': (context) => FitnessPage(),
    '/qrcode': (context) => QRCodeApp(),

  };
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key); // Ajout du constructeur const

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Application Flutter',
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      routes: getAppRoutes(),
    );
  }
}


