import 'package:animations/animations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:helloworld/darteye/ObservableList.dart';
import 'package:helloworld/darteye/ui/ObservingAnimatedList.dart';

class TestTab2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TestTabState2();

}

class _TestTabState2 extends State<TestTab2> {

  final ObservableList<String> _items = ObservableList([]);
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ObservingAnimatedList(
            list: _items,
            itemBuilder: (context, index, animation) {
              return SizeTransition(
                axis: Axis.vertical,
                sizeFactor: animation,
                child: Card(
                  child: Text(_items[index]),
                ),
              );
            },
            removeItemBuilder: (context, String item, animation) {
              return SizeTransition(
                axis: Axis.vertical,
                sizeFactor: animation,
                child: Card(
                  child: Text('Removing $item'),
                ),
              );
            },
          )
        ),
        MaterialButton(
          onPressed: () {
            setState(() {
              _items.removeAt(2);
            });
          },
          child: Text("HI"),
        ),
        MaterialButton(
          onPressed: () {
            setState(() {
              _items.insert(0, "Bread $counter");
              counter++;
            });
          },
          child: Text("HI+"),
        ),
      ],
    );
  }
}