import 'package:flutter/material.dart';
import 'package:yt_clone/createPage.dart';
import 'theme_yt.dart' as th;
import 'homePage.dart';
import 'explorePage.dart';
import 'subscriptionPage.dart';
import 'libraryPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Youtube Demo',
      home: const MyHomePage(title: 'Youtube'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    homePageFrame(),
    explorePageFrame(),
    createPageFrame(),
    subsPageFrame(),
    libraryPageFrame(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: th.ytBackground,
      appBar: AppBar(
        backgroundColor: th.ytSurface,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/logo_yt.png',
              height: 32,
              // width: 35,
            ),
            SizedBox(width: 8),
            Text(
              widget.title,
              style: TextStyle(
                color: th.ytTextPrimary,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.cast,
            color:th.ytTextPrimary),

          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_none,
                color:th.ytTextPrimary),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search,
                color:th.ytTextPrimary),
          )
        ],
      ),

      body: _widgetOptions.elementAt(_selectedIndex),
      
      bottomNavigationBar: BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: th.ytSurface,
      selectedItemColor: th.ytTextPrimary,
      unselectedItemColor: Colors.grey,
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,

      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home,
              color:th.ytTextPrimary),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.explore,
              color:th.ytTextPrimary),
          label: "Explore",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_circle_outline,
              color:th.ytTextPrimary),
          label: "Create",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.subscriptions,
              color:th.ytTextPrimary),
          label: "Subscriptions",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.video_library,
              color:th.ytTextPrimary),
          label: "Library",
        ),
      ],
    ),

    );
  }
}
