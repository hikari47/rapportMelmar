import 'dart:io';

import 'package:appmelmar/screens/my_constants_k_widgets/calendar.dart';
import 'package:appmelmar/services/firebase_authentication.dart';
import 'package:appmelmar/services/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class InscriptionEmployePage extends StatefulWidget {
  @override
  State<InscriptionEmployePage> createState() => _InscriptionEmployePageState();
}

class _InscriptionEmployePageState extends State<InscriptionEmployePage>{

  final nomCtrl=TextEditingController();
  final prenomCtrl=TextEditingController();
  final loginCtrl=TextEditingController();
  final passwordCtrl=TextEditingController();
  final fonctionCtrl=TextEditingController();
  final addresseCtrl=TextEditingController();

  String? _planningStr;
  String? _mois;
  int? _annee;
  File? image;

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      }
    });
  }

  void _ouvrirCalendrier(BuildContext context) async {
    Map<String, dynamic>? planningResult;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        Map<String, dynamic> tempPlanning = {
          'mois': '',
          'annee': 0,
          'jours': [],
        };

        return AlertDialog(
          title: Text('Sélectionner les jours de travail'),
          content: SingleChildScrollView(
            child: CalendrierJourTravail(
              onChanged: (planning) {
                tempPlanning = planning;
              },
            ),
          ),
          actions: [
            TextButton(
              child: Text('Annuler'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              child: Text('Valider les jours'),
              onPressed: () {
                Navigator.of(context).pop(tempPlanning);
              },
            ),
          ],
        );
      },
    ).then((value) {
      if (value != null) {
        planningResult = value;
        setState(() {
          _planningStr = planningResult!['jours'].join(",");
          _mois = planningResult!['mois'];
          _annee = planningResult!['annee'];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.bars)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: ListView(
            children: [
              image != null
                  ? Image.file(image!, height: 100)
                  : Text('Aucune image sélectionnée'),
              ElevatedButton(
                onPressed: pickImage,
                child: Text('Choisir une image'),
              ),
              TextFormField(controller: nomCtrl, decoration: InputDecoration(labelText: 'Nom')),
              TextFormField(controller: prenomCtrl, decoration: InputDecoration(labelText: 'Prénom')),
              TextFormField(controller: loginCtrl, decoration: InputDecoration(labelText: 'Login')),
              TextFormField(controller: passwordCtrl, decoration: InputDecoration(labelText: 'Mot de passe'), obscureText: true),
              TextFormField(controller:addresseCtrl, decoration: InputDecoration(labelText: 'addresse')),
              TextFormField(controller: fonctionCtrl, decoration: InputDecoration(labelText: 'fonction')),
              OutlinedButton(
                onPressed: () => _ouvrirCalendrier(context),
                child: Icon(Icons.calendar_today),
              ),
              Divider(),
              OutlinedButton( 
                  onPressed: ()async{
                   //UserCredential userCred= await AuthService().registerWithEmailAndPassword(loginCtrl.text, passwordCtrl.text);
                   //String idUser=userCred.user?.uid??"";
                  // Database(userId:idUser)
                   },
                  child: Text("save"))
            ],
          ),
        ),
      ),
    );
  }
}