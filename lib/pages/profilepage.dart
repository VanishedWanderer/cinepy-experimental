
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget{
  @override
  _ProfilePageState createState() => _ProfilePageState();

}

class _ProfilePageState extends State<ProfilePage>{
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