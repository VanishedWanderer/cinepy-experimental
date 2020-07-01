import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:helloworld/darteye/ObservableList.dart';

class ObservingAnimatedList<T> extends StatefulWidget{
  const ObservingAnimatedList({
    this.list,
    this.itemBuilder,
    this.removeItemBuilder
  });

  final AddItemBuilder itemBuilder;
  final RemoveItemBuilder removeItemBuilder;
  final ObservableList<T> list;

  @override
  State<StatefulWidget> createState() => _ObservingAnimatedListState<T>();
}

typedef AddItemBuilder<T> = Widget Function(BuildContext context, int index, Animation animation);
typedef RemoveItemBuilder<T> = Widget Function(BuildContext context, T item, Animation animation);

class _ObservingAnimatedListState<T> extends State<ObservingAnimatedList<T>> {

  GlobalKey<AnimatedListState> _listState = GlobalKey();

  @override
  void initState() {
    widget.list.addObserver((args) {
      if(args.type == ChangeType.ADD){
        _listState.currentState.insertItem(args.index);
      }else if(args.type == ChangeType.REMOVE){
        _listState.currentState.removeItem(args.index, (context, animation) => widget.removeItemBuilder.call(context, args.item, animation));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: _listState,
      initialItemCount: widget.list.length,
      itemBuilder: (context, index, animation) => widget.itemBuilder.call(context, index, animation)
    );
  }


}