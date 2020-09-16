
import 'package:mobx/mobx.dart';

part 'movie.g.dart'; // flutter pub run build_runner build

class Movie = _Movie with _$Movie;

abstract class _Movie with Store {
  _Movie({this.id, this.name});

  @observable
  int id;

  @observable
  String name;
}