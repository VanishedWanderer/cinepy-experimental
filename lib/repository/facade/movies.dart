import 'package:helloworld/repository/model/movie.dart';
import 'package:mobx/mobx.dart';

part 'movies.g.dart';

class MoviesFacade = _MoviesFacade with _$MoviesFacade;

abstract class _MoviesFacade with Store {
  @observable
  ObservableList<Movie> movies = ObservableList<Movie>();
}