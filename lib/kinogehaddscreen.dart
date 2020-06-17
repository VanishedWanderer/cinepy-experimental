import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helloworld/parallax-tab/parallax-tab-background.dart';
import 'package:tinycolor/tinycolor.dart';

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
              bottomNavigationBar: ClippedTabBar(),
              body: SafeArea(
                child: Stack(
                  alignment: Alignment.topLeft,
                  children: [
                    Padding(
                      child: ParallaxTabBackground(
                        child: CustomPaint(
                          painter: YeetPainter(rectColor: TinyColor(Theme.of(context).accentColor).lighten(15).color),
                          size: Size(MediaQuery.of(context).size.width*2, 20),
                        )
                      ),
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                    ),
                    TabBarView(
                      controller: DefaultTabController.of(context),
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
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      TabBar(
        controller: DefaultTabController.of(context),
        tabs: [
          Tab(icon: Icon(Icons.directions_car)),
          Tab(icon: Icon(Icons.directions_bike)),
          Tab(icon: Icon(Icons.directions_run)),
        ],
      ),
      ClipPath(
        clipper: YeetClipper(),
        child: Material(
          color: Theme.of(context).primaryColor,
          child: TabBar(
            controller: DefaultTabController.of(context),
            tabs: [
              Tab(icon: Icon(Icons.directions_car)),
              Tab(icon: Icon(Icons.directions_bike)),
              Tab(icon: Icon(Icons.directions_run)),
            ],
          ),
        ),
      )
    ]);
  }
}


class KinoStep extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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

class YeetPainter extends CustomPainter{

  const YeetPainter({@required this.rectColor}): super();

  final rectSpacing = 10;

  final Color rectColor;

  @override
  void paint(Canvas canvas, Size size) {
    var rectSize = size.height;
    var padding = rectSize/2;
    var intervalSize = rectSize + 2*padding;
    var rectCount = size.width / intervalSize;

    var rectPaint = Paint();
    rectPaint.color = rectColor;

    var tempPaint = Paint();
    tempPaint.color = Colors.yellow;

    //canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), tempPaint);
    for(int i = 0; i < rectCount; i++){
//      canvas.drawRect(Rect.fromCenter(
//        center: Offset((i+0.5)*intervalSize+padding, size.height/2),
//        width: rectSize,
//        height: rectSize
//      ), rectPaint);
      canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromCenter(
        center: Offset((i+0.5)*intervalSize+padding, size.height/2),
        width: rectSize,
        height: rectSize
      ), Radius.circular(5)), rectPaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

}
