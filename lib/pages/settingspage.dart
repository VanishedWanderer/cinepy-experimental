
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget{
  @override
  _SettingsPageState createState() => _SettingsPageState();

}

class _SettingsPageState extends State<SettingsPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SafeArea(
            child: ButtonBar(
              alignment: MainAxisAlignment.start,
              children: <Widget>[
                IconButton(icon: Icon(Icons.arrow_back),onPressed: () {
                  Navigator.pop(context);
                },)
              ],
            ),
          )
        ],
      ),
    );
  }

}