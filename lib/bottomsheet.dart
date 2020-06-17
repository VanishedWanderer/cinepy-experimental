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
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0))
      ),
      child: ListView(
        padding: EdgeInsets.all(8),
        children: <Widget>[
          ListTile(
            title: Text('Profile'),
            leading: Icon(Icons.person),
          onTap: () {},
          ),
          const Divider(),
          ListTile(
            title: Text('Settings'),
            leading: Icon(Icons.settings),
          onTap: () {},
          )
        ],
      )
    );
  }

}