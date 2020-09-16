import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gemmakino/repository/BackendAdapter.dart';
import 'package:gemmakino/repository/model/movie.dart';
import 'package:gemmakino/util/collection-util.dart';
import 'package:graphql/client.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

part 'movies-facade.g.dart'; // flutter pub run build_runner build

abstract class MoviesFacade = _MoviesFacade with _$MoviesFacade;


abstract class _MoviesFacade with Store {
  ObservableList<Movie> movies;

  Future<List<Movie>> queryAll();
}


class MoviesGraphQlFacade extends MoviesFacade {
  @override
  Future<List<Movie>> queryAll() async{
    final value = await BackendAdapter().client.query(QueryOptions(
      documentNode: gql(r'''
      query {
        movies {
          name
        }
      }
      '''),
      fetchPolicy: FetchPolicy.networkOnly

    ));
    if(value.hasException){
      throw value.exception;
    }else{
      final rawMovies = value.data['movies'] as List<dynamic>;
      print(rawMovies);
      final newMovies = rawMovies.map((dynamic e) => Movie(id: 0, name: e['name'] as String)).toList();
      movies = ObservableList.of(newMovies);
      return newMovies;
    }
  }
}

class MoviesMockFacade extends MoviesFacade {
  @override
  Future<List<Movie>> queryAll() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    final list = [
      'The Lighthouse', 'Parasite', 'Knives Out', 'Joker', 'Once Upon a Time... in Hollywood', 'John Wick'
    ].mapIndexed((index, item) => Movie(id: index, name: item)).toList();
    movies = ObservableList.of(list);
    final random = Random();
    
    Timer.periodic(const Duration(seconds: 5), (_) {
      movies[random.nextInt(movies.length)].name += 'a';
    });
    return list;
  }
}