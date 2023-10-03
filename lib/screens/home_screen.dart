import 'package:flutter/material.dart';
import 'package:jokes_ai_app/widgets/joke_suggestion.dart';
import 'package:jokes_ai_app/widgets/new_message.dart';
import 'package:jokes_ai_app/widgets/scrolling_cards.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.openDrawer,
    required this.closeDrawer,
    required this.isDrawerOpen,
    required this.selectedChatId,
  });
  final VoidCallback openDrawer;
  final VoidCallback closeDrawer;
  final bool isDrawerOpen;
  final String selectedChatId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              child: const Text(
                "JOKES",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              width: 25,
              height: 25,
              padding: const EdgeInsets.all(4),
              color: Colors.blue,
              child: const Center(
                child: Text(
                  "AI",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.grey[100],
                  ),
                  padding: const EdgeInsets.all(4.0),
                  child: IconButton(
                    icon: Image.asset('assets/icons/menu-icon.png'),
                    onPressed: isDrawerOpen ? closeDrawer : openDrawer,
                  ),
                ),
                const Text(
                  'Good Morning Godwin!',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                const Text('You have several jokes, pick below to continue'),
                const SizedBox(
                  height: 20.0,
                ),
                ScrollingCards(),
                const SizedBox(
                  height: 20.0,
                ),
                const Text(
                  'Suggested Jokes',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                const Text('Ask for a joke and get a cool response'),
                const SizedBox(
                  height: 20,
                ),
                Expanded(child: JokeSuggestion()),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                height: 60,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                    color: Colors.white),
                child: NewMessage(
                  chatId: selectedChatId,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
