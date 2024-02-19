import 'package:flutter/material.dart';
import './logo_text.dart';

class WelcomeTemplate extends StatelessWidget {
  const WelcomeTemplate({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        LogoText(),
        SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.flash_on,
              color: Colors.orange,
            ),
            Text(
              "Capabilities",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Card(
          margin: EdgeInsets.all(10),
          elevation: 3,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              "Tells Jokes on different topics",
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Card(
          margin: EdgeInsets.all(10),
          elevation: 3,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              "Trained to tell Jokes and be a friendly chat bot",
              textAlign: TextAlign.center,
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.lightbulb_outline,
              color: Colors.blue,
            ),
            Text(
              "Suggestions",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Card(
          margin: EdgeInsets.all(10),
          elevation: 3,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              "Why don't Nigerian witches ride brooms?",
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Card(
          margin: EdgeInsets.all(10),
          elevation: 3,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              "Why did the yam blush?",
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Card(
          margin: EdgeInsets.all(10),
          elevation: 3,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              "Who made you like this?",
              textAlign: TextAlign.center,
            ),
          ),
        ),
        // const Spacer(),
      ],
    );
  }
}
