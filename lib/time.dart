import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:intl/intl.dart';
import 'package:flutter_map/plugin_api.dart';
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
  MapController? _controller;

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
      _currentTime = formatter.format(now);
    });
  }

  @override
  Widget build(BuildContext context) {
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
    Color? bgColor = isDaytime ? Colors.blue : Colors.indigo[700];

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 24.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      widget.country.name!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 36.0,
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Column(
                      children: [
                        Text(
                          'Current Time',
                          style: TextStyle(
                            fontSize: 24.0,
                            color: Colors.grey[300],
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Column(
                          children: <Widget>[
                            Text(
                              _currentTime.substring(0, 10),
                              style: TextStyle(
                                fontSize: 48.0,
                                letterSpacing: 2.0,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              _currentTime.substring(11, 16),
                              style: TextStyle(
                                fontSize: 48.0,
                                letterSpacing: 2.0,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  FlutterMap(
                    options: MapOptions(
                      center: LatLng(
                        double.parse(widget.country.lat!.substring(0, 7)),
                        double.parse(widget.country.lng!.substring(0, 7)),
                      ),
                      zoom: 10,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                        subdomains: ['a', 'b', 'c'],
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            width: 80.0,
                            height: 80.0,
                            point: LatLng(
                              double.parse(widget.country.lat!.substring(0, 7)),
                              double.parse(widget.country.lng!.substring(0, 7)),
                            ),
                            builder: (ctx) => Container(
                              child: Icon(
                                Icons.location_pin,
                                size: 50,
                                color: Colors.redAccent,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
