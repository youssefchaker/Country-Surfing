import 'package:flutter/material.dart';

class CountryQuizResultsScreen extends StatelessWidget {
  final int score;
  final int totalQuestions;
  final VoidCallback onRetry;

  const CountryQuizResultsScreen({
    Key? key,
    required this.score,
    required this.totalQuestions,
    required this.onRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String message = '';
    IconData icon = Icons.sentiment_very_dissatisfied;

    if (score == totalQuestions) {
      message = 'Excellent!';
      icon = Icons.sentiment_very_satisfied;
    } else if (score >= 7 && score <= 9) {
      message = 'Nice!';
      icon = Icons.sentiment_satisfied;
    } else if (score >= 4 && score <= 6) {
      message = 'Medium';
      icon = Icons.sentiment_neutral;
    } else {
      message = 'Low';
      icon = Icons.sentiment_very_dissatisfied;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Results'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 80.0,
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(height: 16),
                Text(
                  'Your score: $score / $totalQuestions',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  message,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Return to main page'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
