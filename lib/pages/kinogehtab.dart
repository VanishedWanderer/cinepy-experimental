
import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gemmakino/pages/votingscreen.dart';

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
      var heroTagName = 'KinoGeh$index';
      return Container(
        child: Card(
          shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(28.0), side: BorderSide(width: 0.1)),
          borderOnForeground: true,
          elevation: 0.0,
          margin: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              OpenContainer(
                closedBuilder: (context, openTile) {
                  return InkWell(
                    onTap: openTile,
                    child: ListTile(
                      leading: const Icon(Icons.movie_filter,),
                      title: const Text('Date for Kinogeh löl'),
                      subtitle: Text(items[index],),
                    ),
                  );
                },
                openBuilder: (context, closeTile) {
                  return VotingScreen(text: heroTagName);
                },
              ),
            ],
          ),
        ),
      );
      }, itemCount: items.length,);
  }

}