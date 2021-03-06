  import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:gemmakino/darteye/ObservableMixin.dart';

typedef CompareBy<T, O extends Comparable<T>> = O Function(T element);

enum ChangeType {
  ADD,
  REMOVE,
  SET
}

@immutable
class ChangeEventArgs<T> {
  const ChangeEventArgs({
    this.index,
    this.type,
    this.item
  });
  final int index;
  final ChangeType type;
  final T item;
}

class ObservableList<T> with ListMixin<T>, ObservableMixin<ChangeEventArgs<T>>{
  ObservableList(List<T> list){
    this._list = list;
  }

  List<T> _list;

  @override
  int get length => _list.length;
  set length(int value) => _list.length = value;

  @override
  T operator [](int index) {
    return _list[index];
  }

  @override
  void operator []=(int index, T value) {
    _list[index] = value;
    notifyChanged(ChangeEventArgs(index: index, type: ChangeType.SET, item: value));
  }

  @override
  T removeAt(int index) {
    var element = _list.removeAt(index);
    notifyChanged(ChangeEventArgs(index: index, type: ChangeType.REMOVE, item: element));
    return element;
  }

  @override
  void insert(int index, T element) {
    _list.insert(index, element);
    notifyChanged(ChangeEventArgs(index: index, type: ChangeType.ADD, item: element));
  }

  @override
  bool remove(Object element) {
    assert(element is T);
    var index = _list.indexOf(element as T);
    if(index >= 0){
      notifyChanged(ChangeEventArgs(index: index, type: ChangeType.REMOVE, item: element as T));
    }
    return index >= 0;
  }

  @override
  T removeLast() {
    var element = _list.removeLast();
    notifyChanged(ChangeEventArgs(index: length - 1, type: ChangeType.REMOVE, item: element));
    return element;
  }

  void morphTo<O extends Comparable<T>>(List<T> other){
    int myIndex = 0;
    int otherIndex = 0;

    while(myIndex < length && otherIndex < other.length){
      if(this[myIndex] == other[otherIndex]){
        if(this[myIndex] != other[otherIndex])
          this[myIndex] = other[otherIndex];
        myIndex++;
        otherIndex++;
      }else{
        if(contains(other[otherIndex])){
          while(this[myIndex] != other[otherIndex]){ //No ioub should be possible
            removeAt(myIndex);
          }
        }else{
          insert(myIndex, other[otherIndex]);
          myIndex++;
          otherIndex++;
        }
      }
    }
    while(myIndex < length){
      removeAt(myIndex);
    }
    while(otherIndex < other.length){
      insert(myIndex, other[otherIndex]);
      myIndex++;
      otherIndex++;
    }
  }
}