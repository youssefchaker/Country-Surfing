import 'package:flutter/material.dart';
import 'package:test/shared/countrydrawer.dart';
import 'package:test/models/country.dart';
import 'package:test/shared/pagedrawer.dart';

class CountryRequest extends StatefulWidget {
  final Country country;
  CountryRequest({required this.country});
  @override
  _CountryRequestState createState() => _CountryRequestState();
}

class _CountryRequestState extends State<CountryRequest> {
  final List<String> countries = [
    'Algeria',
    'China',
    'Russia',
  ];
  String? selectedCountry;
  @override
  Widget build(BuildContext context) {
    if (countries.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text('Error')),
        body: Center(child: Text('Failed to load countries')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select a new country to add'),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(Icons.flag, color: Colors.white),
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
                icon: Icon(Icons.pages, color: Colors.white),
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
      body: ListView.builder(
        itemCount: countries.length,
        itemBuilder: (BuildContext context, int index) {
          String imagePath = 'assets/${countries[index].toLowerCase()}.png';
          return ListTile(
            leading: Image.asset(
              imagePath,
              height: 32,
              width: 32,
              errorBuilder:
                  (BuildContext context, Object error, StackTrace? stackTrace) {
                return Image.asset(
                  'assets/placeholder.png',
                  height: 32,
                  width: 32,
                );
              },
            ),
            title: Text(countries[index]),
            trailing:
                selectedCountry == countries[index] ? Icon(Icons.check) : null,
            onTap: () {
              setState(() {
                selectedCountry = countries[index];
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectedCountry == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Please select a country.')),
            );
          } else {
            Navigator.pop(context, selectedCountry);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Request successfully submitted.')),
            );
          }
        },
        child: Icon(Icons.check),
      ),
    );
  }
}
