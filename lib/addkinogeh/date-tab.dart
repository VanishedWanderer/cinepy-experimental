
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DateTab extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _DateTabState();
}

class _DateTabState extends State<DateTab>{

  DateTimeRange pickedDate;
  TimeOfDay pickedTimeFrom;
  TimeOfDay pickedTimeTo;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Center(
          child: FlatButton(
            child: Text(pickedDate.toString()),
            onPressed: () async {
              pickedDate = await showDateRangePicker(
                context: context,
                firstDate: new DateTime(DateTime.now().year),
                lastDate: new DateTime(DateTime.now().year+2),
                initialDateRange: new DateTimeRange(start: new DateTime.now(), end: (new DateTime.now()).add(new Duration(days: 3))),
                saveText: "Speichern",
                helpText: "Datum auswählen",
                fieldStartHintText: "tt.mm.jjjj",
                fieldEndHintText: "tt.mm.jjjj",
                fieldStartLabelText: "Startdatum",
                fieldEndLabelText: "Enddatum",
                confirmText: "OK",
                cancelText: "Abbrechen",
                errorInvalidRangeText: "Ungültige Daten"
              );
            },
          ),
        ),
        Divider(),
        Center(
          child: FlatButton(
            child: Text(pickedTimeFrom.toString()),
            onPressed: () async {
              pickedTimeFrom = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
            },
          ),
        ),
        Center(
          child: FlatButton(
            child: Text(pickedTimeTo.toString()),
            onPressed: () async {
              pickedTimeTo = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
            },
          ),
        )
      ],
    );
  }
}