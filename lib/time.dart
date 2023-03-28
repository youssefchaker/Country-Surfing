import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test/models/country.dart';

class CountryTime extends StatefulWidget {
  final Country country;

  CountryTime({required this.country});

  @override
  _CountryTimeState createState() => _CountryTimeState();
}

class _CountryTimeState extends State<CountryTime> {
  String _currentTime = '';
  bool isDaytime = false;

  @override
  void initState() {
    super.initState();
    _getCurrentTime();
  }

  Future<void> _getCurrentTime() async {
    final int timezone = int.parse(widget.country.timezone![4]);
    final now = DateTime.now().toUtc().add(Duration(hours: timezone));
    final formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    setState(() {
      _currentTime = formatter.format(now) +
          ' UTC${timezone >= 0 ? '+' : ''}${timezone.toStringAsFixed(2)}';
    });
  }

  @override
  Widget build(BuildContext context) {
    // set background image
    isDaytime = DateTime.now()
                    .toUtc()
                    .add(
                        Duration(hours: int.parse(widget.country.timezone![4])))
                    .hour >
                6 &&
            DateTime.now()
                    .toUtc()
                    .add(
                        Duration(hours: int.parse(widget.country.timezone![4])))
                    .hour <
                20
        ? true
        : false;
    String bgImage = isDaytime ? 'day.png' : 'night.png';
    Color? bgColor = isDaytime ? Colors.blue : Colors.indigo[700];
    _getCurrentTime();

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/$bgImage'),
            fit: BoxFit.cover,
          )),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120.0, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  widget.country.name!,
                  style: TextStyle(
                    fontSize: 28.0,
                    letterSpacing: 2.0,
                    color: Colors.white,
                  ),
                ),
                Text(_currentTime,
                    style: TextStyle(fontSize: 66.0, color: Colors.white)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
