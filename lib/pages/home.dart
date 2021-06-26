import 'package:flutter/material.dart';
import 'package:umail/compose.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.black,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Compose()),
            );
          },
          icon: Icon(Icons.add),
          label: Text(
            "Compose",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30.0, 0.0, 0.0, 0.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(250.0, 0.0, 10.0, 0.0),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Settings()),
                      );
                    },
                    icon: Icon(Icons.menu),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "You" + "\n@Mail",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Drawer();
  }
}
