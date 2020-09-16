import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gemmakino/addkinogeh/date-tab.dart';
import 'package:gemmakino/addkinogeh/location-tab.dart';
import 'package:gemmakino/addkinogeh/movie-tab.dart';
import 'package:gemmakino/addkinogeh/person-tab.dart';
import 'package:gemmakino/addkinogeh/screenings-tab.dart';
import 'package:gemmakino/addkinogeh/test-tab.dart';
import 'package:gemmakino/addkinogeh/test-tab2.dart';
import 'package:gemmakino/parallax-tab/parallax-tab-background.dart';
import 'package:tinycolor/tinycolor.dart';

import 'filmpainter.dart';

class KinoGehAddScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _KinoGehAddScreenState();
}

class _KinoGehAddScreenState extends State<KinoGehAddScreen> with SingleTickerProviderStateMixin {

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            bottomNavigationBar: ClippedTabBar(
              controller: _tabController,
              colorBackgroundFilled: TinyColor(Theme.of(context).accentColor).darken(5).color,
              colorIcon: Colors.white,
              colorIconFilled: Colors.white,
            ),
            body: SafeArea(
              child: Stack(
                alignment: Alignment.topLeft,
                children: [
                  Padding(
                    child: ParallaxTabBackground(
                      controller: _tabController,
                      child: CustomPaint(
                        painter: FilmPainter(rectColor: TinyColor(Theme.of(context).primaryColor).darken(15).color),
                        size: Size(MediaQuery.of(context).size.width*2, 20),
                      )
                    ),
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                  ),
                  TabBarView(
                    controller: _tabController,
                    children: [
                      KinoStep(child: PersonTab(), nextPressHandler: () => _tabController.animateTo(1)),
                      KinoStep(child: LocationTab(), nextPressHandler: () => _tabController.animateTo(2),),
                      KinoStep(child: DateTab(), nextPressHandler: () => _tabController.animateTo(3),),
                      KinoStep(child: MovieTab(), nextPressHandler: () => _tabController.animateTo(4),),
                      KinoStep(child: ScreeningsTab()),
                    ],
                  ),
                ]
              ),
            ));
  }
}

class ClippedTabBar extends StatelessWidget {

  const ClippedTabBar({
    this.colorIcon,
    this.colorIconFilled,
    this.colorBackground = Colors.transparent,
    this.colorBackgroundFilled,
    this.controller
  }): super();

  final Color colorIcon;
  final Color colorIconFilled;
  final Color colorBackground;
  final Color colorBackgroundFilled;
  final TabController controller;


  @override
  Widget build(BuildContext context) {

    var tabController = (controller ?? DefaultTabController.of(context));
    assert(tabController != null);

    var animMax = tabController.length-1;
    Animation<double> anim = tabController.animation;


    return Stack(children: [
      Material(
        color: this.colorBackground,
        child: TabBar(
          controller: tabController,
          tabs: [
            Tab(icon: Icon(Icons.person_add, color: this.colorIcon,)),
            Tab(icon: Icon(Icons.location_on, color: this.colorIcon,)),
            Tab(icon: Icon(Icons.calendar_today, color: this.colorIcon,)),
            Tab(icon: Icon(Icons.movie, color: this.colorIcon)),
            Tab(icon: Icon(Icons.local_movies, color: this.colorIcon,)),
          ],
        ),
      ),
      AnimatedBuilder(
        animation: anim,
        builder: (BuildContext context, Widget child){

          var percentage = ((anim.value / animMax)+0.15)/1.15;

          return ClipPath(
            clipper: BubblyClipper(percentage: percentage),
            child: Material(
              color: this.colorBackgroundFilled,
              child: TabBar(
                controller: tabController,
                tabs: [
                  Tab(icon: Icon(Icons.person_add, color: this.colorIconFilled)),
                  Tab(icon: Icon(Icons.location_on, color: this.colorIconFilled)),
                  Tab(icon: Icon(Icons.calendar_today, color: this.colorIconFilled)),
                  Tab(icon: Icon(Icons.movie, color: this.colorIconFilled)),
                  Tab(icon: Icon(Icons.local_movies, color: this.colorIconFilled)),
                ],
              ),
            ),
          );
        },
      )
    ]);
  }
}

typedef NextPressHandler = void Function();

class KinoStep extends StatelessWidget {
  const KinoStep({
    @required this.child,
    this.nextPressHandler
  }): super();
  final Widget child;
  final Function nextPressHandler;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 35, 20, 20),
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: child,
                  ),
                  FlatButton(
                    onPressed: () => nextPressHandler?.call(),
                    child: Text("Next"),
                  )
                ],
              ),
              elevation: 5,
            ),
          ),
        ),
       ],
    );
  }

}

class BubblyClipper extends CustomClipper<Path> {
  BubblyClipper({@required this.percentage}): super();

  double percentage;

  @override
  Path getClip(Size size) {
    return Path()
        ..lineTo(size.width*percentage-10, 0.0)
//        ..lineTo(size.width*percentage, 10.0)
        ..arcTo(Rect.fromCenter(center: Offset(size.width*percentage-10, 10), width: 20, height: 20), -pi/2, pi/2, false)
        ..lineTo(size.width*percentage, size.height)
        ..lineTo(0.0, size.height)
//      ..arcTo(Rect.fromCenter(center: Offset(10, size.width-10), width: 10, height: 10), 0, pi, false)
        ..close();
//      ..lineTo(0.0, size.height-10)
//      ..lineTo(size.width * percentage - 10, size.height)
//      ..arcTo(Rect.fromCenter(center: Offset(size.height-10, size.width-10), width: 10, height: 10), 0, pi, false)
//      ..lineTo(size.width * percentage, 0.0)
//      ..lineTo(0.0, 0.0)
//      ..close();
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}


