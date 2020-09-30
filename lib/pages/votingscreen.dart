import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:gemmakino/repository/model/candidate.dart';
import 'package:gemmakino/repository/model/movie.dart';

class VotingScreen extends StatefulWidget {
  const VotingScreen({@required this.text});

  @override
  State<StatefulWidget> createState() => _VotingScreenState();

  final String text;
}

class Question {
  Question(this.text, this.predicate);

  final String text;
  Status status;
  final bool Function(Candidate, Status) predicate;

  bool allows(Candidate candidate) {
    return predicate(candidate, status);
  }
}

class _VotingScreenState extends State<VotingScreen>
    with SingleTickerProviderStateMixin {
  static final List<String> _cinemas = [
    "OinkBoinkCinema",
    "WongoSchwongoCinema",
    "Lölchenplexx"
  ];
  final List<Candidate> items = 'abcdefghjiklmnopqrstuvwxyz'
      .characters
      .map((e) => Candidate(Movie(name: "Movie $e"), DateTime.now(),
      _cinemas[Random().nextInt(_cinemas.length)]))
      .toList(growable: false);

  final List<Candidate> acceptedItems = [];
  final List<Candidate> declinedItems = [];

  final List<Question> questions = _cinemas.map((e) {
    return Question("Would you go to cinema ${e}", (c, s) => !(c.cinema == e));
  }).toList(growable: true);

  void accept(List<Candidate> list, int index) {
    acceptedItems.add(items.removeAt(index));
  }

  void decline(Candidate c){
    declinedItems.add(items.removeAt(index));
  }

  final List<Question> answeredQuestions = [];

  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, value) {
          return [
            SliverAppBar(
              pinned: true,
              floating: true,
              snap: true,
              title: Hero(
                  tag: widget.text, child: Text('Date for Kinogeh löl')),
              bottom: TabBar(
                controller: controller,
                tabs: const [
                  Tab(text: 'Oink'),
                  Tab(text: 'Boink'),
                  Tab(text: 'Zoink'),
                ],
              ),
              flexibleSpace: const FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: Padding(
                  padding: EdgeInsets.only(top: 100), child: Text('sweet'),),
              ),
            ),


          ];
        },
        body: TabBarView(
          controller: controller,
          children: [
            Container(
              child: CustomScrollView(
                  slivers: [
                    SliverList(delegate: SliverChildBuilderDelegate((
                        BuildContext context, int index) {
                      return Dismissible(
                          key: Key(questions[index].text),
                          secondaryBackground: Container(color: Colors.red),
                          background: Container(color: Colors.green),
                          child: ListTile(
                            title: Text(questions[index].text),
                          ),
                          onDismissed: (direction) {
                            setState(() {
                              if (direction == DismissDirection.startToEnd) {
                                questions[index].status = Status.ACCEPTED;
                              } else {
                                questions[index].status = Status.DECLINED;
                              }
                              answeredQuestions.add(questions.removeAt(index));
                            });
                          },
                      );
                    }, childCount: questions.length)),

                    SliverList(delegate: SliverChildBuilderDelegate((
                        BuildContext context, int index) {
                      return Dismissible(
                          key: Key(items[index].hashCode.toString()),
                          secondaryBackground: Container(color: Colors.red),
                          background: Container(color: Colors.green),
                          onDismissed: (direction) {
                            if (direction == DismissDirection.startToEnd) {
                              setState(() {
                                items[index].status = Status.ACCEPTED;
                              });
                              Scaffold.of(context).showSnackBar(SnackBar(
                                  content:
                                  Text('Item ${items[index]} accepted.')));
                            } else
                            if (direction == DismissDirection.endToStart) {
                              setState(() {
                                items[index].status = Status.DECLINED;
                              });
                              Scaffold.of(context).showSnackBar(SnackBar(
                                  content:
                                  Text('Item ${items[index]} declined.')));
                            }
                          },
                          child:
                          ListTile(title: Text('${items[index].movie
                              .name} played in ${items[index]
                              .cinema} on ${items[index].time.toLocal()}')));
                    }, childCount: items.length))
                  ]
              ),
            ),



            Text('Hi'),
          ],
        ),
      ),
    );
  }
}

class _TabSliverPersistentHeaderDelegate
    extends SliverPersistentHeaderDelegate {
  const _TabSliverPersistentHeaderDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  Widget build(BuildContext context, double shrinkOffset,
      bool overlapsContent) {
    return Container(
      child: _tabBar,
    );
  }

  @override
  double get maxExtent => _tabBar.preferredSize.height + 20;

  @override
  double get minExtent => _tabBar.preferredSize.height + 20;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
