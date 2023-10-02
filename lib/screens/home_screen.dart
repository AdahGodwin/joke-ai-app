import 'package:flutter/material.dart';
import 'package:jokes_ai_app/widgets/joke_suggestion.dart';
import 'package:jokes_ai_app/widgets/new_message.dart';
import 'package:jokes_ai_app/widgets/scrolling_cards.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({
    super.key,
  });

  String selectedChatId = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home Screen'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Good Morning Samuel!'),
              const Text('You have several jokes, pick below to continue'),
              const SizedBox(
                height: 20.0,
              ),
              ScrollingCards(),
              const SizedBox(
                height: 20.0,
              ),
              const Text('Suggested Jokes'),
              const Text('Ask for a joke and get a cool response'),
              const SizedBox(
                height: 20,
              ),
              Expanded(child: JokeSuggestion()),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                height: 60,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
                child: NewMessage(
                  chatId: selectedChatId,
                ),
              ),
            ],
          ),
        ));
  }
}
