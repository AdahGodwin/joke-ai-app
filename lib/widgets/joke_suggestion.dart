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
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: suggestedJokes.length,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.all(8.0),
                color: Colors.lightBlue[50],
                child: ListTile(
                  title: Text(suggestedJokes[index].jokeTitle),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_forward),
                  ),
                  onTap: () {
                    // print('ListTile tapped');
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
