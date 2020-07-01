
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class KinogehPage extends StatefulWidget{
  @override
  _KinogehPageState createState() => _KinogehPageState();

}

class _KinogehPageState extends State<KinogehPage>{



  @override
  Widget build(BuildContext context) {
    final List<String> items = <String>[
      'The Lighthouse', 'Parasite', 'Knives Out', 'Joker', 'Once Upon a Time... in Hollywood', 'John Wick'
    ];
    return ListView.builder(itemBuilder: (BuildContext context, int index){
      return Container(
        child: Card(
          margin: EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.movie_filter),
                title: Text('${items[index]}'),
              ),
              ButtonBar(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.delete),
                  )
                ],
              )
            ],
          ),
        ),
      );
      }, itemCount: items.length, primary: true,);
  }

}