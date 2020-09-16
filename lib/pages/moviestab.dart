
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gemmakino/repository/facade/movies-facade.dart';
import 'package:gemmakino/repository/model/movie.dart';
import 'package:provider/provider.dart';
class MoviesPage extends StatefulWidget{
  @override
  _MoviesPageState createState() => _MoviesPageState();

}

class _MoviesPageState extends State<MoviesPage>{


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final MoviesFacade facade = Provider.of<MoviesFacade>(context);
    facade.queryAll();

    return Column(
      children: [
        Expanded(
          child: Observer(
            builder: (_) => ListView.builder(
                itemCount: facade.movies?.length ?? 0,
                itemBuilder: (_, index) {
                  final movie = facade.movies[index];
                  return Observer(
                    builder: (_) => ListTile(
                      title: Text(movie.name),
                      subtitle: Text(movie.id.toString()),
                    ),
                  );
                }
            ),
          ),
        ),
        MaterialButton(
          onPressed: () {

            var movie = Movie();
            movie.id = Random().nextInt(102);
            movie.name = 'ÖÖHH';
            facade.movies.add(movie);
          },
          child: const Text('Add'),
        )
      ],
    );
  }

}