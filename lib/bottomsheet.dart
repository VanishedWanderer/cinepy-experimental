import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helloworld/pages/profilepage.dart';
import 'package:helloworld/pages/settingspage.dart';

class BottomNav extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _BottomNavState();

}

class _BottomNavState extends State<BottomNav>{
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0))
      ),
      child: ListView(
        padding: EdgeInsets.all(8),
        children: <Widget>[
          ListTile(
            title: Text('Profil'),
            leading: Icon(Icons.person),
          onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
          },
          ),
          const Divider(),
          ListTile(
            title: Text('Einstellungen'),
            leading: Icon(Icons.settings),
          onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
          },
          ),
          const Divider(),
          ListTile(
            title: Text('Über die App'),
            leading: Icon(Icons.info_outline),
            onTap: () { showAboutDialog(context: context); },
          )
        ],
      )
    );
  }

}