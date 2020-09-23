import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class VotingScreen extends StatefulWidget {
  const VotingScreen({@required this.text});

  @override
  State<StatefulWidget> createState() => _VotingScreenState();

  final String text;
}

class _VotingScreenState extends State<VotingScreen>
    with SingleTickerProviderStateMixin {
  final List<String> items = '012301230123012301230'
      .characters
      .map((e) => 'Item $e')
      .toList(growable: true);

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
              title: Hero(tag: widget.text, child: Text('Date for Kinogeh löl')),
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
              ),
            )
          ];
        },
        body: TabBarView(
          controller: controller,
          children: [
            Container(
              child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Dismissible(
                        key: Key(items[index]),
                        secondaryBackground: Container(color: Colors.red),
                        background: Container(color: Colors.green),
                        onDismissed: (direction) {
                          setState(() {
                            items.removeAt(index);
                          });
                          if (direction == DismissDirection.startToEnd) {
                            Scaffold.of(context).showSnackBar(SnackBar(
                                content:
                                    Text('Item ${items[index]} accepted.')));
                          } else if (direction == DismissDirection.endToStart) {
                            Scaffold.of(context).showSnackBar(SnackBar(
                                content:
                                    Text('Item ${items[index]} declined.')));
                          }
                        },
                        child:
                            ListTile(title: Text('YoinkYeet ${items[index]}')));
                  },
                  itemCount: items.length),
            ),
            Text('Hi'),
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
