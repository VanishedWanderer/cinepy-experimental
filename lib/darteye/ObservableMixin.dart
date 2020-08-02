import 'package:flutter/foundation.dart';

typedef ChangeCallback<T> = void Function(T element);
class ObservableMixin<T> {
  final ObserverList<ChangeCallback<T>> _observerList = ObserverList();

  void addObserver(ChangeCallback<T> callback){
    if(!_observerList.contains(callback)){
      _observerList.add(callback);
    }
  }

  void notifyChanged(T args){
    _observerList.forEach((element) => element.call(args));
  }
}