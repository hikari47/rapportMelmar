import 'dart:io';
import 'package:appmelmar/screens/my_constants_k_widgets/text.dart';
import 'package:appmelmar/services/firebase_authentication.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class InscriptionClientPage extends StatefulWidget {
  @override
  _InscriptionClientPageState createState() => _InscriptionClientPageState();
}

class _InscriptionClientPageState extends State<InscriptionClientPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nomCtrl=TextEditingController();
  final TextEditingController prenomCtrl=TextEditingController();
  final TextEditingController date_naissCtrl=TextEditingController();
  final TextEditingController emailCtrl=TextEditingController();
  final TextEditingController passwordCtrl=TextEditingController();
  String nom = '', prenom = '', age = '', service = '',password="",login ='';
  File? image;
  final FocusNode _focusNode = FocusNode();
  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      }
    });
  }
  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (_focusNode.hasFocus) {
      // ACTION quand le TextFormField reçoit le focus
      print('Le TextFormField a reçu le focus!');
      // Tu peux mettre n'importe quelle autre action ici
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 70.0,
                    child: Icon(Icons.person,size: 50,),
                  ),
                ],
              ),

              SizedBox(height: 5,),
              TextK(label: "Nom", obscure: false, ctrl: nomCtrl),
              SizedBox(height: 10,),
              TextK(label: "Prenom", obscure: false, ctrl: nomCtrl),
              SizedBox(height: 10,),
              TextK(label: "age", obscure: false, ctrl: date_naissCtrl),
              SizedBox(height: 10,),
              TextK(label: "Email", obscure: false, ctrl: emailCtrl),
              SizedBox(height: 10,),
              TextK(label: "Password", obscure: false, ctrl: passwordCtrl),
              SizedBox(height: 10,),
              image != null
                  ? Image.file(image!, height: 100)
                  : Text('Aucune image sélectionnée'),
              ElevatedButton(
                onPressed: pickImage,
                child: Text('Choisir une image'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: ()async {
                  if (_formKey.currentState!.validate()) {
                    await AuthService().registerWithEmailAndPassword(login, password);
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Inscription envoyée !')));
                  }
                },
                child: Text("S'inscrire"),
              ),
            ],
          ),
        ),
    );
  }
}
