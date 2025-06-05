import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawerBeauty extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Drawer(
      width: (MediaQuery.of(context).size.width/2)+100,

      child: ListView(
        children: [
          DrawerHeader(
              child: Text("MENU")),
          ListTile(
            leading: Icon(CupertinoIcons.calendar_today),
            title: Text("RESERVATION"),
            onTap: (){
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(CupertinoIcons.calendar_today),
            title: Text("PRODUITS"),
            onTap: (){
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(CupertinoIcons.phone),
            title: Text("CONSULTATION"),
            onTap: (){
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(CupertinoIcons.phone),
            title: Text("LES APPLIS DU GROUPE MELMAR EMPIRE"),
            onTap: (){
              Scaffold.of(context).closeDrawer();
            },
          ),
        ],
      ),
    );
  }
}
