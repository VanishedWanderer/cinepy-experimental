import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VotingScreen extends StatefulWidget {
  const VotingScreen({@required this.text});

  @override
  State<StatefulWidget> createState() => _VotingScreenState();

  final String text;
}

class _VotingScreenState extends State<VotingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: false,
            floating: true,
            snap: false,
            title: Hero(
              tag: widget.text,
              child:
                const Material(
                    type: MaterialType.transparency,
                    textStyle: TextStyle(fontWeight: FontWeight.bold,
                        fontSize: 10,
                        color: Colors.black),
                    child: Text('Date for Kinogeh löl')
                )
            ),
          ),
          SliverList(delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
            return ListTile(title: Text('YoinkYeet $index'));
          }, childCount: 40))
        ],
      ),
    );
  }
}
