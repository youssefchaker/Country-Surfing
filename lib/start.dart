import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test/models/country.dart';

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
      appBar: AppBar(
        title: const Text('Choose a Country'),
        backgroundColor: Colors.blueGrey[800],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('countries').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
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
                title: Text(key),
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
        onPressed: () async {
          if (selectedCountry.isNotEmpty) {
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
          }
        },
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
