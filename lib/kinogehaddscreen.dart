import 'dart:math';

import 'package:flutter/material.dart';
import 'package:helloworld/parallax-tab/parallax-tab-background.dart';
import 'package:tinycolor/tinycolor.dart';

import 'filmpainter.dart';

class KinoGehAddScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _KinoGehAddScreenState();
}

class _KinoGehAddScreenState extends State<KinoGehAddScreen> with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
              backgroundColor: Theme.of(context).accentColor,
              bottomNavigationBar: ClippedTabBar(
                colorBackgroundFilled: Theme.of(context).primaryColor,
                colorIcon: Colors.white,
                colorIconFilled: Colors.white,
              ),
              body: SafeArea(
                child: Stack(
                  alignment: Alignment.topLeft,
                  children: [
                    Padding(
                      child: ParallaxTabBackground(
                        child: CustomPaint(
                          painter: FilmPainter(rectColor: TinyColor(Theme.of(context).accentColor).lighten(15).color),
                          size: Size(MediaQuery.of(context).size.width*2, 20),
                        )
                      ),
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                    ),
                    TabBarView(
                      children: [
                        KinoStep(),
                        KinoStep(),
                        KinoStep(),
                      ],
                    ),
                  ]
                ),
              )),
    );
  }
}

class ClippedTabBar extends StatelessWidget {

  const ClippedTabBar({
    this.colorIcon,
    this.colorIconFilled,
    this.colorBackground = Colors.transparent,
    this.colorBackgroundFilled
  }): super();

  final Color colorIcon;
  final Color colorIconFilled;
  final Color colorBackground;
  final Color colorBackgroundFilled;

  @override
  Widget build(BuildContext context) {
    var animMax = DefaultTabController.of(context).length-1;
    Animation<double> anim = DefaultTabController.of(context).animation;


    return Stack(children: [
      Material(
        color: this.colorBackground,
        child: TabBar(
          controller: DefaultTabController.of(context),
          tabs: [
            Tab(icon: Icon(Icons.directions_car, color: this.colorIcon)),
            Tab(icon: Icon(Icons.directions_bike, color: this.colorIcon)),
            Tab(icon: Icon(Icons.directions_run, color: this.colorIcon)),
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
                controller: DefaultTabController.of(context),
                tabs: [
                  Tab(icon: Icon(Icons.directions_car, color: this.colorIconFilled)),
                  Tab(icon: Icon(Icons.directions_bike, color: this.colorIconFilled)),
                  Tab(icon: Icon(Icons.directions_run, color: this.colorIconFilled)),
                ],
              ),
            ),
          );
        },
      )
    ]);
  }
}

class KinoStep extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 35, 20, 20),
            child: Card(
              child: Text("Bike"),
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
      ..lineTo(0.0, size.height)
      ..lineTo(size.width * percentage, size.height)
      ..lineTo(size.width * percentage, 0.0)
      ..lineTo(0.0, 0.0)
      ..close();
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}


