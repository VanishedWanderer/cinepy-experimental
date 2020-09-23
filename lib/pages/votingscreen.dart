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

  final List<String> items = '012301230123012301230'.characters.map((e) => 'Item $e').toList(growable: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: false,
            floating: true,
            snap: false,
            flexibleSpace: TabBar(
              tabs: [
                Text('O')
              ],
            ),
            title: Hero(
              tag: widget.text,
              child: Text('Date for Kinogeh löl')
            ),
          ),
          SliverList(delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
            return Dismissible(
                key: Key(items[index]),
                secondaryBackground: Container(color: Colors.red),
                background: Container(color: Colors.green),
                onDismissed: (direction) {
                  setState(() {
                    items.removeAt(index);
                  });
                  if(direction == DismissDirection.startToEnd){
                    Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text('Item ${items[index]} accepted.'))
                    );
                  }else if(direction == DismissDirection.endToStart){
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text('Item ${items[index]} declined.'))
                    );
                  }
                },
                child: ListTile(title: Text('YoinkYeet ${items[index]}'))
            );
          }, childCount: items.length))
        ],
      ),
    );
  }
}
