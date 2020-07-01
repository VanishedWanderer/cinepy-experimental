import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:helloworld/bottomsheet.dart';
import 'package:helloworld/kinogehaddscreen.dart';
import 'package:helloworld/pages/friendstab.dart';
import 'package:helloworld/pages/kinogehtab.dart';
import 'package:helloworld/pages/moviestab.dart';
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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SafeArea(
                child: Container(
                  color: Theme.of(context).primaryColor,
                  child: TabBar(
                    tabs: <Widget>[
                      Tab(icon: Icon(Icons.movie),),
                      Tab(icon: Icon(Icons.theaters),),
                      Tab(icon: Icon(Icons.people),),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                    children: <Widget>[
                      KinogehPage(),
                      MoviesPage(),
                      FriendsPage(),
                    ],
                ),
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
      ),
    );
  }
}
