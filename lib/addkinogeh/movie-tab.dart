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

class CinemaCheckBox{
  bool value;
  Text name;

  CinemaCheckBox({
    this.name,
    this.value
  });
}

class _MovieTabState extends State<MovieTab>{

  List<FilterPanel> _panels;
  List<CinemaCheckBox> _cinemaBoxes;

  @override
  void initState() {
    _cinemaBoxes = [
      CinemaCheckBox(
        name: Text('Starmovie Regau'),
        value: false,
      ),
    ];

    _panels = [
      FilterPanel(
          isExpanded: true,
          header: ListTile(
            leading: Icon(Icons.location_on),
            title: Text('Location'),
            dense: true,
          ),
          body: Column(
            children: _cinemaBoxes.map((e) => CheckboxListTile(
              value: e.value,
              dense: true,
              title: e.name,
              onChanged: (bool value){
                setState(() {
                  print(value);
                  e.value = value;
                });
              },
            )).toList()
          )
      ),
    ];
  }

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