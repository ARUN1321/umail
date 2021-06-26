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
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.black,
        onPressed: () {
          showModalBottomSheet(
              backgroundColor: Colors.black,
              context: context,
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        recurringschedule(context),
                        weeklyschedule(context),
                        monthlyschedule(context),
                        yearlyschedule(context),
                      ],
                    ),
                  ),
                );
              });
        },
        label: Text("Schedule"),
        icon: Icon(Icons.schedule_sharp),
      ),
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.grey[300],
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.send,
                color: Colors.black,
              ))
        ],
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
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "To",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "CC",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Subject",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget recurringschedule(BuildContext context) => ExpansionTile(
      title: Text(
        "Recurring schedule",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      children: [
        Container(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 200, 10),
            child: TextField(),
          ),
        ),
        Container(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 200, 10),
            child: TextField(),
          ),
        ),
      ],
    );
Widget weeklyschedule(BuildContext context) => ExpansionTile(
      title: Text(
        "Weekly schedule",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      children: [
        Text(
          "arun",
        )
      ],
    );
Widget monthlyschedule(BuildContext context) => ExpansionTile(
      title: Text(
        "Monthly schedule",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      children: [Text("arun")],
    );
Widget yearlyschedule(BuildContext context) => ExpansionTile(
      title: Text(
        "Yearly schedule",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      children: [Text("arun")],
    );
