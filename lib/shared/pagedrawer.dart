import 'package:flutter/material.dart';
import 'package:test/pages/time.dart';
import 'package:test/pages/info.dart';
import 'package:test/models/country.dart';
import 'package:test/pages/quiz.dart';
import 'package:test/pages/request.dart';
import 'package:test/services/auth.dart';
import 'package:test/wrapper.dart';

class PageDrawer extends StatefulWidget {
  final Country country;

  const PageDrawer({Key? key, required this.country}) : super(key: key);

  @override
  _PageDrawerState createState() => _PageDrawerState();
}

class _PageDrawerState extends State<PageDrawer> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blueGrey[800],
            ),
            child: Center(
              child: Text(
                'Page Selection',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.language),
            title: Text('Country Time'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          CountryTime(country: widget.country)));
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('Country Information'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          CountryInfo(country: widget.country)));
            },
          ),
          ListTile(
            leading: Icon(Icons.quiz),
            title: Text('Country Quiz'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          CountryQuiz(country: widget.country)));
            },
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Country Request'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => CountryRequest(
                            country: widget.country,
                          )));
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () async {
              await _auth.signout();
              Navigator.pushReplacement<void, void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => Wrapper(),
                  ));
            },
          ),
        ],
      ),
    );
  }
}
