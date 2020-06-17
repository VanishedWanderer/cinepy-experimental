import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:helloworld/addkinogeh/kinogehaddscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.redAccent[400],
          accentColor: Colors.blueGrey[900],
          fontFamily: 'Comfortaa'
      ),
      home: MyHomePage()
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: OpenContainer(
        openBuilder: (BuildContext context, VoidCallback _) {
          return KinoGehAddScreen();
        },
        closedElevation: 6.0,
        closedShape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(56 / 2),
        ),
        closedColor: Theme.of(context).primaryColor,
        closedBuilder: (BuildContext context, VoidCallback openContainer) {
          return SizedBox(
            height: 56,
            width: 56,
            child: Center(
              child: Icon(
                Icons.movie,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
          );
        },
      ),



      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: AutomaticNotchedShape(RoundedRectangleBorder(),ContinuousRectangleBorder(borderRadius: BorderRadius.circular(28.0))),
        notchMargin: 6.0,
        child: Row(
          children: [
            IconButton(icon: Icon(Icons.menu), onPressed: () {},),
            IconButton(icon: Icon(Icons.search), onPressed: () {},),
          ],
        ),
      ),
    );
  }
}
