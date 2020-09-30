import 'dart:math';

import 'package:collection/collection.dart';
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

class Group {
  Group(this.title, this.candidates);

  String title;
  bool expanded = false;
  List<Candidate> candidates;
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
      .map((e) => Candidate(
          Movie(name: "Movie $e"),
          DateTime.now().add(Duration(days: Random().nextInt(5))),
          _cinemas[Random().nextInt(_cinemas.length)]))
      .toList(growable: false);

  final List<Candidate> acceptedItems = [];
  final List<Candidate> declinedItems = [];

  TabController controller;

  List<Group> groups;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
    groups = groupBy(items, (Candidate val) => val.cinema)
        .entries
        .map((e) => Group(e.key, e.value))
        .toList();
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
              title:
                  Hero(tag: widget.text, child: Text('Date for Kinogeh löl')),
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
                  padding: EdgeInsets.only(top: 100),
                  child: Text('sweet'),
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: controller,
          children: [
            Container(
                child: SingleChildScrollView(
                  child: ExpansionPanelList(
                      expansionCallback: (int index, bool expanded) {
                        setState(() {
                          groups[index].expanded = !expanded;
                        });
                      },
                      children: groups.map((e) {
                        return ExpansionPanel(
                            headerBuilder:
                                (BuildContext context, bool isExpanded) {
                              return Dismissible(
                                key: Key("DismissGroup ${e.title}"),
                                background: Container(color: Colors.green),
                                child: ListTile(title: Text(e.title)),
                                onDismissed: (direction) {
                                  setState(() {
                                    groups.remove(e);
                                  });
                                },
                              );
                            },
                            body: Column(
                                children: e.candidates.map((candidate) {
                              return Dismissible(
                                key: Key("${candidate.movie.name}"),
                                child:
                                    ListTile(title: Text(candidate.movie.name)),
                                onDismissed: (direction) {
                                  setState(() {
                                    e.candidates.remove(candidate);
                                  });
                                },
                              );
                            }).toList()),
                            isExpanded: e.expanded);
                      }).toList()),
                )
            ),
            Text('Hi'),
            Text('Hi'),
          ],
        ),
      ),
    );
  }
}

class _ChipsSliverPersistentHeaderDelegate
    extends SliverPersistentHeaderDelegate {
  const _ChipsSliverPersistentHeaderDelegate(this._listView);

  final ListView _listView;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      child: _listView,
    );
  }

  @override
  double get maxExtent => 60;

  @override
  double get minExtent => 60;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class _TabSliverPersistentHeaderDelegate
    extends SliverPersistentHeaderDelegate {
  const _TabSliverPersistentHeaderDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
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
