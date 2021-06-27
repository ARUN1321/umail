import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:umail/compose.dart';
import 'package:umail/login.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.black,
          onPressed: () {
            Navigator.pushReplacement(
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
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "U-Mail",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // ignore: deprecated_member_use
                      RaisedButton(
                        onPressed: () async {
                          await _googleSignIn.signOut();
                          await clearUserPref();
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) {
                              return LoginScreen();
                            },
                          ));
                          print("User Sign Out");
                        },
                        child: Text('SignOut'),
                      ),
                    ],
                  ),
                ),
                //here
                //listview here
                Expanded(
                  child: FutureBuilder<dynamic>(
                    future: recStream(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: Text('No recurring emails!'),
                          );
                        } else {
                          print(snapshot.data);
                          return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(
                                    '${snapshot.data[index]['message']['subject']}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(
                                    '${snapshot.data[index]['message']['text']}',
                                    maxLines: 1,
                                  ),
                                  trailing: Chip(
                                      label: Text(snapshot.data[index]['status']
                                          ? 'On'
                                          : 'Off')),
                                );
                              });
                        }
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                )
                //Expanded(child: Center(child: Text('No recurring emails!'))),
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

clearUserPref() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();
}

recStream() async {
  final prefs = await SharedPreferences.getInstance();
  final uid = prefs.getString('user');

  final qref =
      await FirebaseFirestore.instance.collection('Users').doc(uid).get();

  final data = qref.data()!['rec'];
  List<dynamic> mails = [];

  // ignore: deprecated_member_use
  if (data != null) {
    for (int i = 0; i < data.length; i++) {
      final ref = await FirebaseFirestore.instance
          .collection('RecMails')
          .doc(data[i])
          .get();

      mails.add(ref.data());
    }
  }

  return mails;
}
