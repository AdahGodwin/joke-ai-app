import 'package:flutter/material.dart';
import 'package:jokes_ai_app/widgets/joke_suggestion.dart';
import 'package:jokes_ai_app/widgets/new_message.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({
    super.key,
  });
  // final String selectedChatId;

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
              Container(
                decoration: const BoxDecoration(color: Colors.yellowAccent),
                height: 200,
                child: const Center(
                  child: Text('Customize widget here'),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              const Text('Suggested Jokes'),
              const Text('Ask for a joke and get a cool response'),
              const SizedBox(
                height: 20,
              ),
              Expanded(child: JokeSuggestion()),
              NewMessage(chatId: selectedChatId)
            ],
          ),
        ));
  }
}
