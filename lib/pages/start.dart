import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test/models/country.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:convert';

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  String selectedCountry = "";

  List<String> countryList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: const Text('Choose a Country'),
        backgroundColor: Colors.blueGrey[800],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('countries').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          List<Widget> countryList = [];

          snapshot.data!.docs.forEach((document) {
            Map<String, dynamic> countryData =
                document.data() as Map<String, dynamic>;

            countryData.forEach((key, value) {
              countryList.add(ListTile(
                leading: Image.network(
                  value["flag"],
                  width: 50,
                  height: 50,
                ),
                title: Text(
                  key,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                trailing: selectedCountry == key
                    ? const Icon(Icons.check, color: Colors.green)
                    : null,
                onTap: () {
                  setState(() {
                    selectedCountry = key;
                  });
                },
              ));
            });
          });

          return ListView(
            children: countryList,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink[400],
        onPressed: () async {
          if (selectedCountry.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Please select a country.'),
                duration: Duration(seconds: 2),
              ),
            );
            return;
          }

          try {
            String name = "";
            String flag = "";
            String description = "";
            String lat = "";
            String lng = "";
            String capital = "";
            List<List<String>> choices = [[]];
            choices.clear();
            List<int> answers = [];
            List<String> questions = [];
            List<String> images = [];
            String timezone = "";
            CollectionReference<Map<String, dynamic>> countriesRef =
                FirebaseFirestore.instance.collection('countries');
            QuerySnapshot<Map<String, dynamic>> querySnapshot =
                await countriesRef.get();
            querySnapshot.docs.forEach((doc) {
              doc.data().forEach((key, value) {
                if (key == selectedCountry) {
                  name = key;
                  flag = value["flag"];
                  lat = value["lat"];
                  lng = value["lng"];
                  capital = value["capital"];
                  description = value["description"];
                  timezone = value["timezone"];
                  images = List<String>.from(value['pictures'] as List);
                  value["quizQuestions"].forEach((val) {
                    List<String> ch = [];
                    val["answers"].forEach((ans) {
                      ch.add(ans);
                    });
                    answers.add(val["correctAnswer"]);
                    questions.add(val["question"]);
                    choices.add(ch);
                  });
                }
              });
            });
            Country cnt = Country(
                name: name,
                flag: flag,
                description: description,
                images: images,
                choices: choices,
                answers: answers,
                questions: questions,
                timezone: timezone,
                lat: lat,
                lng: lng,
                capital: capital);
            Navigator.pushNamed(context, '/info', arguments: cnt);
          } catch (e) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Error'),
                  content:
                      const Text('Cannot retrieve countries from database.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('OK'),
                    ),
                  ],
                );
              },
            );
          }
        },
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
