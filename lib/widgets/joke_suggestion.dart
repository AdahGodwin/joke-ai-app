import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jokes_ai_app/models/joke_suggestion_data.dart';

class JokeSuggestion extends StatelessWidget {
  JokeSuggestion({Key? key}) : super(key: key);

  final List<JokeSuggestionData> suggestedJokes = [
    JokeSuggestionData(
        jokeTitle: 'This is the funniest thing you have heard all year'),
    JokeSuggestionData(
        jokeTitle: 'Do you know you can go from your house to Greece in 2hrs'),
    JokeSuggestionData(
        jokeTitle: 'This is the funniest thing you have heard all year'),
    JokeSuggestionData(
        jokeTitle: 'Do you know you can go from your house to Greece in 2hrs'),
    JokeSuggestionData(
        jokeTitle: 'This is the funniest thing you have heard all year'),
    JokeSuggestionData(
        jokeTitle: 'Do you know you can go from your house to Greece in 2hrs'),
    JokeSuggestionData(
        jokeTitle: 'This is the funniest thing you have heard all year'),
    JokeSuggestionData(
        jokeTitle: 'Do you know you can go from your house to Greece in 2hrs'),
  ];

  @override
  Widget build(BuildContext context) {
    Random random = Random();
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: suggestedJokes.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color((random.nextDouble() * 0xFFFFFF).toInt())
                      .withOpacity(1.0),
                ),
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(
                    suggestedJokes[index].jokeTitle,
                    style: const TextStyle(color: Colors.white),
                  ),
                  trailing: Transform.scale(
                    scale: 0.8,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_forward),
                    ),
                  ),
                  onTap: () {},
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
