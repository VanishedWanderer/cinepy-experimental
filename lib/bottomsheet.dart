import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
          onTap: () {},
          ),
          const Divider(),
          ListTile(
            title: Text('Einstellungen'),
            leading: Icon(Icons.settings),
          onTap: () {},
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