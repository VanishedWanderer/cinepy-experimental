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
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0))
      ),
      child: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          ListTile(
            title: const Text('Profil'),
            leading: const Icon(Icons.person),
          onTap: () {
              Navigator.push<ProfilePage>(context, MaterialPageRoute<ProfilePage>(builder: (BuildContext context) => ProfilePage()));
          },
          ),
          const Divider(),
          ListTile(
            title: Text('Einstellungen'),
            leading: Icon(Icons.settings),
          onTap: () {
              Navigator.push<SettingsPage>(context, MaterialPageRoute(builder: (context) => SettingsPage()));
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