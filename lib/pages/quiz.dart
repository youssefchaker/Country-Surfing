import 'package:flutter/material.dart';
import 'package:test/models/country.dart';
import 'package:test/pages/quizresult.dart';
import 'package:test/shared/countrydrawer.dart';
import 'package:test/shared/pagedrawer.dart';

class Question {
  final String question;
  final List<String>? choices;

  Question(
    this.question,
    this.choices,
  );
}

class CountryQuiz extends StatefulWidget {
  final Country country;

  CountryQuiz({required this.country});

  @override
  _CountryQuizState createState() => _CountryQuizState();
}

class _CountryQuizState extends State<CountryQuiz> {
  int _questionIndex = 0;
  int? groupValue;
  int _score = 0;
  late List<Question> questions;

  @override
  void initState() {
    int qindex = 0;
    super.initState();
    questions = widget.country.questions!.map((q) {
      var question = Question(q, widget.country.choices![_questionIndex]);
      _questionIndex++;
      return question;
    }).toList();
    questions.shuffle();
    _questionIndex = 0;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _checkAnswer() {
    if (groupValue == null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Please select an answer'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    if (groupValue == widget.country.answers![_questionIndex]) {
      setState(() {
        _score++;
      });
    }

    if (_questionIndex < questions.length - 1) {
      setState(() {
        _questionIndex++;
        groupValue = null;
      });
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => CountryQuizResultsScreen(
            score: _score,
            totalQuestions: questions.length,
            country: widget.country,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.country.questions == null || widget.country.choices == null) {
      return Scaffold(
        backgroundColor: Colors.grey[800],
        body: Center(
          child: Text(
              'Quiz not found.Please make sure you are connected to the Internet'),
        ),
      );
    }

    Question currentQuestion;
    try {
      currentQuestion = questions[_questionIndex];
    } catch (e) {
      return Scaffold(
        body: Center(
          child: Text(
              'Failed to load quiz question.Please make sure you are connected to the Internet'),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: Center(child: Text('Country Quiz')),
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
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                currentQuestion.question,
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(height: 16),
              Flexible(
                child: ListView(
                  children:
                      currentQuestion.choices!.asMap().entries.map((entry) {
                    int index = entry.key;
                    String choice = entry.value;

                    return RadioListTile<int>(
                      title: Text(
                        choice,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      value: index,
                      groupValue: groupValue,
                      onChanged: (value) {
                        setState(() {
                          groupValue = value;
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink[400],
                ),
                onPressed: _checkAnswer,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
