import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

class MovieTab extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _MovieTabState();

}

class FilterPanel{
  bool isExpanded;
  Widget body;
  Widget header;

  FilterPanel({
    this.header,
    this.body,
    this.isExpanded = false,
  });
}

List<FilterPanel> _panels = [
  FilterPanel(
      header: ListTile(
        leading: Icon(Icons.location_on),
        title: Text('Location'),
        dense: true,
      ),
      body: Column(
        children: <Widget>[
          CheckboxListTile(
            value: false,
            title: Text('StarMovie Regau'),
            dense: true,
            onChanged: (bool value) {
              
            },
          )
        ],
      )
  ),
];

class _MovieTabState extends State<MovieTab>{

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: ExpansionPanelList(
          expansionCallback: (int index, bool isExpanded){
            setState(() {
              _panels[index].isExpanded = !isExpanded;
            });
          },
          children: _panels.map((e) => ExpansionPanel(
            isExpanded: e.isExpanded,
            canTapOnHeader: true,
            body: e.body,
            headerBuilder: (BuildContext context, bool isExpanded){
              return e.header;
            }
          )).toList(),
        ),
      ),
    );
  }

}