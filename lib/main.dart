import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:umail/pages/history.dart';
import 'package:umail/pages/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    MaterialApp(
      title: "YOU@mail",
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;
  // ignore: non_constant_identifier_names
  List<Widget> _WidgetOptions = [
    Home(),
    History(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _WidgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.yellowAccent,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 30,
            ),
            // ignore: deprecated_member_use
            title: Text(
              "Home",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.history_toggle_off_sharp,
              size: 30,
            ),
            // ignore: deprecated_member_use
            title: Text(
              "History",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
