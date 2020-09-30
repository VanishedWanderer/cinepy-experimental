import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gemmakino/repository/facade/movies-facade.dart';
import 'package:gemmakino/repository/model/movie.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MovieTab extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _MovieTabState();

}

class _MovieTabState extends State<MovieTab>{

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
    () async {
      final movies = await facade.queryAll();
      setState(() {
        _movies = movies;
      });
    };
    return ListView.builder(
      itemCount: _movies.length,
      itemBuilder: (context, index){
        return Card(
          child: Row(
            children: [
              const Image(
                image: NetworkImage('https://images-na.ssl-images-amazon.com/images/I/71ZSmi1U8kL._AC_SL1481_.jpg'),
                width: 100,
                height: 200,
              ),
              Column(
                children: [

                ],
              )
            ],
          ),
        );
      }
    );
  }

}