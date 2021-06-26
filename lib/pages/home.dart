import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:umail/compose.dart';
import 'package:umail/login.dart';

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
          icon: Icon(
            FontAwesomeIcons.pen,
            size: 20,
          ),
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
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    icon: Icon(
                      Icons.account_circle,
                      size: 30,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "YOU" + "\n@Mail",
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
