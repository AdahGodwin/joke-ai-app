import 'package:flutter/material.dart';

class WelcomeTemplate extends StatelessWidget {
  const WelcomeTemplate({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              child: const Text(
                "JOKES",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              width: 40,
              height: 40,
              padding: const EdgeInsets.all(4),
              color: Colors.blue,
              child: const Center(
                child: Text(
                  "AI",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 50,
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.flash_on,
              color: Colors.orange,
            ),
            Text(
              "Capabilities",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
        const Card(
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
        const Card(
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
        const SizedBox(
          height: 30,
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.lightbulb_outline,
              color: Colors.blue,
            ),
            Text(
              "Suggestions",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
        const Card(
          margin: EdgeInsets.all(10),
          elevation: 3,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              "Tell A Joke about fishes",
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const Card(
          margin: EdgeInsets.all(10),
          elevation: 3,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              "Write a Joke about ShakeSpeare",
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
