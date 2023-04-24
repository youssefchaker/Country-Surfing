import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:intl/intl.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:test/models/country.dart';
import 'package:test/shared/countrydrawer.dart';
import 'package:test/shared/pagedrawer.dart';

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
    final int timezone = int.parse(widget.country.timezone!.substring(3, 5));
    final now = DateTime.now().toUtc().add(Duration(hours: timezone));
    final formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    setState(() {
      _currentTime = formatter.format(now);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[800],
      appBar: AppBar(
        title: Center(child: Text('Country Time and Map')),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(Icons.language, color: Colors.white),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: <Widget>[
          Builder(
            builder: (context) {
              return IconButton(
                icon: Icon(Icons.auto_awesome_motion_outlined,
                    color: Colors.white),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              );
            },
          )
        ],
        backgroundColor: Colors.blueGrey[800],
      ),
      drawer: CountryDrawer(),
      endDrawer: PageDrawer(country: widget.country),
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
                        fontSize: 30.0,
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Column(
                      children: [
                        SizedBox(height: 8.0),
                        Column(
                          children: <Widget>[
                            Text(
                              _currentTime.substring(0, 10) ??
                                  'Error loading time.Please make sure you are connected to the Internet',
                              style: TextStyle(
                                fontSize: 40.0,
                                letterSpacing: 2.0,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              _currentTime.substring(11, 16) ?? '',
                              style: TextStyle(
                                fontSize: 48.0,
                                letterSpacing: 2.0,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
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
                  _buildMap(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMap() {
    final lat = double.tryParse(widget.country.lat?.substring(0, 7) ?? '');
    final lng = double.tryParse(widget.country.lng?.substring(0, 7) ?? '');

    if (lat == null || lng == null) {
      return Center(
        child: Text(
          'Error loading map.Please make sure you are connected to the Internet',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
      );
    }

    return FlutterMap(
      options: MapOptions(
        center: LatLng(lat, lng),
        zoom: 10,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: ['a', 'b', 'c'],
        ),
        MarkerLayer(
          markers: [
            Marker(
              width: 80.0,
              height: 80.0,
              point: LatLng(lat, lng),
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
    );
  }
}
