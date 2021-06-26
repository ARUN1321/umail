import 'package:flutter/material.dart';
import 'package:umail/main.dart';

class Compose extends StatefulWidget {
  const Compose({Key? key}) : super(key: key);

  @override
  _ComposeState createState() => _ComposeState();
}

class _ComposeState extends State<Compose> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.grey[300],
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyApp()),
            );
          },
        ),
        title: Text(
          "Compose",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Container(),
    );
  }
}
