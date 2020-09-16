
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LocationTab extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _LocationTabState();
}

class CinemaCheckBox{
  bool value;
  Text name;

  CinemaCheckBox({
    this.name,
    this.value
  });
}

class _LocationTabState extends State<LocationTab>{
  List<CinemaCheckBox> _cinemaBoxes;

  @override
  void initState() {
    _cinemaBoxes = [
      CinemaCheckBox(
        name: Text('Star Movie Regau'),
        value: false,
      ),
      CinemaCheckBox(
        name: Text('Star Movie Wels'),
        value: false,
      ),
      CinemaCheckBox(
        name: Text('Star Movie Steyr'),
        value: false,
      )
    ];
  }

  @override
  Widget build(BuildContext context){
    return Column(
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
    );
  }
}