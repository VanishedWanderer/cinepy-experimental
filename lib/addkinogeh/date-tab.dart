
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTab extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _DateTabState();
}

class _DateTabState extends State<DateTab>{

  DateTimeRange pickedDate;
  TimeOfDay pickedTimeFrom;
  TimeOfDay pickedTimeTo;
  Text timeToText = const Text('Bis');
  Text timeFromText = const Text('Von');
  Text dateText = const Text('Datum');
  DateFormat dateFormat = DateFormat('dd.MM.yy');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: FlatButton(
            child: dateText,
            onPressed: () async {
              pickedDate = await showDateRangePicker(
                context: context,
                firstDate: DateTime(DateTime.now().year),
                lastDate: DateTime(DateTime.now().year+2),
                initialDateRange: DateTimeRange(start: DateTime.now(), end: DateTime.now().add(const Duration(days: 3))),
                saveText: 'Speichern',
                helpText: 'Datum auswählen',
                fieldStartHintText: 'tt.mm.jjjj',
                fieldEndHintText: 'tt.mm.jjjj',
                fieldStartLabelText: 'Startdatum',
                fieldEndLabelText: 'Enddatum',
                confirmText: 'OK',
                cancelText: 'Abbrechen',
                errorInvalidRangeText: 'Ungültige Daten'
              );
              setState(() {
                if(pickedDate != null){
                  dateText = Text(dateFormat.format(pickedDate.start) + ' - ' + dateFormat.format(pickedDate.end));
                }
                else{
                  dateText = const Text('Datum');
                }
              });
            },
          ),
        ),
        const Divider(),
        Center(
          child: FlatButton(
            child: timeFromText,
            onPressed: () async {
              pickedTimeFrom = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              setState(() {
                if(pickedTimeFrom != null){
                  timeFromText = Text(pickedTimeFrom.format(context));
                }
                else{
                  timeFromText = const Text('Von');
                }
              });
            },
          ),
        ),
        Center(
          child: FlatButton(
            child: timeToText,
            onPressed: () async {
              pickedTimeTo = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              setState(() {
                if(pickedTimeTo != null){
                  timeToText = Text(pickedTimeTo.format(context));
                }
                else{
                  timeToText = const Text('Bis');
                }
              });
            },
          ),
        )
      ],
    );
  }
}