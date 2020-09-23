import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gemmakino/repository/facade/movies-facade.dart';
import 'package:gemmakino/repository/model/movie.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MoviesPage extends StatefulWidget {
  @override
  _MoviesPageState createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  List<Movie> _movies = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final MoviesFacade facade =
        Provider.of<MoviesFacade>(context, listen: false);
    return SmartRefresher(
      controller: _refreshController,
      enablePullDown: true,
      header: const ClassicHeader(
        refreshStyle: RefreshStyle.UnFollow,
        completeText: '',
      ),
      onRefresh: () async {
        try{
          final movies = await facade.queryAll();
          setState(() {
            _movies = movies;
          });
        }catch(OperationException){
          _refreshController.refreshFailed();
        }
        _refreshController.refreshCompleted();
      },
      child: ListView.builder(
          itemCount: _movies.length,
          itemBuilder: (_, index) {
            final movie = _movies[index];
            return Observer(
              builder: (_) => ListTile(
                title: Text(movie.name),
                subtitle: Text(movie.id.toString()),
              ),
            );
          }),
    );
  }
}
