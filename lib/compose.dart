import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:umail/main.dart';
import 'package:get/get.dart';

class Compose extends StatefulWidget {
  const Compose({Key? key}) : super(key: key);

  @override
  _ComposeState createState() => _ComposeState();
}

class _ComposeState extends State<Compose> {
  late TextEditingController timeController;
  late TextEditingController typeController;
  late TextEditingController toController;
  late TextEditingController subjectController;
  late TextEditingController bodyController;
  bool loading = false;
  String value = "30";
  String type = "sec";

  @override
  void initState() {
    timeController = new TextEditingController();
    typeController = new TextEditingController();
    toController = new TextEditingController();
    subjectController = new TextEditingController();
    bodyController = new TextEditingController();
    super.initState();
  }

  Widget showLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.grey[300],
        actions: [
          IconButton(
              onPressed: () async {
                if (toController.text.length > 0 &&
                    subjectController.text.length > 0 &&
                    bodyController.text.length > 0) {
                  //send
                  final map = {
                    "message": {
                      "from": "umail.flipr@gmail.com",
                      "subject": subjectController.text,
                      "text": bodyController.text,
                      "to": toController.text,
                    },
                    "status": true,
                    "time": {
                      "type": type,
                      "value": value,
                    }
                  };
                  setState(() {
                    loading = true;
                  });
                  await addRecMail(map);
                  setState(() {
                    loading = false;
                  });
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (
                    BuildContext context,
                  ) {
                    return MyApp();
                  }));
                } else {
                  Get.snackbar('Alert', 'Please fill all the values !');
                }
              },
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
      body: loading
          ? showLoading()
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: TextField(
                      controller: toController,
                      decoration: InputDecoration(
                        labelText: "To",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: TextField(
                      controller: subjectController,
                      decoration: InputDecoration(
                        labelText: "Subject",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
                    child: TextField(
                      controller: bodyController,
                      decoration: InputDecoration(
                        hintText: "Body",
                      ),
                      maxLines: 5,
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Recurring type :',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      //SECONDS
                      // ignore: deprecated_member_use
                      RaisedButton(
                        onPressed: () {
                          setState(() {
                            type = "sec";
                            value = "30";
                          });
                        },
                        color: Colors.black,
                        child: Text(
                          'Seconds',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      //WEEKS
                      // ignore: deprecated_member_use
                      RaisedButton(
                        onPressed: () async {
                          await Get.defaultDialog(
                              title: 'Week',
                              // ignore: deprecated_member_use
                              confirm: RaisedButton(
                                color: Colors.black,
                                onPressed: () {
                                  if (timeController.text.length == 5 &&
                                      typeController.text.length == 1) {
                                    print('yess');
                                    setState(() {
                                      type = "week";
                                      value = timeController.text +
                                          ' ' +
                                          typeController.text;
                                    });
                                    Get.back();
                                  }
                                },
                                child: Text(
                                  'Add',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              content: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    child: TextField(
                                      controller: timeController,
                                      decoration: InputDecoration(
                                          hintText: 'Eg. 10:00 (time)'),
                                    ),
                                  ),
                                  Container(
                                    child: TextField(
                                      controller: typeController,
                                      decoration: InputDecoration(
                                          hintText: 'Eg. 0-6 (days)'),
                                    ),
                                  ),
                                ],
                              ));
                        },
                        color: Colors.black,
                        child: Text(
                          'Weeks',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      //MONTHS
                      // ignore: deprecated_member_use
                      RaisedButton(
                        onPressed: () async {
                          await Get.defaultDialog(
                              title: 'Month',
                              // ignore: deprecated_member_use
                              confirm: RaisedButton(
                                color: Colors.black,
                                onPressed: () {
                                  if (timeController.text.length == 5 &&
                                      typeController.text.length > 0) {
                                    setState(() {
                                      type = "month";
                                      value = timeController.text +
                                          ' ' +
                                          typeController.text;
                                    });
                                    Get.back();
                                  }
                                },
                                child: Text(
                                  'Add',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              content: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    child: TextField(
                                      controller: timeController,
                                      decoration: InputDecoration(
                                          hintText: 'Eg. 10:00 (time)'),
                                    ),
                                  ),
                                  Container(
                                    child: TextField(
                                      controller: typeController,
                                      decoration: InputDecoration(
                                          hintText: 'Eg. 0-31 (date)'),
                                    ),
                                  ),
                                ],
                              ));
                        },
                        color: Colors.black,
                        child: Text(
                          'Months',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      //YEARS
                      // ignore: deprecated_member_use
                      RaisedButton(
                        onPressed: () async {
                          await Get.defaultDialog(
                              title: 'Month',
                              // ignore: deprecated_member_use
                              confirm: RaisedButton(
                                color: Colors.black,
                                onPressed: () {
                                  if (timeController.text.length == 5 &&
                                      typeController.text.length > 2) {
                                    setState(() {
                                      type = "year";
                                      value = timeController.text +
                                          ' ' +
                                          typeController.text;
                                    });
                                    Get.back();
                                  }
                                },
                                child: Text(
                                  'Add',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              content: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    child: TextField(
                                      controller: timeController,
                                      decoration: InputDecoration(
                                          hintText: 'Eg. 10:00 (time)'),
                                    ),
                                  ),
                                  Container(
                                    child: TextField(
                                      controller: typeController,
                                      decoration: InputDecoration(
                                          hintText: 'Eg. 01-02 (date-month)'),
                                    ),
                                  ),
                                ],
                              ));
                        },
                        color: Colors.black,
                        child: Text(
                          'Years',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Current Type : '),
                      Chip(
                        label: Text('$type'),
                        backgroundColor: Colors.greenAccent,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Current Value : '),
                      Chip(
                        label: Text('$value'),
                        backgroundColor: Colors.greenAccent,
                      ),
                    ],
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

addRecMail(map) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  final id = pref.getString('user');
  final docRef =
      await FirebaseFirestore.instance.collection('RecMails').add(map);
  await FirebaseFirestore.instance.collection('Users').doc(id).update({
    "rec": FieldValue.arrayUnion([docRef.id])
  });
}
