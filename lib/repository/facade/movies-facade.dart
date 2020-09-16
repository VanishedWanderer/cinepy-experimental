import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:gemmakino/repository/model/movie.dart';
import 'package:gemmakino/util/collection-util.dart';
import 'package:mobx/mobx.dart';

part 'movies-facade.g.dart'; // flutter pub run build_runner build

abstract class MoviesFacade = _MoviesFacade with _$MoviesFacade;


abstract class _MoviesFacade with Store {
  @observable
  ObservableList<Movie> movies;

  void queryAll();
}




class MoviesMockFacade extends MoviesFacade {
  @override
  void queryAll() {
    Future<void>.delayed(const Duration(milliseconds: 500)).then((value) {
        movies = ObservableList.of([
          'The Lighthouse', 'Parasite', 'Knives Out', 'Joker', 'Once Upon a Time... in Hollywood', 'John Wick'
        ].mapIndexed((index, item) => Movie(id: index, name: item)).toList());
    });

    final random = Random();
    
    Timer.periodic(const Duration(seconds: 5), (_) {
      movies[random.nextInt(movies.length)].name += 'a';
    });
  }
}