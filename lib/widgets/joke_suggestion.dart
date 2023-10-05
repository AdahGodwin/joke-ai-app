import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jokes_ai_app/models/joke_suggestion_data.dart';
import 'package:jokes_ai_app/providers/chats_provider.dart';
import 'package:provider/provider.dart';

class JokeSuggestion extends StatelessWidget {
  JokeSuggestion(
      {Key? key, required this.selectedChatId, required this.showHome})
      : super(key: key);
  final String selectedChatId;
  final Function(bool value) showHome;
  final List<JokeSuggestionData> suggestedJokes = [
    JokeSuggestionData(jokeTitle: 'Tell the funniest dad joke you know'),
    JokeSuggestionData(jokeTitle: 'Give a random joke of old school mates'),
    JokeSuggestionData(
        jokeTitle: 'Can you give me a funny joke about countries and citizens'),
    JokeSuggestionData(jokeTitle: 'How much did the Romans enjoy jokes'),
    JokeSuggestionData(
        jokeTitle: 'This is the funniest thing you have heard all year'),
    JokeSuggestionData(
        jokeTitle:
            'Tell a joke to motivate a person to shake off the challenges and move on'),
    JokeSuggestionData(
        jokeTitle:
            'Magicians and Comedians, who makes the world a better place'),
    JokeSuggestionData(
        jokeTitle: 'A religious joke will be really interesting at the point'),
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
                  // onTap: () {},
                  onTap: () {
                    Provider.of<ChatsProvider>(context, listen: false)
                        .sendMessage({
                      "sender": "user1",
                      "message": suggestedJokes[index].jokeTitle,
                    }, selectedChatId, true);
                    Provider.of<ChatsProvider>(context, listen: false)
                        .sendRequest(
                            suggestedJokes[index].jokeTitle, selectedChatId);
                    showHome(false);
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
