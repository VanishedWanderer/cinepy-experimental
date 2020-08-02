import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:helloworld/bottomsheet.dart';
import 'package:helloworld/pages/friendstab.dart';
import 'package:helloworld/pages/kinogehtab.dart';
import 'package:helloworld/pages/moviestab.dart';
import 'package:helloworld/repository/facade/movies-facade.dart';
import 'package:helloworld/widgets/kinogehsearchdelegate.dart';
import 'package:provider/provider.dart';

import 'addkinogeh/kinogehaddscreen.dart';

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
          primaryColorBrightness: Brightness.light,
          primaryColorLight: Color(0xffff616f),
          primaryColorDark: Color(0xffc4001d),
          accentColor: Colors.blueGrey[900],
          accentColorBrightness: Brightness.dark,
          errorColor: Colors.yellowAccent[400],
          bottomAppBarColor: Colors.blueGrey[900],
          backgroundColor: Colors.white70,
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
    return MultiProvider(
      providers: genProviders(),
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SafeArea(
                  child: Container(
                    child: const TabBar(
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
                    color: Theme.of(context).primaryIconTheme.color,
                  ),
                ),
              );
            },
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomAppBar(
            shape: AutomaticNotchedShape(const RoundedRectangleBorder(),ContinuousRectangleBorder(borderRadius: BorderRadius.circular(28.0))),
            notchMargin: 6.0,
            child: Row(
              children: [
                IconButton(icon: const Icon(Icons.menu),color: Theme.of(context).accentIconTheme.color, onPressed: () {
                  showModalBottomSheet<BottomNav>(context: context, builder: (BuildContext context){
                    return BottomNav();
                  });
                },),
                Spacer(),
                IconButton(icon: const Icon(Icons.search), onPressed: () {
                  showSearch<dynamic>(context: context, delegate: KinogehSearchDelegate());
                }, color: Theme.of(context).accentIconTheme.color,),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Provider<dynamic>> genProviders() {
    return [
      Provider<MoviesFacade>(create: (_) => MoviesFacade())
    ];
  }
}
