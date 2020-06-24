import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:helloworld/bottomsheet.dart';
import 'package:helloworld/kinogehaddscreen.dart';
import 'package:helloworld/pages/friendspage.dart';
import 'package:helloworld/pages/moviespage.dart';
import 'package:helloworld/widgets/kinogehsearchdelegate.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/friends': (context) => FriendsPage(),
        '/movies': (context) => MoviesPage()
      },
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.redAccent[400],
          accentColor: Colors.blueGrey[900],
          fontFamily: 'Comfortaa'
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        color: Theme.of(context).accentColor,
        shape: AutomaticNotchedShape(RoundedRectangleBorder(),ContinuousRectangleBorder(borderRadius: BorderRadius.circular(28.0))),
        notchMargin: 6.0,
        child: Row(
          children: [
            IconButton(icon: Icon(Icons.menu),color: Theme.of(context).accentIconTheme.color, onPressed: () {
              showModalBottomSheet(context: context, builder: (BuildContext context){
                return BottomNav();
              });
            },),
            Spacer(),
            IconButton(icon: Icon(Icons.search), onPressed: () {
              showSearch(context: context, delegate: KinogehSearchDelegate());
            }, color: Theme.of(context).accentIconTheme.color,),
          ],
        ),
      ),
    );
  }
}
