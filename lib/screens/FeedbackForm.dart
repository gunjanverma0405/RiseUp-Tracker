import 'package:flutter/material.dart';

class FeedbackForm extends StatefulWidget {
  @override
  _FeedbackFormState createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  Sentiment selectedSentimentFeel = Sentiment.Neutral;
  Sentiment selectedSentimentRelevance = Sentiment.Neutral;

  Widget buildSentimentIcon(Sentiment sentiment) {
    IconData icon;
    Color color;

    switch (sentiment) {
      case Sentiment.VeryDissatisfied:
        icon = Icons.sentiment_very_dissatisfied;
        color = selectedSentimentFeel == Sentiment.VeryDissatisfied
            ? Colors.red
            : Colors.grey;
        break;
      case Sentiment.Dissatisfied:
        icon = Icons.sentiment_dissatisfied;
        color = selectedSentimentFeel == Sentiment.Dissatisfied
            ? Colors.orange
            : Colors.grey;
        break;
      case Sentiment.Neutral:
        icon = Icons.sentiment_neutral;
        color = selectedSentimentFeel == Sentiment.Neutral
            ? Colors.yellow
            : Colors.grey;
        break;
      case Sentiment.Satisfied:
        icon = Icons.sentiment_satisfied;
        color = selectedSentimentFeel == Sentiment.Satisfied
            ? Colors.lightGreen
            : Colors.grey;
        break;
      case Sentiment.VerySatisfied:
        icon = Icons.sentiment_very_satisfied;
        color = selectedSentimentFeel == Sentiment.VerySatisfied
            ? Colors.green
            : Colors.grey;
        break;
    }

    return IconButton(
      iconSize: 48,
      icon: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 36,
        ),
      ),
      onPressed: () {
        setState(() {
          selectedSentimentFeel = sentiment;
        });
      },
    );
  }

  Widget buildRelevanceIcon(Sentiment sentiment) {
    IconData icon;
    Color color;

    switch (sentiment) {
      case Sentiment.VeryDissatisfied:
        icon = Icons.sentiment_very_dissatisfied;
        color = selectedSentimentRelevance == Sentiment.VeryDissatisfied
            ? Colors.red
            : Colors.grey;
        break;
      case Sentiment.Dissatisfied:
        icon = Icons.sentiment_dissatisfied;
        color = selectedSentimentRelevance == Sentiment.Dissatisfied
            ? Colors.orange
            : Colors.grey;
        break;
      case Sentiment.Neutral:
        icon = Icons.sentiment_neutral;
        color = selectedSentimentRelevance == Sentiment.Neutral
            ? Colors.yellow
            : Colors.grey;
        break;
      case Sentiment.Satisfied:
        icon = Icons.sentiment_satisfied;
        color = selectedSentimentRelevance == Sentiment.Satisfied
            ? Colors.lightGreen
            : Colors.grey;
        break;
      case Sentiment.VerySatisfied:
        icon = Icons.sentiment_very_satisfied;
        color = selectedSentimentRelevance == Sentiment.VerySatisfied
            ? Colors.green
            : Colors.grey;
        break;
    }

    return IconButton(
      iconSize: 48,
      icon: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 36,
        ),
      ),
      onPressed: () {
        setState(() {
          selectedSentimentRelevance = sentiment;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('Feedback Form'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'How did you feel about the session?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildSentimentIcon(Sentiment.VeryDissatisfied),
                buildSentimentIcon(Sentiment.Dissatisfied),
                buildSentimentIcon(Sentiment.Neutral),
                buildSentimentIcon(Sentiment.Satisfied),
                buildSentimentIcon(Sentiment.VerySatisfied),
              ],
            ),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'How relevant do you think the session was?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildRelevanceIcon(Sentiment.VeryDissatisfied),
                buildRelevanceIcon(Sentiment.Dissatisfied),
                buildRelevanceIcon(Sentiment.Neutral),
                buildRelevanceIcon(Sentiment.Satisfied),
                buildRelevanceIcon(Sentiment.VerySatisfied),
              ],
            ),
            SizedBox(height: 40),
            ElevatedButton(
              child: Text('Submit'),
              onPressed: () {
                showThankYouDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void showThankYouDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text('Thank you for your valuable feedback!'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

enum Sentiment {
  VeryDissatisfied,
  Dissatisfied,
  Neutral,
  Satisfied,
  VerySatisfied,
}
