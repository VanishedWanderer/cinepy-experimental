import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChipInput<T> extends StatefulWidget {
  const ChipInput({
    @required this.findSuggestions
}): super();

  @override
  State<StatefulWidget> createState() => _ChipInputState();

  final ChipsInputSuggestions findSuggestions;
}

typedef ChipsInputSuggestions<T> = Future<List<T>> Function(String query);
typedef ChipSelected<T> = void Function(T data, bool selected);
typedef ChipsBuilder<T> = Widget Function(BuildContext context, T data);
typedef ChipsDataListener = void Function();

class ChipsData<T> {
  ChipsData();

  Set<T> _chips;
  ChipsDataListener _onAdd;
  ChipsDataListener _onDelete;

  void add(T data){
    _chips.add(data);
    _onAdd?.call();
  }

  void delete(T data){
    _chips.remove(data);
    _onDelete?.call();
  }
}

class _ChipInputState<T> extends State<ChipInput<T>> {
  static const kObjectReplacementChar = 0xFFFC;

  TextEditingController controller;

  List<String> _suggestions;

  FocusNode _textFieldFocusNode;

  void updateSuggestions(){
    setState(() {
      _suggestions = controller.text.runes.toList().map((e) => "Yeet $e").toList();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = new TextEditingController(text: " ");
    controller.addListener(() {
      if(controller.text.length == 0){
        controller.text = " ";
        debugPrint("DeadDelete");
      }else if(!controller.text.startsWith(" ")){
        controller.text = " " + controller.text;
      }
      debugPrint(":${controller.text}:");
      updateSuggestions();
    });
    _textFieldFocusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: controller,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _suggestions?.length ?? 0,
            itemBuilder: (context, position) {
              return Text("Suggestion $position, ${_suggestions[position]}");
            },
          ),
        )
      ],
    );
  }

}

/*
class _ChipInputState<T> extends State<ChipInput<T>> implements TextInputClient{
  static const kObjectReplacementChar = 0xFFFC;

  ChipsData<T> _chipsData = ChipsData();

  List<T> _suggestions;
  TextInputConnection _connection;
  TextEditingValue _value = TextEditingValue();
  bool get _hasInputConnection => _connection != null && _connection.attached;

  FocusNode _focusNode;

  String get text {
    return String.fromCharCodes(
      _value.text.codeUnits.where((ch) => ch != kObjectReplacementChar),
    );
  }

  void requestKeyboard() {
    if (_focusNode.hasFocus) {
      _openInputConnection();
    } else {
      FocusScope.of(context).requestFocus(_focusNode);
    }
  }

  void _openInputConnection() {
    if (!_hasInputConnection) {
      _connection = TextInput.attach(this, TextInputConfiguration());
      _connection.setEditingState(_value);
    }
    _connection.show();
  }

  void _closeInputConnectionIfNeeded() {
    if (_hasInputConnection) {
      _connection.close();
      _connection = null;
    }
  }

  void _onSearchChanged(String value) async {
    _suggestions = await widget.findSuggestions(value);
  }

  int _countReplacements(TextEditingValue value) {
    return value.text.codeUnits.where((ch) => ch == kObjectReplacementChar).length;
  }

  void _onFocusChanged() {
    if (_focusNode.hasFocus) {
      _openInputConnection();
    } else {
      _closeInputConnectionIfNeeded();
    }
    setState(() {
      // rebuild so that _TextCursor is hidden.
    });
  }

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChanged);
    _chipsData._onAdd = () {
      setState(() {
        //_updateTextInputState();
        _suggestions = null;
      });
      //widget.onChanged(_chipsData._chips.toList(growable: false));
    };
    _chipsData._onDelete = () {
      setState(() {
        //_updateTextInputState();
      });
      //widget.onChanged(_chipsData._chips.toList(growable: false));
    };
  }

  @override
  void dispose() {
    _focusNode?.dispose();
    _closeInputConnectionIfNeeded();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var textBoxChildren = _chipsData._chips
        .map<Widget>((data) => Chip(label: Text("Chip"),
    ))
        .toList();
    textBoxChildren.add(
      Container(
        height: 32.0,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              text,
              style: Theme.of(context).textTheme.subhead.copyWith(
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: requestKeyboard,
          child: InputDecorator(
            decoration: InputDecoration(),
            isFocused: _focusNode.hasFocus,
            isEmpty: _value.text.length == 0,
            child: Wrap(
              children: textBoxChildren,
            ),
          )
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _suggestions?.length ?? 0,
            itemBuilder: (context, index) {
              return Text("Suggestion $index");
          },),
        )
      ],

    );
  }


  //_----------------------------------------------

  @override
  void connectionClosed() {
    _focusNode.unfocus();
  }

  @override
  void performAction(TextInputAction action) {
    debugPrint("PerformAction");
    _focusNode.unfocus();
  }

  @override
  void updateEditingValue(TextEditingValue value) {
    final oldCount = _countReplacements(_value);
    final newCount = _countReplacements(value);
    setState(() {
      if (newCount < oldCount) {
        _chipsData._chips = Set.from(_chipsData._chips.take(newCount));
      }
      _value = value;
    });
    _onSearchChanged(text);
  }

  @override
  void updateFloatingCursor(RawFloatingCursorPoint point) {}

  @override
  TextEditingValue get currentTextEditingValue => throw UnimplementedError();

  @override
  // TODO: implement currentAutofillScope
  AutofillScope get currentAutofillScope => null;

  @override
  void showAutocorrectionPromptRect(int start, int end) {}
}

 */