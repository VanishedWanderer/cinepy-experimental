import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class KinoGehAddScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _KinoGehAddScreenState();
}

class _KinoGehAddScreenState extends State<KinoGehAddScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            backgroundColor: Theme.of(context).accentColor,
            bottomNavigationBar: Stack(children: [
              TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.directions_car, color: Colors.black)),
                  Tab(icon: Icon(Icons.directions_bike, color: Colors.black)),
                  Tab(icon: Icon(Icons.directions_run, color: Colors.black)),
                ],
              ),
              ClipPath(
                clipper: YeetClipper(),
                child: Material(
                  color: Theme.of(context).primaryColor,
                  child: TabBar(
                    tabs: [
                      Tab(icon: Icon(Icons.directions_car)),
                      Tab(icon: Icon(Icons.directions_bike)),
                      Tab(icon: Icon(Icons.directions_run)),
                    ],
                  ),
                ),
              )
            ]),
            body: SafeArea(
              child: Column(children: [
                Expanded(
                  child: TabBarView(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Card(
                          child: Text("Car"),
                          elevation: 10,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Card(
                          child: Text("Bike"),
                          elevation: 10,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Card(
                          child: Text("Feet"),
                          elevation: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            )));
  }
}

class YeetClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..lineTo(0.0, size.height)
      ..lineTo(size.width / 1.8, size.height)
      ..lineTo(size.width / 2.2, 0.0)
      ..lineTo(0.0, 0.0)
      ..close();
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
