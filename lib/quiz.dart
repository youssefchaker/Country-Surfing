import 'package:flutter/material.dart';
import 'package:test/models/country.dart';

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

  void _checkAnswer(int? selectedIndex) {
    if (selectedIndex == widget.country.answers![_questionIndex]) {
      setState(() {
        _score++;
        _questionIndex++;
      });
    } else {
      setState(() {
        _questionIndex++;
      });
    }
  }

  void _restartQuiz() {
    setState(() {
      _questionIndex = 0;
      _score = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Question> questions = widget.country.questions!
        .map((q) => Question(q, widget.country.choices![_questionIndex]))
        .toList();
    questions.shuffle();

    if (_questionIndex >= questions.length) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your score: $_score / ${questions.length}',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _restartQuiz,
              child: Text('Retry'),
            ),
          ],
        ),
      );
    }

    Question currentQuestion = questions[_questionIndex];

    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            currentQuestion.question,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          ...currentQuestion.choices!.asMap().entries.map((entry) {
            int index = entry.key;
            String choice = entry.value;

            return RadioListTile<int>(
              title: Text(choice),
              value: index,
              groupValue: null,
              onChanged: _checkAnswer,
            );
          }).toList(),
        ],
      ),
    );
  }
}
