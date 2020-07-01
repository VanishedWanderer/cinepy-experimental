import 'package:flutter/material.dart';

class ChipInput<T> extends StatefulWidget {
  const ChipInput({
    @required this.findSuggestions,
    @required this.chipsBuilder,
    @required this.suggestionBuilder
}): super();

  @override
  State<StatefulWidget> createState() => _ChipInputState<T>();

  final SuggestionQuery<T> findSuggestions;
  final WidgetBuilder<T> chipsBuilder;
  final WidgetBuilder<T> suggestionBuilder;
}

typedef SuggestionQuery<T> = Future<List<T>> Function(String query);
typedef WidgetBuilder<T> = Widget Function(BuildContext context, T data, ChipsData<T> chips);
typedef ChipsDataListener = void Function();

class ChipsData<T> {
  ChipsData(){
    _chips = Set();
  }

  Set<T> _chips;
  ChipsDataListener _onAdd;
  ChipsDataListener _onDelete;
  ChipsDataListener _onChange;

  void add(T data){
    _chips.add(data);
    _onAdd?.call();
    _onChange?.call();
  }

  void delete(T data){
    _chips.remove(data);
    _onDelete?.call();
    _onChange?.call();
  }
}

class _ChipInputState<T> extends State<ChipInput<T>> {
  TextEditingController controller;

  List<T> _suggestions;
  ChipsData<T> _chipsData;

  void updateSuggestions() async {
    List<T> newSuggestions = await widget.findSuggestions(controller.text);
    newSuggestions = newSuggestions.where((element) => !_chipsData._chips.contains(element)).toList(growable: false);
    setState(() {
      _suggestions = newSuggestions;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _chipsData = ChipsData<T>();
    _chipsData._onChange = () {
      setState(() {});
      updateSuggestions();
    };

    controller = new TextEditingController(text: " ");
    controller.addListener(() {
      debugPrint(":${controller.text}:");
      updateSuggestions();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Wrap(
          children: _chipsData._chips.map((T chipData) {
            return widget.chipsBuilder(context, chipData, _chipsData);
          }).toList(growable: false),
          alignment: WrapAlignment.start,
        ),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder()
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _suggestions?.length ?? 0,
            itemBuilder: (context, position) {
              return widget.suggestionBuilder(context, _suggestions[position], _chipsData);
            },
          ),
        )
      ],
    );
  }
}